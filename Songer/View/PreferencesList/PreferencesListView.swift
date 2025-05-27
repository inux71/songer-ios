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
        List {
            ForEach(viewModel.filteredPreferences, id: \.id) { preference in
                NavigationLink(destination: PreferencesView(title: preference.title)) {
                    PreferencesListItem(
                        title: preference.title,
                        genres: preference.genres
                    )
                }
            }
            .onDelete { indexSet in
                Task {
                    await viewModel.deletePreference(indexSet: indexSet)
                }
            }
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.preferences.isEmpty {
                ContentUnavailableView(
                    label: {
                        Label(
                            "No preferences",
                            systemImage: "music.note.list"
                        )
                    },
                    description: {
                        Text(
                            "Add new preferences to get started",
                            comment: "Empty preference's list description"
                        )
                    },
                    actions: {
                        NavigationLink {
                            AddPreferencesView()
                        } label: {
                            Text(
                                "Add preferences",
                                comment: "Add preferences button label"
                            )
                        }
                    }
                )
            } else if viewModel.filteredPreferences.isEmpty {
                ContentUnavailableView.search
            }
        }
        .refreshable {
            Task {
                await viewModel.getPreferences()
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
