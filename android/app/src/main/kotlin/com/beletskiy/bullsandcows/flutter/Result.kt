package com.beletskiy.bullsandcows.flutter

import kotlinx.serialization.Serializable

@Serializable
enum class Result() {
    NOTHING(),
    COW(),
    BULL(),
}
