//
//  ProfileView.swift
//  RnMortyApi
//
//  Created by Tommy Bakkane on 23/10/2023.
//

import SwiftUI
import KeychainSwift

enum AppStorageKeys: String {
    case username
    case password
}

struct ProfileView: View {
    
    @State var username: String?
    @State var password = ""
    
    @State var isLoggedIn: Bool = false
    @State var isDeleteProfileAlertPresented = false
    
    func onAppear() {
        
        if let username = UserDefaults.standard.object(forKey: AppStorageKeys.username.rawValue) as? String {
            isLoggedIn = true
            self.username = username
        }
        let keychain = KeychainSwift()
        if let password = keychain.get(AppStorageKeys.password.rawValue) {
            self.password = password
        }
        print(username as Any)
    }
    
    func deleteUserTapped() {
        isDeleteProfileAlertPresented = true // Show the delete profile confirmation alert
    }
    
    func deleteProfileConfirmed() {
        UserDefaults.standard.removeObject(forKey: AppStorageKeys.username.rawValue)
        let keychain = KeychainSwift()
        
        password = ""
        keychain.delete(AppStorageKeys.password.rawValue)
        keychain.clear()
        
        username = nil
        isLoggedIn = false
        
        isDeleteProfileAlertPresented = false // Dismiss the alert
    }
    
    
    var body: some View {
        if isLoggedIn {
            VStack {
                HStack {
                    Spacer()
                    
                    ZStack {
                        Image("profile-image")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .cornerRadius(20)
                            .padding(.top, 20)
                        
                    }
                    Spacer()
                }
                Text(username!)
                    .font(.title)
                    .fontWeight(.bold)
                
                NavigationStack {
                    List {
                        HStack {
                            Text("Edit Account")
                        }
                        HStack {
                            Text("Favorites")
                        }
                        
                        HStack {
                            Button(action: {
                                deleteUserTapped()
                            }) {
                                Text("Delete Profile")
                            }
                            .foregroundColor(.red)
                            Spacer()
                        }
                        .alert(isPresented: $isDeleteProfileAlertPresented) {
                                    Alert(
                                        title: Text("Delete Profile"),
                                        message: Text("Are you sure you want to delete your profile? This action cannot be undone."),
                                        primaryButton: .destructive(Text("Delete"), action: deleteProfileConfirmed),
                                        secondaryButton: .cancel()
                                    )
                                }
                    }
                }
                Button(action: {}, label: {
                    Text("Sign Out")
                })
                .padding(20)
            }
        } else {
            CreateProfileView()
        }
    }
}

#Preview {
    ProfileView()
}
