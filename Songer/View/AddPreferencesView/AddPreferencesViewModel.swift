//
//  AddPreferencesViewModel.swift
//  Songer
//
//  Created by Kacper Grabiec on 06/04/2025.
//

import Foundation

class AddPreferencesViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var songs: [Song] = []
    @Published var currentSongIndex: Int = 0
    
    var likedGenres: Set<String> = Set()
    
    var progress: Float {
        guard !songs.isEmpty else { return 1 }
        return Float(currentSongIndex) / Float(songs.count)
    }
    
    init() {
        Task {
            await getSongs()
        }
    }
    
    @MainActor
    private func getSongs() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            songs = try await NetworkManager.shared.getAll(path: "songs/random")
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
    func uploadPreference() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        let preference: Preference = Preference(
            id: -1,
            title: "My new preference",
            genres: Array(likedGenres)
        )
        
        do {
            _ = try await NetworkManager.shared.create(
                path: "preferences",
                data: preference
            )
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
