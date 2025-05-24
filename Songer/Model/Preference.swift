//
//  Preference.swift
//  Songer
//
//  Created by Kacper Grabiec on 24/05/2025.
//

import Foundation

struct Preference: Hashable, Codable {
    let id: Int
    let title: String
    let genres: [String]
}
