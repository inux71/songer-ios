//
//  PreferencesViewModel.swift
//  Songer
//
//  Created by Kacper Grabiec on 08/04/2025.
//

import AVFAudio
import Foundation

class PreferencesViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var songs: [Song] = []
    @Published var selectedSong: Song? = nil
    
    private var selectedSongIndex: Int? {
        guard let selected = selectedSong else { return nil }
        
        return songs.firstIndex(where: { $0.id == selected.id })
    }
    
    func setPreviousSong() {
        guard let currentIndex = selectedSongIndex else { return }
        
        let previousIndex = (currentIndex - 1 + songs.count) % songs.count
        selectedSong = songs[previousIndex]
    }
    
    func setNextSong() {
        guard let currentIndex = selectedSongIndex else { return }
        
        let nextIndex = (currentIndex + 1) % songs.count
        selectedSong = songs[nextIndex]
    }
    
    @MainActor
    func getSongs(withId id: Int) async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            songs = try await NetworkManager.shared.getAll(path: "songs/\(id)")
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
    func renamePreference(withId id: Int, newTitle: String) async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            let renamePreferenceRequest = RenamePreferenceRequest(title: newTitle)
            _ = try await NetworkManager.shared.update(path: "preferences/\(id)", data: renamePreferenceRequest)
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
