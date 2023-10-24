//
//  RnMortyApiApp.swift
//  RnMortyApi
//
//  Created by Arild Frøslie on 09/10/2023.
//

import SwiftUI
import KeychainSwift

@main
struct RnMortyApiApp: App {
    
    @StateObject var userData = UserData()
    
    func fetchUser() {
        if let username = UserDefaults.standard.object(forKey: AppStorageKeys.username.rawValue) as? String {
            self.userData.username = username
        }
        let keychain = KeychainSwift()
        if let password = keychain.get(AppStorageKeys.password.rawValue) {
            self.userData.password = password
        }
        
        if !self.userData.username.isEmpty && !self.userData.password.isEmpty {
            self.userData.isLoggedIn = true
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
                .onAppear() {
                    fetchUser()
                }
        }
    }
}

