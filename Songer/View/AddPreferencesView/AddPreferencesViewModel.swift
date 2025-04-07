//
//  AddPreferencesViewModel.swift
//  Songer
//
//  Created by Kacper Grabiec on 06/04/2025.
//

import Foundation

class AddPreferencesViewModel: ObservableObject {
    @Published var currentSongIndex: Int = 0
    
    var progress: Float {
        Float(currentSongIndex) / 5
    }
}
