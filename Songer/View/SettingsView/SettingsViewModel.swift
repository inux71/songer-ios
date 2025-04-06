//
//  SettingsViewModel.swift
//  Songer
//
//  Created by Kacper Grabiec on 06/04/2025.
//

import SwiftUI
import Foundation

class SettingsViewModel: ObservableObject {
    private let repository = UserDefaultsRepository()
    
    @Published
    var selectedColorScheme: ColorScheme {
        didSet {
            repository.save(selectedColorScheme.asString, forKey: UserDefaultsKeys.THEME)
        }
    }
    
    init() {
        let theme: String = repository.getString(forKey: UserDefaultsKeys.THEME) ?? ""
        selectedColorScheme = ColorScheme.from(theme)
    }
    
    func clearData() {
        repository.clear()
        
        selectedColorScheme = ColorScheme.from("")
    }
}
