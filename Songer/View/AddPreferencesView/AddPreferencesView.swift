//
//  AddPreferencesView.swift
//  Songer
//
//  Created by Kacper Grabiec on 05/04/2025.
//

import SwiftUI

struct AddPreferencesView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = AddPreferencesViewModel()
    
    var body: some View {
        VStack {
            ProgressView(value: viewModel.progress) {
                EmptyView()
            } currentValueLabel: {
                Text(
                    "\(viewModel.currentSongIndex)/5 songs rated",
                    comment: "Add preferences view progress bar"
                )
            }
            
            Spacer()
            
            GeometryReader { geometry in
                VStack {
                    if viewModel.progress < 1 {
                        Image(systemName: "play.square.stack")
                            .font(.system(size: 128))
                        
                        Text(
                            "Song \(viewModel.currentSongIndex + 1)",
                            comment: "Add preferences view current song name"
                        )
                        .font(.system(size: 32, weight: .bold))
                        
                        ProgressView(value: 0.2) {
                            EmptyView()
                        } currentValueLabel: {
                            Text("0:46")
                        }
                        
                        HStack {
                            Button("Dislike", systemImage: "xmark.circle") {
                                viewModel.currentSongIndex += 1
                            }
                            
                            Button("Play", systemImage: "play.circle") {
                                // to do
                            }
                            .font(.system(size: 64))
                            
                            Button("Like", systemImage: "heart.circle") {
                                viewModel.currentSongIndex += 1
                            }
                        }
                        .labelStyle(.iconOnly)
                        .font(.system(size: 48))
                    } else {
                        Spacer()
                        
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 64))
                        
                        Text("Rating completed!", comment: "Add preferences view rating completed header")
                            .font(.system(size: 32, weight: .bold))
                        
                        Text(
                            "You successfully defined your music preferences. Click the button below to finish the test.",
                            comment: "Add preferences view rating completed text"
                        )
                        .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Finish", comment: "Add preferences view finish test button")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
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
    }
}

#Preview {
    NavigationStack {
        AddPreferencesView()
    }
}
