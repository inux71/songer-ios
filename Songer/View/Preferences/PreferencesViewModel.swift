//
//  PreferencesViewModel.swift
//  Songer
//
//  Created by Kacper Grabiec on 08/04/2025.
//

import Foundation

class PreferencesViewModel: ObservableObject {
    let songs: [String] = [
        "Song 1",
        "Song 2",
        "Song 3"
    ]
    
    @Published var selectedSong: String? = nil
}
