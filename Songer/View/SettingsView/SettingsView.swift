//
//  SettingsView.swift
//  Songer
//
//  Created by Kacper Grabiec on 05/04/2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            
        }.navigationTitle(Text(
            "Settings",
            comment: "Settings view navigation title"
        ))
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
