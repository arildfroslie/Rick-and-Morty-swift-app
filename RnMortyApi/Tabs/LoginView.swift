//
//  LoginView.swift
//  RnMortyApi
//
//  Created by Tommy Bakkane on 23/10/2023.
//

import SwiftUI
import KeychainSwift

struct LoginView: View {
    
    @EnvironmentObject var userData: UserData
    @State private var isProfileViewActive = false

    func isValidUser(username: String, password: String) -> Bool {
        let keychain = KeychainSwift()
        
        if let storedUsername = UserDefaults.standard.string(forKey: AppStorageKeys.username.rawValue),
           let storedPassword = keychain.get(AppStorageKeys.password.rawValue) {
            return username == storedUsername && password == storedPassword
        }
        
        return false
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Rick & Morty")
                    .font(.largeTitle).foregroundColor(Color.black)
                    .padding([.top, .bottom], 40)
                Image("login-image")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding(.bottom, 50)
                
                VStack {
                    TextField("Username", text: self.$userData.username)
                        .padding()
                        .cornerRadius(20.0)
                    SecureField("Password", text: self.$userData.password)
                        .padding()
                        .cornerRadius(20.0)
                }.padding([.leading, .trailing], 27.5)
                
                Button(action: {
                    if isValidUser(username: self.userData.username, password: self.userData.password) {
                        userData.isLoggedIn = true
                    }
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }
                Spacer()
                
                NavigationLink(destination: CreateProfileView(), isActive: $isProfileViewActive) {
                    Text("Don't have an account? Sign up here")
                        .onTapGesture {
                            isProfileViewActive = true
                        }
                }
                
                Spacer()
            }
            
        }
    }
}

#Preview {
    LoginView()
}
