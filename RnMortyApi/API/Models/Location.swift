//
//  Location.swift
//  RnMortyApi
//
//  Created by Arild Frøslie on 09/10/2023.
//

import Foundation

struct Location: Codable, Identifiable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
