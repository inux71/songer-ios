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
        List($viewModel.preferences, id: \.self, editActions: .delete) { $preference in
            NavigationLink(destination: PreferencesView(title: preference)) {
                PreferencesListItem(
                    title: preference,
                    genres: [
                        "Pop",
                        "Rock",
                        "Hip-hop"
                    ]
                )
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
