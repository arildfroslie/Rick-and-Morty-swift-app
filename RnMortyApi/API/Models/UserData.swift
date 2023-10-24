//
//  UserData.swift
//  RnMortyApi
//
//  Created by Tommy Bakkane on 24/10/2023.
//

import Foundation

class UserData: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
}
