//
//  AudioManager.swift
//  Songer
//
//  Created by Kacper Grabiec on 23/04/2025.
//

import AVFoundation
import Foundation

class AudioManager : ObservableObject {
    private var audioPlayer: AVPlayer?
    private var timer: Timer?
    
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval? = 0
    
    var duration: TimeInterval? {
        audioPlayer?.currentItem?.duration.seconds
    }
    
    var timeRemaining: TimeInterval? {
        guard let duration = duration else { return nil }
        guard let currentTime = currentTime else { return duration }
        
        return duration - currentTime
    }
    
    func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.currentTime = self.audioPlayer?.currentTime().seconds ?? 0
        }
    }
    
    func stop() {
        audioPlayer?.pause()
        audioPlayer = nil
        
        timer?.invalidate()
        
        isPlaying = false
    }
    
    func play(path: String) {
        stop()
        
        guard let url = URL(string: path) else {
            print("Invalid URL: \(path)")
            return
        }
        
        audioPlayer = AVPlayer(url: url)
        audioPlayer?.play()
        startTimer()
        
        isPlaying = true
    }
    
    func playPause() {
        guard let audioPlayer = audioPlayer else { return }
        
        if isPlaying {
            audioPlayer.pause()
            timer?.invalidate()
            
            isPlaying = false
        } else {
            audioPlayer.play()
            startTimer()
            
            isPlaying = true
        }
    }
}
