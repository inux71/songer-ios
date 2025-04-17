//
//  PreferencesViewModel.swift
//  Songer
//
//  Created by Kacper Grabiec on 08/04/2025.
//

import Foundation

class PreferencesViewModel: ObservableObject {
    let songs: [Song] = [
        Song(id: 1, title: "24K magic", duration: 120),
        Song(id: 2, title: "Don't", duration: 180),
        Song(id: 3, title: "Unstoppable", duration: 90),
    ]
    
    @Published var isPlaying: Bool = false
    @Published var selectedSong: Song? = nil {
        didSet {
            isPlaying = true
        }
    }
    
    private var selectedSongIndex: Int? {
        guard let selected = selectedSong else { return nil }
        
        return songs.firstIndex(where: { $0.id == selected.id })
    }
    
    func playPreviousSong() {
        guard let currentIndex = selectedSongIndex else { return }
        
        let previousIndex = (currentIndex - 1 + songs.count) % songs.count
        selectedSong = songs[previousIndex]
    }
    
    func playPauseSong() {
        isPlaying.toggle()
    }
    
    func playNextSong() {
        guard let currentIndex = selectedSongIndex else { return }
        
        let nextIndex = (currentIndex + 1) % songs.count
        selectedSong = songs[nextIndex]
    }
}
