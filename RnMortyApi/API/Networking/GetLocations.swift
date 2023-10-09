//
//  GetLocations.swift
//  RnMortyApi
//
//  Created by Arild Frøslie on 09/10/2023.
//
import SwiftUI
import Foundation

class YourViewModel: ObservableObject {
    @Published var locations: [Location] = []

    func fetchLocations(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/location") else {
            // Handle invalid URL
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                // Handle the error
                print("Error: \(error.localizedDescription)")
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(LocationResponse.self, from: data)

                    // Update the locations array
                    DispatchQueue.main.async {
                        self.locations = response.results
                        completion()
                    }
                } catch {
                    // Handle JSON decoding error
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}


struct LocationResponse: Codable {
    let results: [Location]
    // Add other fields if needed
}
