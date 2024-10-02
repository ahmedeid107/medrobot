package com.adham.medrobot

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.util.Log
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    private val screenCaptureReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent?.action == Intent.ACTION_USER_PRESENT || intent?.action == Intent.ACTION_SCREEN_OFF) {
                // إغلاق التطبيق عند اكتشاف لقطة شاشة أو تسجيل الشاشة
                finishAffinity() // إغلاق جميع الأنشطة وإنهاء التطبيق
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // منع لقطات الشاشة وتسجيل الشاشة
        window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)

        // تسجيل BroadcastReceiver لمراقبة النظام
        val filter = IntentFilter().apply {
            addAction(Intent.ACTION_USER_PRESENT) // مراقبة عندما يتم التقاط لقطة شاشة
            addAction(Intent.ACTION_SCREEN_OFF)   // مراقبة عند تسجيل الشاشة
        }
        registerReceiver(screenCaptureReceiver, filter)
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(screenCaptureReceiver) // إلغاء التسجيل عند إغلاق التطبيق
    }
}
