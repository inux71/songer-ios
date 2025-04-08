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
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List(viewModel.songs, id: \.self, selection: $viewModel.selectedSong) { song in
                SongItem(title: song)
            }
            
            VStack {
                HStack {
                    Text(
                        "\(viewModel.selectedSong ?? "")",
                        comment: "Preferences view currently playing song title"
                    )
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(
                        "\(viewModel.selectedSong != nil ? "0:46" : "")",
                        comment: "Preferences view currently playing song duration"
                    )
                }
                
                ProgressView(value: 0.2)
                
                HStack {
                    Button("Previous", systemImage: "backward.circle") {
                        // to do
                    }
                    
                    Button("Play", systemImage: "play.circle") {
                        // to do
                    }
                    
                    Button("Next", systemImage: "forward.circle") {
                        // to do
                    }
                }
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
