package com.zamil.zamil

import android.app.DownloadManager
import android.content.Context
import android.net.Uri
import android.os.Environment
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.zamil.zamil/download"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "downloadFile") {
                val url = call.argument<String>("url")
                val filename = call.argument<String>("filename")
                val authToken = call.argument<String>("authToken")
                if (url != null && filename != null) {
                    try {
                        val downloadManager = getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
                        val uri = Uri.parse(url)
                        val request = DownloadManager.Request(uri)
                        
                        request.setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, filename)
                        request.setTitle(filename)
                        request.setDescription("Downloading patient file...")
                        request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED)
                        
                        if (!authToken.isNullOrEmpty()) {
                            request.addRequestHeader("Authorization", "Bearer $authToken")
                        }
                        
                        downloadManager.enqueue(request)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("DOWNLOAD_ERROR", e.localizedMessage, null)
                    }
                } else {
                    result.error("BAD_ARGS", "Missing url or filename", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
