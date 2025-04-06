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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                PreferencesListView()
                    .preferredColorScheme(ColorScheme.from(theme))
            }
        }
    }
}
