//
//  PreferencesViewModel.swift
//  Songer
//
//  Created by Kacper Grabiec on 08/04/2025.
//

import AVFAudio
import Foundation

class PreferencesViewModel: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    
    let songs: [Song] = [
        Song(id: 1, title: "24K magic", path: "test_tone.wav"),
        Song(id: 2, title: "Don't", path: "test_tone.wav"),
        Song(id: 3, title: "Unstoppable", path: "test_tone.wav"),
    ]
    
    @Published var currentTime: TimeInterval = 0
    @Published var selectedSong: Song? = nil {
        didSet {
            guard let song = selectedSong else { return }
            playSong(song: song)
        }
    }
    
    var isPlaying: Bool {
        audioPlayer?.isPlaying ?? false
    }
    
    var duration: TimeInterval? {
        audioPlayer?.duration
    }
    
    private var selectedSongIndex: Int? {
        guard let selected = selectedSong else { return nil }
        
        return songs.firstIndex(where: { $0.id == selected.id })
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func startTimer() {
        stopTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.currentTime = self.audioPlayer?.currentTime ?? 0
        }
    }
    
    private func playSong(song: Song) {
        stopSong()
        
        let path = Bundle.main.path(forResource: song.path, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            startTimer()
        } catch {
            print("Error playing audio: \(error)")
        }
    }
    
    func playPreviousSong() {
        guard let currentIndex = selectedSongIndex else { return }
        
        let previousIndex = (currentIndex - 1 + songs.count) % songs.count
        selectedSong = songs[previousIndex]
    }
    
    func playPauseSong() {
        guard let isPlaying: Bool = audioPlayer?.isPlaying else { return }
        
        if isPlaying {
            audioPlayer?.pause()
            stopTimer()
        } else {
            audioPlayer?.play()
            startTimer()
        }
    }
    
    func playNextSong() {
        guard let currentIndex = selectedSongIndex else { return }
        
        let nextIndex = (currentIndex + 1) % songs.count
        selectedSong = songs[nextIndex]
    }
    
    func stopSong() {
        audioPlayer?.stop()
        stopTimer()
    }
}
