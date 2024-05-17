package com.beletskiy.bullsandcows.flutter

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

private const val EVENT_CHANNEL_TAG = "event_channel"
private const val METHOD_CHANNEL_TAG = "method_channel"
private const val EVALUATE_USER_METHOD_TAG = "evaluateUserInput"
private const val RESTART_METHOD_TAG = "restart"

class MainActivity : FlutterActivity() {

    private lateinit var eventChannel: EventChannel
    private val game = Game()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        setupGuessesEventChannel(flutterEngine)
        setupUserInputChannel(flutterEngine)
    }

    private fun setupUserInputChannel(flutterEngine: FlutterEngine) {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            METHOD_CHANNEL_TAG,
        ).setMethodCallHandler { call, result ->
            if (call.method == EVALUATE_USER_METHOD_TAG) {
                (call.arguments as? List<Int>)?.let {
                    val isGameOver = game.evaluateUserInput(it)
                    result.success(isGameOver)
                } ?: result.error("INVALID_INPUT", "Invalid input", null)
            } else if (call.method == RESTART_METHOD_TAG) {
                game.restart()
            } else {
                result.notImplemented()
            }
        }
    }

    private fun setupGuessesEventChannel(flutterEngine: FlutterEngine) {
        eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL_TAG)
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            private var job: Job? = null
            private var eventSink: EventChannel.EventSink? = null

            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
                job = CoroutineScope(Dispatchers.Main).launch {
                    while (isActive) {
                        game.guesses.collect {
                            eventSink?.success(Json.encodeToString(it))
                        }
                    }
                }
            }

            override fun onCancel(arguments: Any?) {
                job?.cancel()
                job = null
                eventSink = null
            }
        })
    }
}
