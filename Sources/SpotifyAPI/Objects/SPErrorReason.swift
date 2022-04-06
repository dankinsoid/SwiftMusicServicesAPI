//
//  SPErrorCode.swift
//  MusicImport
//
//  Created by Daniil on 23.07.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import Foundation

public enum SPErrorReason: String, Error, Codable {
    ///The command requires a previous track, but there is none in the context.
    case NO_PREV_TRACK
    ///The command requires a next track, but there is none in the context.
    case NO_NEXT_TRACK
    ///The requested track does not exist.
    case NO_SPECIFIC_TRACK
    ///The command requires playback to not be paused.
    case ALREADY_PAUSED
    ///The command requires playback to be paused.
    case NOT_PAUSED
    ///The command requires playback on the local device.
    case NOT_PLAYING_LOCALLY
    ///The command requires that a track is currently playing.
    case NOT_PLAYING_TRACK
    ///The command requires that a context is currently playing.
    case NOT_PLAYING_CONTEXT
    ///The shuffle command cannot be applied on an endless context.
    case ENDLESS_CONTEXT
    ///The command could not be performed on the context.
    case CONTEXT_DISALLOW
    ///The track should not be restarted if the same track and context is already playing, and there is a resume point.
    case ALREADY_PLAYING
    ///The user is rate limited due to too frequent track play, also known as cat-on-the-keyboard spamming.
    case RATE_LIMITED
    ///The context cannot be remote-controlled.
    case REMOTE_CONTROL_DISALLOW
    ///Not possible to remote control the device.
    case DEVICE_NOT_CONTROLLABLE
    ///Not possible to remote control the device's volume.
    case VOLUME_CONTROL_DISALLOW
    ///Requires an active device and the user has none.
    case NO_ACTIVE_DEVICE
    ///The request is prohibited for non-premium users.
    case PREMIUM_REQUIRED
    case UNKNOWN
}
