//
//  PreferencesListViewModel.swift
//  Songer
//
//  Created by Kacper Grabiec on 05/04/2025.
//

import Foundation

class PreferencesListViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var preferences: [Preference] = []
    
    @MainActor
    func getPreferences() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            preferences = try await NetworkManager.shared.getAll(path: "preferences")
        } catch let error as NetworkError {
            switch error {
            case .invalidURL:
                print("Invalid URL")
            case .badResponse:
                print("Bad response")
            case .decodingFailed:
                print("Decoding failed")
            }
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}
