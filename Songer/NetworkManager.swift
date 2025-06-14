//
//  NetworkManager.swift
//  Songer
//
//  Created by Kacper Grabiec on 24/05/2025.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func getAll<T: Codable>(
        path: String,
        decodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    ) async throws -> [T] {
        guard let url = URL(string: "\(NetworkConfiguration.baseURL)\(path)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = decodingStrategy
            
            return try decoder.decode([T].self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    func create<T: Codable>(path: String, data: T) async throws -> T {
        guard let url = URL(string: "\(NetworkConfiguration.baseURL)\(path)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        guard let jsonData = try? JSONEncoder().encode(data) else {
            throw NetworkError.encodingFailed
        }
        
        let (data, response) = try await URLSession.shared.upload(
            for: request,
            from: jsonData
        )
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    func update<T: Codable>(path: String, data: T) async throws -> T {
        guard let url = URL(string: "\(NetworkConfiguration.baseURL)\(path)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        guard let jsonData = try? JSONEncoder().encode(data) else {
            throw NetworkError.encodingFailed
        }
        
        let (data, response) = try await URLSession.shared.upload(
            for: request,
            from: jsonData
        )
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    func delete(path: String) async throws -> Bool {
        guard let url = URL(string: "\(NetworkConfiguration.baseURL)\(path)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        return true
    }
}
