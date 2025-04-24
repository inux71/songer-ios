//
//  TimeInterval.swift
//  Songer
//
//  Created by Kacper Grabiec on 23/04/2025.
//

import Foundation

extension TimeInterval {
    var formatted: String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        
        return String(format: "%d:%02d", minutes, seconds)
    }
}
