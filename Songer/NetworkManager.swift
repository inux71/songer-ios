//
//  NetworkManager.swift
//  Songer
//
//  Created by Kacper Grabiec on 24/05/2025.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let basePath: String = "http://127.0.0.1:8000/"
    
    func getAll<T: Codable>(path: String) async throws -> [T] {
        guard let url = URL(string: "\(basePath)\(path)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
