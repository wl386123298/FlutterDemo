package com.wl.main.flutter_demo

import androidx.multidex.MultiDex
import io.flutter.app.FlutterApplication

class MyApplication : FlutterApplication() {
    override fun onCreate() {
        MultiDex.install(this)
        super.onCreate()
    }
}