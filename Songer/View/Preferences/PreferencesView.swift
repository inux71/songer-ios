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
            List(viewModel.songs, id: \.id) { song in
                SongItem(title: song.title)
                    .containerShape(Rectangle())
                    .onTapGesture {
                        viewModel.selectedSong = song
                        
                        let path: String = NetworkConfiguration.baseURL + song.filePath
                        audioManager.play(path: path)
                    }
            }
            
            VStack {
                HStack {
                    Text(viewModel.selectedSong?.title ?? "")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(audioManager.timeRemaining.formatted)
                }
                
                ProgressView(
                    value: audioManager.currentTime,
                    total: audioManager.duration == 0 ? 1 : audioManager.duration
                )
                
                HStack {
                    Button(action: {
                        viewModel.setPreviousSong()
                        
                        guard let song: Song = viewModel.selectedSong else { return }
                        let path: String = NetworkConfiguration.baseURL + song.filePath
                        audioManager.play(path: path)
                    }) {
                        Image(systemName: "backward.circle")
                    }
                    
                    Button(action: audioManager.playPause) {
                        Image(systemName: audioManager.isPlaying ? "pause.circle" : "play.circle")
                    }
                    
                    Button(action: {
                        viewModel.setNextSong()
                        
                        guard let song: Song = viewModel.selectedSong else { return }
                        let path: String = NetworkConfiguration.baseURL + song.filePath
                        audioManager.play(path: path)
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
            .background(Color.black)
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
