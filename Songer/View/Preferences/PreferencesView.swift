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
    
    @State private var isPresented: Bool = false
    @State private var title: String
    @State private var newTitle: String = ""
    
    let id: Int
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List(viewModel.songs, id: \.id, selection: $viewModel.selectedSong) { song in
                SongItem(title: song.title)
            }
            .onChange(of: viewModel.selectedSong) { _, selectedSong in
                guard let song = selectedSong else { return }
                audioManager.play(path: song.filePath)
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
                        audioManager.play(path: song.filePath)
                    }) {
                        Image(systemName: "backward.circle")
                    }
                    
                    Button(action: audioManager.playPause) {
                        Image(systemName: audioManager.isPlaying ? "pause.circle" : "play.circle")
                    }
                    
                    Button(action: {
                        viewModel.setNextSong()
                        
                        guard let song: Song = viewModel.selectedSong else { return }
                        audioManager.play(path: song.filePath)
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
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .navigationTitle(title)
        .toolbar {
            ToolbarItem {
                Button("", systemImage: "pencil") {
                    isPresented.toggle()
                }
            }
        }
        .alert("Rename Preference", isPresented: $isPresented) {
            TextField("", text: $newTitle, prompt: Text("Enter new name"))
            
            Button("OK") {
                title = newTitle
                
                Task {
                    await viewModel.renamePreference(
                        withId: id,
                        newTitle: newTitle
                    )
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.getSongs(withId: id)
            }
        }
        .onDisappear {
            audioManager.stop()
        }
    }
}

#Preview {
    NavigationStack {
        PreferencesView(id: 1, title: "Preferences 1")
            .environmentObject(AudioManager())
    }
}
