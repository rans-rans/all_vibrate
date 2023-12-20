@file:Suppress("DEPRECATION")

package com.rans_innovations.all_vibrate

import android.content.Context
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import android.os.VibratorManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AllVibratePlugin */
class AllVibratePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var manager: VibratorManager? = null
    private lateinit var vibrator: Vibrator
    private lateinit var ctx: Context


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "all_vibrate")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {


        manager = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {

            ctx.getSystemService(Context.VIBRATOR_MANAGER_SERVICE) as VibratorManager
        } else {
            null
        }
        vibrator = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            manager!!.defaultVibrator
        } else {
            ctx.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
        }

        val args = call.arguments as Map<*, *>

        when (call.method) {
            "simple_vibrate" -> {
                val milliseconds = args["milliseconds"] as Int
                val amplitude = args["amplitude"] as Int
                vibrator.cancel()
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    vibrator.vibrate(
                        VibrationEffect.createOneShot(
                            milliseconds.toLong(),
                            amplitude
                        )
                    )
                } else {
                    vibrator.vibrate(milliseconds.toLong())
                }
            }

            "wave_form" -> {
                vibrator.cancel()
                val ticks = args["timings"] as List<*>
                val amps = args["amplitudes"] as List<*>


                val timings =
                    convertToLongArray(ticks)
                val amplitude = convertToIntArray(amps)
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    vibrator.vibrate(VibrationEffect.createWaveform(timings, amplitude, -1))
                } else {
                    vibrator.vibrate(timings, -1)
                }
            }
        }
    }

    private fun convertToLongArray(item: List<*>): LongArray {
        val longArray = LongArray(item.size)
        item.forEachIndexed { index, it ->
            longArray[index] =
                it.toString().toLong()
        }
        return longArray
    }

    private fun convertToIntArray(item: List<*>): IntArray {
        val intArray = IntArray(item.size)
        item.forEachIndexed { index, it ->
            intArray[index] = it.toString().toInt()
        }
        return intArray
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        ctx = binding.activity.applicationContext
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }
}
