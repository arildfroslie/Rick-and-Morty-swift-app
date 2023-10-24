//
//  LoginView.swift
//  RnMortyApi
//
//  Created by Tommy Bakkane on 23/10/2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var isProfileViewActive = false
    
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
                    TextField("Username", text: self.$username)
                        .padding()
                        .cornerRadius(20.0)
                    SecureField("Password", text: self.$password)
                        .padding()
                        .cornerRadius(20.0)
                }.padding([.leading, .trailing], 27.5)
                
                Button(action: {}) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }
                Spacer()
                
                NavigationLink(destination: ProfileView(), isActive: $isProfileViewActive) { // NavigationLink to ProfileView
                    Text("Don't have an account? Sign up here")
                        .onTapGesture {
                            isProfileViewActive = true // Activate the NavigationLink
                        }
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LoginView()
}
