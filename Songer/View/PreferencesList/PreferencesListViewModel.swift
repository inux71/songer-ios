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
    
    var filteredPreferences: [Preference] {
        if searchText.isEmpty {
            return preferences
        }
        
        return preferences.filter {
            $0.title.lowercased().contains(searchText.lowercased())
        }
    }
    
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
            case .encodingFailed:
                print("Encoding failed")
            }
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    @MainActor
    func deletePreference(indexSet: IndexSet) async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        guard let index: Int = indexSet.first else { return }
        
        do {
            let success: Bool = try await NetworkManager.shared.delete(path: "preferences/\(preferences[index].id)")
            
            if success {
                preferences.remove(at: index)
            }
        } catch let error as NetworkError {
            switch error {
            case .invalidURL:
                print("Invalid URL")
            case .badResponse:
                print("Bad response")
            case .decodingFailed:
                print("Decoding failed")
            case .encodingFailed:
                print("Encoding failed")
            }
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}
