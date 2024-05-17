// Autogenerated from Pigeon (v19.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
@file:Suppress("UNCHECKED_CAST", "ArrayInDataClass")


import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  return if (exception is FlutterError) {
    listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

private fun createConnectionError(channelName: String): FlutterError {
  return FlutterError("channel-error",  "Unable to establish connection on channel: '$channelName'.", "")}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

/** Generated class from Pigeon that represents data sent in messages. */
data class GuessMessage (
  val number: Long,
  val values: List<Long?>,
  val resultOrdinals: List<Long?>

) {
  companion object {
    @Suppress("LocalVariableName")
    fun fromList(__pigeon_list: List<Any?>): GuessMessage {
      val number = __pigeon_list[0].let { num -> if (num is Int) num.toLong() else num as Long }
      val values = __pigeon_list[1] as List<Long?>
      val resultOrdinals = __pigeon_list[2] as List<Long?>
      return GuessMessage(number, values, resultOrdinals)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      number,
      values,
      resultOrdinals,
    )
  }
}
/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface GameNativeApi {
  fun evaluateUserInput(userInput: List<Long>): Boolean
  fun restart()

  companion object {
    /** The codec used by GameNativeApi. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
    /** Sets up an instance of `GameNativeApi` to handle messages through the `binaryMessenger`. */
    fun setUp(binaryMessenger: BinaryMessenger, api: GameNativeApi?, messageChannelSuffix: String = "") {
      val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.bulls_and_cows_flutter.GameNativeApi.evaluateUserInput$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val userInputArg = args[0] as List<Long>
            val wrapped: List<Any?> = try {
              listOf<Any?>(api.evaluateUserInput(userInputArg))
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.bulls_and_cows_flutter.GameNativeApi.restart$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped: List<Any?> = try {
              api.restart()
              listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
private object GameFlutterApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          GuessMessage.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is GuessMessage -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
class GameFlutterApi(private val binaryMessenger: BinaryMessenger, private val messageChannelSuffix: String = "") {
  companion object {
    /** The codec used by GameFlutterApi. */
    val codec: MessageCodec<Any?> by lazy {
      GameFlutterApiCodec
    }
  }
  fun onNewGuessList(guessMessagesArg: List<GuessMessage>, callback: (Result<Unit>) -> Unit)
{
    val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
    val channelName = "dev.flutter.pigeon.bulls_and_cows_flutter.GameFlutterApi.onNewGuessList$separatedMessageChannelSuffix"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(guessMessagesArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)))
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      } 
    }
  }
}