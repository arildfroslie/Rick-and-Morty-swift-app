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
    
    @EnvironmentObject var userData: UserData
    @State var isDeleteProfileAlertPresented = false
    
    
    
    func deleteUserTapped() {
        isDeleteProfileAlertPresented = true // Show the delete profile confirmation alert
    }
    
    func deleteProfileConfirmed() {
        UserDefaults.standard.removeObject(forKey: AppStorageKeys.username.rawValue)
        let keychain = KeychainSwift()
        
        userData.password = ""
        keychain.delete(AppStorageKeys.password.rawValue)
        keychain.clear()
        
        userData.username = ""
        userData.isLoggedIn = false
        
        isDeleteProfileAlertPresented = false
    }
    
    
    var body: some View {
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
            Text(userData.username)
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
            Button(action: {
                userData.isLoggedIn = false
            }, label: {
                Text("Sign Out")
            })
            .padding(20)
        }
    }
}

#Preview {
    ProfileView()
}
