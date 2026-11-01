import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/color_utils.dart';
import '../../../core/models.dart';
import '../../../core/own_colors.dart';
import '../../../core/white_balance.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/page_header.dart';
import '../match/color_sampling.dart';
import '../match/image_picker_service.dart';
import '../match/photo_box.dart';
import '../match/photo_sampling.dart';

/// Where the user sets the colour a marker really gives on paper.
///
/// The colour comes from a typed hex, or from a photo of the painted swatch:
/// pick or take the photo, optionally fix its white balance, then tap the
/// painted area (the same area average and reticle as Match). The page pops
/// with the chosen colour (six lower-case hex digits) or with `null` when the
/// user leaves without saving. The photo is only read to get that colour: it is
/// never stored or sent anywhere.
class OwnColorPage extends StatefulWidget {
  const OwnColorPage({
    super.key,
    required this.color,
    this.picker,
    this.decoder,
  });

  /// The marker. Its [MarkerColor.hex] is the colour in force and
  /// [MarkerColor.originalHex] the catalogue's.
  final MarkerColor color;

  /// Photo picker. Production wraps `image_picker`; tests inject a fake.
  final ImagePickerService? picker;

  /// Decoder from encoded photo bytes to raw pixels. Tests inject a fake.
  final PhotoDecoder? decoder;

  /// Opens the page and returns the colour the user saved, if they did.
  static Future<String?> open(
    BuildContext context,
    MarkerColor color, {
    ImagePickerService? picker,
    PhotoDecoder? decoder,
  }) => Navigator.of(context).push<String>(
    MaterialPageRoute<String>(
      builder: (BuildContext context) =>
          OwnColorPage(color: color, picker: picker, decoder: decoder),
    ),
  );

  @override
  State<OwnColorPage> createState() => _OwnColorPageState();
}

class _OwnColorPageState extends State<OwnColorPage> {
  late final TextEditingController _hex = TextEditingController(
    text: _bare(widget.color.hex).toUpperCase(),
  );
  late final ImagePickerService _picker =
      widget.picker ?? PlatformImagePickerService();
  late final PhotoDecoder _decode = widget.decoder ?? decodePhoto;

  Uint8List? _bytes;
  SampledImage? _sampled;
  Offset? _pick;
  Color? _sampleColor;
  WhiteBalance? _balance;
  bool _choosingWhite = false;
  WhiteBalanceRejection? _whiteRejection;
  bool _picking = false;
  String? _error;

  static String _bare(String hex) =>
      hex.startsWith('#') ? hex.substring(1) : hex;

  @override
  void dispose() {
    _hex.dispose();
    super.dispose();
  }

  /// The colour typed or sampled, when it is a valid hex.
  String? get _chosen => normalizeOwnHex(_hex.text);

  // ---------------------------------------------------------------------------
  // Photo
  // ---------------------------------------------------------------------------

  Future<void> _pickPhoto(PhotoSource source) async {
    if (_picking) return;
    setState(() {
      _picking = true;
      _error = null;
    });
    final PhotoPickResult result = await _picker.pick(source);
    if (!mounted) return;
    switch (result) {
      case PhotoPicked(:final Uint8List bytes):
        await _loadPhoto(bytes);
      case PhotoPickCancelled():
        setState(() => _picking = false);
      case PhotoPickDenied(:final PhotoSource source):
        setState(() {
          _picking = false;
          _error = source == PhotoSource.camera
              ? context.l10n.matchCameraDenied
              : context.l10n.matchGalleryDenied;
        });
      case PhotoPickFailed():
        setState(() {
          _picking = false;
          _error = context.l10n.matchPickFailed;
        });
    }
  }

  Future<void> _loadPhoto(Uint8List bytes) async {
    SampledImage sampled;
    try {
      sampled = await _decode(bytes);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _picking = false;
        _error = context.l10n.matchDecodeFailed;
      });
      return;
    }
    if (!mounted) return;
    setState(() {
      _bytes = bytes;
      _sampled = sampled;
      _pick = null;
      _sampleColor = null;
      _balance = null;
      _choosingWhite = false;
      _whiteRejection = null;
      _picking = false;
      _error = null;
    });
  }

  int _colorAt(SampledImage sampled, Offset fraction) {
    final int raw = averageColorOfRegion(sampled, fraction);
    return _balance?.apply(raw) ?? raw;
  }

  void _onPhotoPoint(Offset fraction) {
    final SampledImage? sampled = _sampled;
    if (sampled == null) return;
    if (_choosingWhite) {
      switch (WhiteBalanceFit.fromReference(
        averageColorOfRegion(sampled, fraction),
      )) {
        case WhiteBalanceApplied(:final WhiteBalance balance):
          setState(() {
            _balance = balance;
            _choosingWhite = false;
            _whiteRejection = null;
            _resample();
          });
        case WhiteBalanceRejected(:final WhiteBalanceRejection reason):
          setState(() => _whiteRejection = reason);
      }
      return;
    }
    final int colorInt = _colorAt(sampled, fraction);
    setState(() {
      _pick = fraction;
      _useSample(colorInt);
    });
  }

  /// Takes the sample again after the white balance changed.
  void _resample() {
    final SampledImage? sampled = _sampled;
    final Offset? pick = _pick;
    if (sampled == null || pick == null) return;
    _useSample(_colorAt(sampled, pick));
  }

  void _useSample(int colorInt) {
    _sampleColor = Color(0xFF000000 | colorInt);
    _hex.value = TextEditingValue(
      text: colorIntToHex(colorInt),
      selection: TextSelection.collapsed(offset: 6),
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final MarkerColor color = widget.color;
    final String? chosen = _chosen;
    final bool invalid = _hex.text.trim().isNotEmpty && chosen == null;
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.ownColorTitle(color.newCode))),
      body: SafeArea(
        child: SingleChildScrollView(
          key: const ValueKey<String>('own-color-page'),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(
            InkSpacing.gutter,
            InkSpacing.group,
            InkSpacing.gutter,
            InkSpacing.pageBottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                color.newName,
                style: AppTypography.secondary.copyWith(color: ink.fg2),
              ),
              const SizedBox(height: InkSpacing.block),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: _Compare(
                      label: context.l10n.swatchesCatalogueLabel,
                      hex: color.originalHex,
                    ),
                  ),
                  const SizedBox(width: InkSpacing.buttonGap),
                  Expanded(
                    child: _Compare(
                      key: const ValueKey<String>('own-color-preview'),
                      label: context.l10n.swatchesMineLabel,
                      hex: chosen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: InkSpacing.block),
              TextField(
                key: const ValueKey<String>('own-color-hex'),
                controller: _hex,
                autocorrect: false,
                enableSuggestions: false,
                textCapitalization: TextCapitalization.characters,
                keyboardType: TextInputType.visiblePassword,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9a-fA-F#]')),
                  LengthLimitingTextInputFormatter(7),
                ],
                style: AppTypography.code.copyWith(color: ink.fg),
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  labelText: context.l10n.ownColorHexLabel,
                  prefixText: '#',
                  errorText: invalid ? context.l10n.ownColorHexInvalid : null,
                  errorMaxLines: 3,
                ),
              ),
              const SizedBox(height: InkSpacing.section),
              InkSectionHeading(context.l10n.ownColorPhotoTitle),
              const SizedBox(height: InkSpacing.group),
              Text(
                context.l10n.ownColorPhotoHelp,
                style: AppTypography.secondary.copyWith(color: ink.fg2),
              ),
              const SizedBox(height: InkSpacing.block),
              _buildPhoto(context),
              if (_bytes != null && _sampled != null) ...<Widget>[
                const SizedBox(height: InkSpacing.group),
                WhiteBalanceBar(
                  balance: _balance,
                  choosing: _choosingWhite,
                  rejection: _whiteRejection,
                  onStart: () => setState(() {
                    _choosingWhite = true;
                    _whiteRejection = null;
                  }),
                  onCancel: () => setState(() {
                    _choosingWhite = false;
                    _whiteRejection = null;
                  }),
                  onReset: () => setState(() {
                    _balance = null;
                    _whiteRejection = null;
                    _resample();
                  }),
                ),
                if (!_choosingWhite && _pick == null) ...<Widget>[
                  const SizedBox(height: InkSpacing.group),
                  Text(
                    context.l10n.ownColorPhotoTap,
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                ],
              ],
              if (_error != null) ...<Widget>[
                const SizedBox(height: InkSpacing.group),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkIcon(
                      InkIcons.alertCircle,
                      size: InkGeometry.smallIcon,
                      color: ink.error,
                    ),
                    const SizedBox(width: InkSpacing.s8),
                    Expanded(
                      child: Text(
                        _error!,
                        style: AppTypography.secondary.copyWith(color: ink.fg),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: InkSpacing.block),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkButton.secondary(
                      key: const ValueKey<String>('own-color-camera'),
                      label: context.l10n.matchCameraButton,
                      icon: InkIcons.camera,
                      expand: true,
                      onPressed: _picking
                          ? null
                          : () => _pickPhoto(PhotoSource.camera),
                    ),
                  ),
                  const SizedBox(width: InkSpacing.buttonGap),
                  Expanded(
                    child: InkButton.secondary(
                      key: const ValueKey<String>('own-color-gallery'),
                      label: context.l10n.matchGalleryButton,
                      icon: InkIcons.image,
                      expand: true,
                      onPressed: _picking
                          ? null
                          : () => _pickPhoto(PhotoSource.gallery),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: InkSpacing.group),
              Row(
                children: <Widget>[
                  InkIcon(
                    InkIcons.lock,
                    size: InkGeometry.smallIcon,
                    color: ink.fg2,
                  ),
                  const SizedBox(width: InkSpacing.s8),
                  Expanded(
                    child: Text(
                      context.l10n.matchPrivacyCaption,
                      style: AppTypography.secondary.copyWith(color: ink.fg2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: InkSpacing.section),
              InkButton(
                key: const ValueKey<String>('own-color-save'),
                label: context.l10n.ownColorSave,
                expand: true,
                onPressed: chosen == null
                    ? null
                    : () => Navigator.of(context).pop(chosen),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoto(BuildContext context) {
    final bool hasPhoto = _bytes != null && _sampled != null;
    if (!hasPhoto) return const SizedBox.shrink();
    return PhotoBox(
      aspectRatio: _sampled!.aspectRatio,
      child: PhotoSampleCanvas(
        gestureKey: const ValueKey<String>('own-color-canvas'),
        bytes: _bytes!,
        image: _sampled!,
        onPoint: _onPhotoPoint,
        tapOnly: _choosingWhite,
        balance: _balance,
        pick: _choosingWhite ? null : _pick,
        sampleColor: _sampleColor,
      ),
    );
  }
}

/// A labelled colour block with its hex, for the catalogue / mine comparison.
class _Compare extends StatelessWidget {
  const _Compare({super.key, required this.label, required this.hex});

  final String label;

  /// The colour, or `null` for an empty block.
  final String? hex;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final String? value = hex;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppTypography.caps(label),
          style: AppTypography.capsStyle.copyWith(color: ink.fg2),
        ),
        const SizedBox(height: InkSpacing.s4),
        value == null
            ? Container(
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: InkRadii.controlRadius,
                  border: Border.all(color: ink.line),
                ),
              )
            : SwatchBlock(hex: value, height: 56, width: double.infinity),
        const SizedBox(height: InkSpacing.s4),
        Text(
          value == null ? ' ' : displayHex(value),
          style: AppTypography.data.copyWith(color: ink.fg2),
        ),
      ],
    );
  }
}
