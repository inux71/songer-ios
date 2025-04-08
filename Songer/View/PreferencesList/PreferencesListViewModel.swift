//
//  PreferencesListViewModel.swift
//  Songer
//
//  Created by Kacper Grabiec on 05/04/2025.
//

import Foundation

class PreferencesListViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var preferences: [String] = [
        "Rock your body",
        "Sing along",
        "Dance like nobody's watching",
        "Make everyone laugh",
        "Be yourself"
    ]
}
