package br.com.azmina.penhas

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.WorkManager
import androidx.work.CoroutineWorker
import androidx.work.WorkerParameters
import java.util.concurrent.TimeUnit
import id.flutter.flutter_background_service.BackgroundService

class BootReceiverV15 : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (Intent.ACTION_BOOT_COMPLETED == intent.action) {
            val workRequest = OneTimeWorkRequestBuilder<StartServiceWorker>()
                .setInitialDelay(1, TimeUnit.SECONDS)
                .build()
            WorkManager.getInstance(context).enqueue(workRequest)
        }
    }
}

class StartServiceWorker(context: Context, params: WorkerParameters) : CoroutineWorker(context, params) {
    override suspend fun doWork(): Result {
        val serviceIntent = Intent(applicationContext, BackgroundService::class.java)
        applicationContext.startForegroundService(serviceIntent)
        return Result.success()
    }
}
