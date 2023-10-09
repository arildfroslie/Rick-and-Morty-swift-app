//
//  RMCharacters.swift
//  RnMortyApi
//
//  Created by Arild Frøslie on 09/10/2023.
//

import Foundation

struct RMUser: Codable, Identifiable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let type: String
    let id: Int
}
struct RMApiResponse: Codable {
    let info: RMInfo
    let results: [RMUser]
}

struct RMInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
