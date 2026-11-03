package dev.inklab.ink_lab

import android.app.AlarmManager
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Color
import android.net.Uri
import android.os.Bundle
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetProvider
import java.util.Calendar
import java.util.Locale
import org.json.JSONObject

/**
 * The "Idea of the day" home-screen widget.
 *
 * The app writes every idea of the catalogue as one JSON string (key
 * [DATA_KEY] of the `home_widget` preferences, see `lib/data/idea_widget_sync.dart`)
 * whenever it starts, comes to the front or the language / collection changes.
 * This provider picks today's idea from that list itself, by the LOCAL date, so
 * the widget is right every day without the app running. The index is the one
 * of `IdeasEngine.featuredFor`: whole days since the epoch of the JSON
 * (2024-01-01) modulo the number of ideas.
 *
 * Refresh, with no permission at all: the system's hourly `updatePeriodMillis`,
 * plus an inexact [AlarmManager] alarm just after the next local midnight, plus
 * the date, time and time zone changes. Tapping the widget opens the app on
 * the idea (`inklab://idea/<id>`, handled in Dart).
 */
class IdeaWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        val data = IdeaData.parse(widgetData.getString(DATA_KEY, null))
        for (id in appWidgetIds) {
            appWidgetManager.updateAppWidget(id, render(context, appWidgetManager, id, data))
        }
        scheduleNextMidnight(context)
    }

    // Resizing: fewer lines fit in a short widget.
    override fun onAppWidgetOptionsChanged(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        newOptions: Bundle,
    ) {
        super.onAppWidgetOptionsChanged(context, appWidgetManager, appWidgetId, newOptions)
        val data = IdeaData.parse(HomeWidgetPlugin.getData(context).getString(DATA_KEY, null))
        appWidgetManager.updateAppWidget(
            appWidgetId,
            render(context, appWidgetManager, appWidgetId, data),
        )
    }

    override fun onReceive(context: Context, intent: Intent) {
        when (intent.action) {
            ACTION_NEW_DAY,
            Intent.ACTION_DATE_CHANGED,
            Intent.ACTION_TIME_CHANGED,
            Intent.ACTION_TIMEZONE_CHANGED -> refreshAll(context)
            else -> super.onReceive(context, intent)
        }
    }

    override fun onDisabled(context: Context) {
        super.onDisabled(context)
        alarmManager(context)?.cancel(newDayIntent(context))
    }

    private fun refreshAll(context: Context) {
        val manager = AppWidgetManager.getInstance(context)
        val ids = manager.getAppWidgetIds(ComponentName(context, IdeaWidgetProvider::class.java))
        if (ids.isEmpty()) return
        onUpdate(context, manager, ids, HomeWidgetPlugin.getData(context))
    }

    private fun render(
        context: Context,
        manager: AppWidgetManager,
        appWidgetId: Int,
        data: IdeaData?,
    ): RemoteViews {
        val views = RemoteViews(context.packageName, R.layout.idea_widget)
        // 0 when the launcher does not say: treat it as roomy.
        val heightDp = manager
            .getAppWidgetOptions(appWidgetId)
            .getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_HEIGHT, 0)
        val roomy = heightDp == 0 || heightDp >= ROOMY_DP
        val showChips = heightDp == 0 || heightDp >= CHIPS_DP

        val idea = data?.today(Calendar.getInstance())
        val uri = idea?.let {
            Uri.Builder().scheme("inklab").authority("idea").appendPath(it.id).build()
        }
        views.setOnClickPendingIntent(
            android.R.id.background,
            HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java, uri),
        )

        if (data == null || idea == null) {
            // Nothing written yet: invite the user to open the app.
            views.setTextViewText(
                R.id.idea_caption,
                context.getString(R.string.idea_widget_app_name).uppercase(Locale.ROOT),
            )
            views.setTextViewText(R.id.idea_title, context.getString(R.string.idea_widget_empty))
            views.setViewVisibility(R.id.idea_summary, View.GONE)
            views.setViewVisibility(R.id.idea_chips, View.GONE)
            return views
        }

        val minutes = data.minutesFmt.replace("{n}", idea.minutes.toString())
        views.setTextViewText(
            R.id.idea_caption,
            "${data.label} · $minutes".uppercase(Locale.ROOT),
        )
        views.setTextViewText(R.id.idea_title, idea.title)
        views.setTextViewText(R.id.idea_summary, idea.summary)
        views.setViewVisibility(
            R.id.idea_summary,
            if (roomy && idea.summary.isNotEmpty()) View.VISIBLE else View.GONE,
        )
        // A short widget gives the card less padding too.
        val pad = dp(context, if (roomy) 16 else 12)
        views.setViewPadding(android.R.id.background, pad, pad, pad, pad)

        views.setViewVisibility(
            R.id.idea_chips,
            if (showChips && idea.colors.isNotEmpty()) View.VISIBLE else View.GONE,
        )
        for (i in CHIP_FRAMES.indices) {
            val color = idea.colors.getOrNull(i)
            if (color == null) {
                views.setViewVisibility(CHIP_FRAMES[i], View.GONE)
            } else {
                views.setViewVisibility(CHIP_FRAMES[i], View.VISIBLE)
                views.setInt(CHIP_FILLS[i], "setColorFilter", color)
            }
        }
        return views
    }

    /**
     * Arms one inexact alarm for just after the next local midnight. No
     * exact-alarm permission is involved; the system may deliver it a little
     * late, and the date-change broadcasts and the hourly update cover for it.
     */
    private fun scheduleNextMidnight(context: Context) {
        val next = Calendar.getInstance().apply {
            add(Calendar.DAY_OF_MONTH, 1)
            set(Calendar.HOUR_OF_DAY, 0)
            set(Calendar.MINUTE, 0)
            set(Calendar.SECOND, 5)
            set(Calendar.MILLISECOND, 0)
        }
        alarmManager(context)?.setAndAllowWhileIdle(
            AlarmManager.RTC,
            next.timeInMillis,
            newDayIntent(context),
        )
    }

    private fun alarmManager(context: Context): AlarmManager? =
        context.getSystemService(Context.ALARM_SERVICE) as? AlarmManager

    private fun newDayIntent(context: Context): PendingIntent {
        val intent = Intent(context, IdeaWidgetProvider::class.java).setAction(ACTION_NEW_DAY)
        return PendingIntent.getBroadcast(
            context,
            0,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
    }

    private fun dp(context: Context, value: Int): Int =
        (value * context.resources.displayMetrics.density).toInt()

    private companion object {
        const val DATA_KEY = "ideas"
        const val ACTION_NEW_DAY = "dev.inklab.ink_lab.action.IDEA_WIDGET_NEW_DAY"

        // Below these widget heights (dp) the summary, then the chips, drop out.
        const val ROOMY_DP = 130
        const val CHIPS_DP = 90

        val CHIP_FRAMES = intArrayOf(
            R.id.idea_chip_1,
            R.id.idea_chip_2,
            R.id.idea_chip_3,
            R.id.idea_chip_4,
            R.id.idea_chip_5,
        )
        val CHIP_FILLS = intArrayOf(
            R.id.idea_chip_fill_1,
            R.id.idea_chip_fill_2,
            R.id.idea_chip_fill_3,
            R.id.idea_chip_fill_4,
            R.id.idea_chip_fill_5,
        )
    }
}

/** One idea as the app wrote it. [colors] are opaque ARGB ints, at most five. */
private class Idea(
    val id: String,
    val title: String,
    val summary: String,
    val minutes: Int,
    val colors: List<Int>,
)

/** What the app wrote: the texts of the catalogue in the app's language. */
private class IdeaData(
    val epoch: Triple<Int, Int, Int>,
    val label: String,
    val minutesFmt: String,
    val ideas: List<Idea>,
) {
    /** The idea of [day]'s local date, like `IdeasEngine.featuredFor`. */
    fun today(day: Calendar): Idea? {
        if (ideas.isEmpty()) return null
        val days = daysFromCivil(
            day.get(Calendar.YEAR),
            day.get(Calendar.MONTH) + 1,
            day.get(Calendar.DAY_OF_MONTH),
        ) - daysFromCivil(epoch.first, epoch.second, epoch.third)
        return ideas[Math.floorMod(days, ideas.size)]
    }

    companion object {
        /** `null` when nothing was written yet or the JSON is not what we expect. */
        fun parse(json: String?): IdeaData? {
            if (json.isNullOrEmpty()) return null
            return try {
                val root = JSONObject(json)
                val array = root.getJSONArray("items")
                val ideas = ArrayList<Idea>(array.length())
                for (i in 0 until array.length()) {
                    val item = array.getJSONObject(i)
                    val colors = ArrayList<Int>()
                    val colorArray = item.optJSONArray("colors")
                    if (colorArray != null) {
                        for (c in 0 until minOf(colorArray.length(), MAX_COLORS)) {
                            try {
                                colors.add(Color.parseColor(colorArray.getString(c)))
                            } catch (_: IllegalArgumentException) {
                                // A colour we cannot read is left out.
                            }
                        }
                    }
                    ideas.add(
                        Idea(
                            id = item.getString("id"),
                            title = item.getString("title"),
                            summary = item.optString("summary", ""),
                            minutes = item.optInt("minutes", 0),
                            colors = colors,
                        ),
                    )
                }
                IdeaData(
                    epoch = parseEpoch(root.optString("epoch", "")),
                    label = root.optString("label", ""),
                    minutesFmt = root.optString("minutesFmt", "{n}"),
                    ideas = ideas,
                )
            } catch (_: Exception) {
                null
            }
        }

        private const val MAX_COLORS = 5

        /** `yyyy-MM-dd`; 2024-01-01 when it cannot be read. */
        private fun parseEpoch(text: String): Triple<Int, Int, Int> {
            val parts = text.split("-").mapNotNull { it.toIntOrNull() }
            return if (parts.size == 3) Triple(parts[0], parts[1], parts[2])
            else Triple(2024, 1, 1)
        }

        /**
         * Days since 1970-01-01 of a civil date (proleptic Gregorian), without
         * time zones or java.time (the app supports API 24). The same
         * arithmetic is checked against `featuredFor` in
         * `test/data/idea_widget_sync_test.dart`.
         */
        fun daysFromCivil(year: Int, month: Int, day: Int): Int {
            val y = if (month <= 2) year - 1 else year
            val era = (if (y >= 0) y else y - 399) / 400
            val yoe = y - era * 400
            val doy = (153 * (if (month > 2) month - 3 else month + 9) + 2) / 5 + day - 1
            val doe = yoe * 365 + yoe / 4 - yoe / 100 + doy
            return era * 146097 + doe - 719468
        }
    }
}
