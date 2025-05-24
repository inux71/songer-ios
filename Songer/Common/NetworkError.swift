//
//  NetworkError.swift
//  Songer
//
//  Created by Kacper Grabiec on 24/05/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badResponse
    case decodingFailed
}
