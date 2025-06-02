//
//  AddPreferencesView.swift
//  Songer
//
//  Created by Kacper Grabiec on 05/04/2025.
//

import SwiftUI

struct AddPreferencesView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var audioManager: AudioManager
    
    @StateObject private var viewModel = AddPreferencesViewModel()
    
    var body: some View {
        VStack {
            ProgressView(value: viewModel.progress) {
                EmptyView()
            } currentValueLabel: {
                Text(
                    "\(viewModel.currentSongIndex)/\(viewModel.songs.count) songs rated",
                    comment: "Add preferences view progress bar"
                )
                .padding(.horizontal)
            }
            
            Spacer()
            
            GeometryReader { geometry in
                VStack {
                    if viewModel.progress < 1 {
                        Image(systemName: "play.square.stack")
                            .font(.system(size: 128))
                        
                        if viewModel.songs.isEmpty {
                            Text(
                                "-",
                                comment: "Song title placeholder"
                            )
                        } else {
                            Text(viewModel.songs[viewModel.currentSongIndex].title)
                                .font(.system(size: 32, weight: .bold))
                        }
                        
                        ProgressView(
                            value: audioManager.currentTime,
                            total: audioManager.duration ?? 1
                        ) {
                            EmptyView()
                        } currentValueLabel: {
                            Text(audioManager.currentTime?.formatted ?? "")
                        }
                        
                        HStack {
                            Button(action: {
                                audioManager.stop()
                                
                                viewModel.currentSongIndex += 1
                            }) {
                                Image(systemName: "xmark.circle")
                            }
                            
                            Button(action: {
                                let path: String = NetworkConfiguration.baseURL + viewModel.songs[viewModel.currentSongIndex].filePath
                                
                                audioManager.play(path: path)
                            }) {
                                Image(systemName: "play.circle")
                            }
                            .font(.system(size: 64))
                            
                            Button(action: {
                                audioManager.stop()
                                
                                viewModel.likedGenres.insert(viewModel.songs[viewModel.currentSongIndex].genre)
                                viewModel.currentSongIndex += 1
                            }) {
                                Image(systemName: "heart.circle")
                            }
                        }
                        .labelStyle(.iconOnly)
                        .font(.system(size: 48))
                        .disabled(viewModel.songs.isEmpty)
                    } else {
                        ContentUnavailableView(
                            label: {
                                Label(
                                    "Rating completed!",
                                    systemImage: "checkmark.circle"
                                )
                            },
                            description: {
                                Text(
                                    "You successfully defined your music preferences. Click the button below to finish the test.",
                                    comment: "Add preferences view rating completed text"
                                )
                            },
                            actions: {
                                Button(action: {
                                    Task {
                                        await viewModel.uploadPreference()
                                        
                                        dismiss()
                                    }
                                }) {
                                    Text(
                                        "Finish",
                                        comment: "Add preferences view finish test button"
                                    )
                                }
                            }
                        )
                    }
                }
                .frame(width: geometry.size.width * 0.75)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            
            Spacer()
        }
        .navigationTitle(Text(
            "Add preferences",
            comment: "Add preferences view navigation title"
        ))
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .onDisappear {
            audioManager.stop()
        }
    }
}

#Preview {
    NavigationStack {
        AddPreferencesView()
            .environmentObject(AudioManager())
    }
}
