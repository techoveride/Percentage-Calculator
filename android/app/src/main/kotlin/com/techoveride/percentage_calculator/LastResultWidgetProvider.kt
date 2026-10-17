package com.techoveride.percentage_calculator

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

/**
 * Home-screen widget showing the last calculation plus three shortcuts.
 *
 * The Flutter side (lib/launch/home_widget_service.dart) saves the texts in
 * the app's language and the `percal://` links each tap should open.
 */
class LastResultWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.last_result_widget)

            views.setTextViewText(
                R.id.widget_title,
                widgetData.getString("app_title", null)
                    ?: context.getString(R.string.widget_default_title),
            )

            val lastTitle = widgetData.getString("last_title", null)
            if (lastTitle == null) {
                views.setTextViewText(
                    R.id.widget_last_label,
                    widgetData.getString("empty_text", null)
                        ?: context.getString(R.string.widget_empty),
                )
                views.setTextViewText(R.id.widget_last_value, "%")
            } else {
                views.setTextViewText(R.id.widget_last_label, lastTitle)
                views.setTextViewText(
                    R.id.widget_last_value,
                    widgetData.getString("last_value", ""),
                )
            }
            views.setOnClickPendingIntent(
                R.id.widget_last,
                launch(context, widgetData.getString("last_uri", null) ?: "percal://home"),
            )

            bindButton(context, views, widgetData, R.id.widget_btn_1, 1, "%", "percal://calc/percentage")
            bindButton(
                context, views, widgetData, R.id.widget_btn_2, 2,
                context.getString(R.string.widget_btn_discount), "percal://calc/discount",
            )
            bindButton(
                context, views, widgetData, R.id.widget_btn_3, 3,
                context.getString(R.string.widget_btn_tip), "percal://calc/tip",
            )

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }

    private fun bindButton(
        context: Context,
        views: RemoteViews,
        widgetData: SharedPreferences,
        viewId: Int,
        index: Int,
        defaultLabel: String,
        defaultUri: String,
    ) {
        views.setTextViewText(viewId, widgetData.getString("btn${index}_label", null) ?: defaultLabel)
        views.setOnClickPendingIntent(
            viewId,
            launch(context, widgetData.getString("btn${index}_uri", null) ?: defaultUri),
        )
    }

    private fun launch(context: Context, uri: String): PendingIntent =
        HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java, Uri.parse(uri))
}
