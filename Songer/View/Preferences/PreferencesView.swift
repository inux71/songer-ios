//
//  PreferencesView.swift
//  Songer
//
//  Created by Kacper Grabiec on 08/04/2025.
//

import SwiftUI

struct PreferencesView: View {
    @StateObject private var viewModel = PreferencesViewModel()
    
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    private func formattedDuration(from seconds: TimeInterval?) -> String {
        guard let seconds = seconds else { return "" }
        let minutesPart = Int(seconds) / 60
        let secondsPart = Int(seconds) % 60
        
        return String(format: "%d:%02d", minutesPart, secondsPart)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List(viewModel.songs, id: \.self, selection: $viewModel.selectedSong) { song in
                SongItem(title: song.title)
            }
            
            VStack {
                HStack {
                    Text(viewModel.selectedSong?.title ?? "")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(formattedDuration(from: viewModel.duration))
                }
                
                ProgressView(
                    value: viewModel.currentTime,
                    total: viewModel.duration ?? 1
                )
                
                HStack {
                    Button(action: viewModel.playPreviousSong) {
                        Image(systemName: "backward.circle")
                    }
                    
                    Button(action: viewModel.playPauseSong) {
                        Image(systemName: viewModel.isPlaying ? "pause.circle" : "play.circle")
                    }
                    
                    Button(action: viewModel.playNextSong) {
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
            viewModel.stopSong()
        }
    }
}

#Preview {
    NavigationStack {
        PreferencesView(title: "Preferences 1")
    }
}
