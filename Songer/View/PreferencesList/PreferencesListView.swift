//
//  PreferencesListView.swift
//  Songer
//
//  Created by Kacper Grabiec on 05/04/2025.
//

import SwiftUI

struct PreferencesListView: View {
    @StateObject private var viewModel = PreferencesListViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.preferences.isEmpty {
                Text(
                    "Your preference's list is empty.",
                    comment: "Preferences list view no preferences message"
                )
            } else {
                List($viewModel.preferences, id: \.id, editActions: .delete) { $preference in
                    NavigationLink(destination: PreferencesView(title: preference.title)) {
                        PreferencesListItem(
                            title: preference.title,
                            genres: preference.genres
                        )
                    }
                }
                .refreshable {
                    Task {
                        await viewModel.getPreferences()
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.getPreferences()
            }
        }
        .navigationTitle(Text(
            "Your preferences",
            comment: "Preferences list view navigation title"
        ))
        .toolbar {
            ToolbarItemGroup {
                NavigationLink {
                    AddPreferencesView()
                } label: {
                    Label("Add preferences", systemImage: "plus.circle")
                }
                
                NavigationLink {
                    SettingsView()
                } label: {
                    Label("Settings", systemImage: "gear")
                }
            }
        }
        .searchable(text: $viewModel.searchText)
    }
}

#Preview {
    NavigationStack {
        PreferencesListView()
    }
}
