package com.beletskiy.bullsandcows.flutter

import kotlinx.serialization.Serializable

@Serializable
data class Guess(
    val number: Int,
    val userInput: List<Int>,
    val results: List<Result>,
)
