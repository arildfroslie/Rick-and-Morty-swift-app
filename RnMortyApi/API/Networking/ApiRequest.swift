//
//  ApiRequest.swift
//  RnMortyApi
//
//  Created by Arild Frøslie on 09/10/2023.
//

import SwiftUI


func GetCharacter() async throws -> RMUser{
        let endpoint = "https://rickandmortyapi.com/api/character/1"
        
        guard let url = URL(string: endpoint) else {
            throw RMError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw RMError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(RMUser.self, from: data)
        } catch {
            throw RMError.invalidData
        }
    }


enum RMError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

