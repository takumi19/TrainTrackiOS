//
//  StaticData.swift
//  none
//
//  Created by Max Vaughan on 10.04.2025.
//

import Foundation

struct AppEnv {
    static let serverBaseURL: String = "http://localhost:8090/"
    static let version: Int = 1

    /// Returns the current version of traintrack as a path string:
    ///     v1 for version 1
    ///     v2 for version 2
    ///     etc.
    static func getVersionString() -> String {
        return "v" + String(version)
    }

    /// Returns url for current supported API version or version 1 by default
    static func versionedServerURL() -> URL {
        return URL(string: serverBaseURL + getVersionString())!
    }
}

enum EnvError: Error {
    case genericError
}
