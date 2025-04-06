//
//  SettingsView.swift
//  Songer
//
//  Created by Kacper Grabiec on 05/04/2025.
//

import SwiftUI

struct SettingsView: View {
    @StateObject
    private var viewModel = SettingsViewModel()
    
    var body: some View {
        List {
            Section(header: Text(
                "Apperance",
                comment: "Settings apperance section header"
            )) {
                Picker(selection: $viewModel.selectedColorScheme) {
                    Text("Light", comment: "Light mode").tag(ColorScheme.light)
                    Text("Dark", comment: "Dark mode").tag(ColorScheme.dark)
                } label: {
                    Text("Theme", comment: "Theme settings option")
                }
            }
            
            Section {
                Button(
                    role: .destructive,
                    action: {
                        viewModel.clearData()
                    }
                ) {
                    Text("Clear data", comment: "Clear data settings button")
                }
            }
        }
        .navigationTitle(Text("Settings", comment: "Settings view navigation title"))
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
