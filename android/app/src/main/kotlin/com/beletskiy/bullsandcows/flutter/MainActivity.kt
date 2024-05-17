package com.beletskiy.bullsandcows.flutter

import GameFlutterApi
import GameNativeApi
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class MainActivity : FlutterActivity(), GameNativeApi {

    private val game = Game()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        GameNativeApi.setUp(flutterEngine.dartExecutor.binaryMessenger, this)
        val flutterApi = GameFlutterApi(flutterEngine.dartExecutor.binaryMessenger)

        CoroutineScope(Dispatchers.Main).launch {
            game.guesses.collect {
                flutterApi.onNewGuessList(it.toGuessMessages()) {
                   Log.i("vitDebug", "MainActivity.configureFlutterEngine: $it")
                }
            }
        }
    }

    override fun evaluateUserInput(userInput: List<Long>): Boolean {
        return game.evaluateUserInput(userInput.map { it.toInt() })
    }

    override fun restart() {
        game.restart()
    }
}
