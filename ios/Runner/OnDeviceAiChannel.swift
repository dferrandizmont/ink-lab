import Flutter
import Foundation

#if canImport(FoundationModels)
  import FoundationModels
#endif

/// Bridge between Dart and the on-device Apple Foundation Models language
/// model (Apple Intelligence).
///
/// Everything runs locally: the system owns the model and its download, and
/// this path never opens a network connection of its own. No call here throws
/// to Dart for an expected failure: `status` degrades to "unavailable", and
/// `generate` answers with a typed error code that Dart maps to a fallback.
/// Prompts and replies are never logged or kept; each `generate` uses a fresh
/// session that is dropped when the call ends.
///
/// Methods on `ink_lab/on_device_ai` (same contract as Android):
///  - `status`   -> "unavailable" | "notEnabled" | "downloadable" | "downloading" | "available"
///  - `download` -> the current status. iOS has no app-driven download: the
///                  system fetches the model on its own, so there is no event
///                  channel and nothing to start.
///  - `generate` -> the generated text (argument: the prompt string)
///  - `cancelDownload` -> nothing to cancel on iOS
///  - `cancel`   -> cancels the running `generate`, if any
final class OnDeviceAiChannel: NSObject {
  private static let methodChannel = "ink_lab/on_device_ai"
  private static let generateTimeoutNanos: UInt64 = 30_000_000_000
  private static let unavailable = "unavailable"
  private static let notEnabled = "notEnabled"

  private let methods: FlutterMethodChannel

  // Only touched from the main thread, where Flutter delivers method calls.
  private var generateTask: Task<Void, Never>?
  private var timeoutTask: Task<Void, Never>?

  init(messenger: FlutterBinaryMessenger) {
    methods = FlutterMethodChannel(
      name: OnDeviceAiChannel.methodChannel,
      binaryMessenger: messenger
    )
    super.init()
    methods.setMethodCallHandler { [weak self] call, result in
      self?.handle(call, result: result)
    }
  }

  func dispose() {
    methods.setMethodCallHandler(nil)
    cancelGenerate()
  }

  private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "status", "download":
      result(currentStatus())
    case "generate":
      generate(call.arguments as? String, result: result)
    case "cancelDownload":
      result(nil)
    case "cancel":
      cancelGenerate()
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  /// One of "unavailable", "notEnabled", "downloadable", "downloading",
  /// "available".
  private func currentStatus() -> String {
    #if canImport(FoundationModels)
      if #available(iOS 26.0, *) {
        return OnDeviceAiChannel.modelStatus()
      }
    #endif
    return OnDeviceAiChannel.unavailable
  }

  private func generate(_ prompt: String?, result: @escaping FlutterResult) {
    #if canImport(FoundationModels)
      if #available(iOS 26.0, *) {
        guard let prompt = prompt, !prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
          result(FlutterError(code: "invalid_prompt", message: "The prompt is empty", details: nil))
          return
        }
        guard OnDeviceAiChannel.modelStatus() == "available" else {
          result(FlutterError(code: "unavailable", message: "Apple Intelligence is not ready", details: nil))
          return
        }
        cancelGenerate()
        run(prompt: prompt, reply: OneShot(result))
        return
      }
    #endif
    result(FlutterError(code: "unavailable", message: "Foundation Models needs iOS 26 or newer", details: nil))
  }

  private func cancelGenerate() {
    generateTask?.cancel()
    timeoutTask?.cancel()
    generateTask = nil
    timeoutTask = nil
  }

  #if canImport(FoundationModels)
    /// Maps the system model availability to the Dart status strings.
    ///  - available                       -> "available"
    ///  - unavailable(.modelNotReady)     -> "downloading": the system is still
    ///    fetching or preparing the model; the app cannot speed it up, so Dart
    ///    shows a disabled "downloading" state with a "check again" action.
    ///  - unavailable(.appleIntelligenceNotEnabled) -> "notEnabled": the phone
    ///    can run it but the user switched Apple Intelligence off. The app cannot
    ///    switch it on, so Dart keeps the provider hidden and tells the user
    ///    where to turn it on.
    ///  - deviceNotEligible,
    ///    anything unknown                -> "unavailable": the app cannot fix
    ///    it, so the provider stays hidden. "downloadable" is never used,
    ///    because it would offer a download button that has nothing to start.
    @available(iOS 26.0, *)
    private static func modelStatus() -> String {
      switch SystemLanguageModel.default.availability {
      case .available:
        return "available"
      case .unavailable(.modelNotReady):
        return "downloading"
      case .unavailable(.appleIntelligenceNotEnabled):
        return notEnabled
      case .unavailable:
        return unavailable
      @unknown default:
        return unavailable
      }
    }

    @available(iOS 26.0, *)
    private func run(prompt: String, reply: OneShot) {
      let work = Task {
        do {
          // A fresh session per call: no history, nothing kept afterwards.
          let session = LanguageModelSession()
          let text = try await session.respond(to: prompt).content
          if Task.isCancelled {
            reply.error("cancelled", "The request was cancelled")
          } else if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            reply.error("empty", "The model returned no text")
          } else {
            reply.success(text)
          }
        } catch {
          if Task.isCancelled || error is CancellationError {
            reply.error("cancelled", "The request was cancelled")
          } else {
            // The type name only: error descriptions could echo the prompt.
            reply.error("generate_failed", String(describing: type(of: error)))
          }
        }
      }
      let timer = Task {
        do {
          try await Task.sleep(nanoseconds: OnDeviceAiChannel.generateTimeoutNanos)
        } catch {
          return
        }
        // The first answer wins; if the model finishes first this is a no-op.
        reply.error("timeout", "The model took too long")
        work.cancel()
      }
      generateTask = work
      timeoutTask = timer
      // Whichever answers first stops the other, so neither outlives the call.
      reply.whenSent {
        work.cancel()
        timer.cancel()
      }
    }
  #endif
}

/// Answers a Flutter call exactly once, on the main thread, from any thread.
private final class OneShot: @unchecked Sendable {
  private let lock = NSLock()
  private var result: FlutterResult?
  private var sent = false
  private var onSent: (() -> Void)?

  init(_ result: @escaping FlutterResult) {
    self.result = result
  }

  func success(_ value: String) {
    send(value)
  }

  func error(_ code: String, _ message: String) {
    send(FlutterError(code: code, message: message, details: nil))
  }

  /// Runs [action] once the answer has gone out (at once if it already has).
  func whenSent(_ action: @escaping () -> Void) {
    lock.lock()
    if sent {
      lock.unlock()
      action()
      return
    }
    onSent = action
    lock.unlock()
  }

  private func send(_ value: Any?) {
    lock.lock()
    let pending = result
    result = nil
    sent = true
    let after = onSent
    onSent = nil
    lock.unlock()
    guard let pending = pending else { return }
    DispatchQueue.main.async { pending(value) }
    after?()
  }
}
