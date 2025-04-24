//
//  SongerApp.swift
//  Songer
//
//  Created by Kacper Grabiec on 04/04/2025.
//

import SwiftUI

@main
struct SongerApp: App {
    @AppStorage(UserDefaultsKeys.THEME)
    private var theme: String = ""
    
    private var colorScheme: ColorScheme {
        .from(theme)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                PreferencesListView()
            }
            .preferredColorScheme(colorScheme)
            .tint(colorScheme == .light ? .black : .white)
            .environmentObject(AudioManager())
        }
    }
}
