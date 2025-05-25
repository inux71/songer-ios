//
//  Song.swift
//  Songer
//
//  Created by Kacper Grabiec on 17/04/2025.
//

import Foundation

struct Song: Hashable, Codable {
    let id: Int
    let title: String
    let artist: String
    let filePath: String
    let genre: String
}
