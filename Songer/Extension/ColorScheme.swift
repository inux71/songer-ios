//
//  ColorScheme.swift
//  Songer
//
//  Created by Kacper Grabiec on 06/04/2025.
//

import SwiftUI
import Foundation

extension ColorScheme {
    var asString: String {
        switch self {
        case .light:
            return "light"
        case .dark:
            return "dark"
        @unknown default:
            return "light"
        }
    }
    
    static func from(_ string: String) -> ColorScheme {
        switch string {
            case "light":
                return .light
            case "dark":
                return .dark
            default:
                return .light
        }
    }
}
