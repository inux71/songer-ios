//
//  PreferencesView.swift
//  Songer
//
//  Created by Kacper Grabiec on 08/04/2025.
//

import SwiftUI

struct PreferencesView: View {
    @EnvironmentObject private var audioManager: AudioManager
    
    @StateObject private var viewModel = PreferencesViewModel()
    
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List(viewModel.songs, id: \.self, selection: $viewModel.selectedSong) { song in
                SongItem(title: song.title)
            }
            .onChange(of: viewModel.selectedSong) { _, selectedSong in
                guard let song = selectedSong else { return }
                audioManager.play(path: song.path)
            }
            
            VStack {
                HStack {
                    Text(viewModel.selectedSong?.title ?? "")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(audioManager.timeRemaining?.formatted ?? "")
                }
                
                ProgressView(
                    value: audioManager.currentTime,
                    total: audioManager.duration ?? 1
                )
                
                HStack {
                    Button(action: {
                        viewModel.setPreviousSong()
                        
                        guard let song: Song = viewModel.selectedSong else { return }
                        audioManager.play(path: song.path)
                    }) {
                        Image(systemName: "backward.circle")
                    }
                    
                    Button(action: audioManager.playPause) {
                        Image(systemName: audioManager.isPlaying ? "pause.circle" : "play.circle")
                    }
                    
                    Button(action: {
                        viewModel.setNextSong()
                        
                        guard let song: Song = viewModel.selectedSong else { return }
                        audioManager.play(path: song.path)
                    }) {
                        Image(systemName: "forward.circle")
                    }
                }
                .disabled(viewModel.selectedSong == nil)
                .padding(.top)
                .labelStyle(.iconOnly)
                .font(.system(size: 32))
            }
            .padding()
        }
        .navigationTitle(title)
        .onDisappear {
            audioManager.stop()
        }
    }
}

#Preview {
    NavigationStack {
        PreferencesView(title: "Preferences 1")
            .environmentObject(AudioManager())
    }
}
