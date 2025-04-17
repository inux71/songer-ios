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
    
    private func formattedDuration(from seconds: Int?) -> String {
        guard let seconds = seconds else { return "" }
        let minutesPart = seconds / 60
        let secondsPart = seconds % 60
        
        return String(format: "%d:%02d", minutesPart, secondsPart)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List(viewModel.songs, id: \.self, selection: $viewModel.selectedSong) { song in
                SongItem(title: song.title)
            }
            
            VStack {
                HStack {
                    Text("\(viewModel.selectedSong?.title ?? "")")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(formattedDuration(from: viewModel.selectedSong?.duration))
                }
                
                ProgressView(value: 0.2)
                
                HStack {
                    Button("Previous", systemImage: "backward.circle") {
                        viewModel.playPreviousSong()
                    }
                    
                    Button(
                        viewModel.isPlaying ? "Pause" : "Play",
                        systemImage: viewModel.isPlaying ? "pause.circle" : "play.circle"
                    ) {
                        viewModel.playPauseSong()
                    }
                    
                    Button("Next", systemImage: "forward.circle") {
                        viewModel.playNextSong()
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
    }
}

#Preview {
    NavigationStack {
        PreferencesView(title: "Preferences 1")
    }
}
