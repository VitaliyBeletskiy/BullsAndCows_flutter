package com.beletskiy.bullsandcows.flutter

import GuessMessage

data class Guess(
    val number: Int,
    val userInput: List<Int>,
    val results: List<Result>,
)

fun List<Guess>.toGuessMessages(): List<GuessMessage> {
    return map { it.toGuessMessage() }
}

fun Guess.toGuessMessage(): GuessMessage {
    return GuessMessage(
        number = number.toLong(),
        values = userInput.map { it.toLong() },
        resultOrdinals = results.map { it.ordinal.toLong() },
    )
}