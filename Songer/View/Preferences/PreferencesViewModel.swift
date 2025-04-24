//
//  PreferencesViewModel.swift
//  Songer
//
//  Created by Kacper Grabiec on 08/04/2025.
//

import AVFAudio
import Foundation

class PreferencesViewModel: ObservableObject {
    let songs: [Song] = [
        Song(id: 1, title: "24K magic", path: "test_tone.wav"),
        Song(id: 2, title: "Don't", path: "test_tone.wav"),
        Song(id: 3, title: "Unstoppable", path: "test_tone.wav"),
    ]
    
    @Published var selectedSong: Song? = nil
    
    private var selectedSongIndex: Int? {
        guard let selected = selectedSong else { return nil }
        
        return songs.firstIndex(where: { $0.id == selected.id })
    }
    
    func setPreviousSong() {
        guard let currentIndex = selectedSongIndex else { return }
        
        let previousIndex = (currentIndex - 1 + songs.count) % songs.count
        selectedSong = songs[previousIndex]
    }
    
    func setNextSong() {
        guard let currentIndex = selectedSongIndex else { return }
        
        let nextIndex = (currentIndex + 1) % songs.count
        selectedSong = songs[nextIndex]
    }
}
