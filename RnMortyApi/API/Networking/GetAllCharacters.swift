//
//  GetAllCharacters.swift
//  RnMortyApi
//
//  Created by Arild Frøslie on 09/10/2023.
//
import SwiftUI
import Foundation

func GetAllCharacters() async throws -> [RMUser] {
    let endpoint = "https://rickandmortyapi.com/api/character"
    
    guard let url = URL(string: endpoint) else {
        throw RMError.invalidURL
    }
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Print the raw data for debugging
        print("Raw Data:", String(data: data, encoding: .utf8) ?? "Invalid Data")
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw RMError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // Decode the API response into RMApiResponse
        let apiResponse = try decoder.decode(RMApiResponse.self, from: data)
        
        // Extract and return the results array
        return apiResponse.results
    } catch {
        throw RMError.invalidData
    }
}



