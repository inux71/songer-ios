//
//  AddPreferencesViewModel.swift
//  Songer
//
//  Created by Kacper Grabiec on 06/04/2025.
//

import Foundation

class AddPreferencesViewModel: ObservableObject {
    let songs: [Song] = [
        Song(id: 1, title: "24K magic", path: "test_tone.wav"),
        Song(id: 2, title: "Don't", path: "test_tone.wav"),
        Song(id: 3, title: "Unstoppable", path: "test_tone.wav"),
    ]
    
    @Published var currentSongIndex: Int = 0
    
    var progress: Float {
        Float(currentSongIndex) / Float(songs.count)
    }
}
