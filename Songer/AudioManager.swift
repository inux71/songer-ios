//
//  AudioManager.swift
//  Songer
//
//  Created by Kacper Grabiec on 23/04/2025.
//

import AVFAudio
import Foundation

class AudioManager : ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval? = 0
    
    var duration: TimeInterval? {
        audioPlayer?.duration
    }
    
    var timeRemaining: TimeInterval? {
        guard let duration = duration else { return nil }
        guard let currentTime = currentTime else { return duration }
        
        return duration - currentTime
    }
    
    func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.currentTime = self.audioPlayer?.currentTime ?? 0
        }
    }
    
    func stop() {
        audioPlayer?.stop()
        timer?.invalidate()
        
        isPlaying = false
    }
    
    func play(path: String) {
        stop()
        
        guard let path = Bundle.main.path(forResource: path, ofType: nil) else {
            print("Audio file not found!")
            
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            startTimer()
            
            isPlaying = true
        } catch {
            print("Error playing audio: \(error)")
        }
    }
    
    func playPause() {
        guard let isPlaying: Bool = audioPlayer?.isPlaying else { return }
        
        if isPlaying {
            audioPlayer?.pause()
            timer?.invalidate()
            
            self.isPlaying = false
        } else {
            audioPlayer?.play()
            startTimer()
            
            self.isPlaying = true
        }
    }
}
