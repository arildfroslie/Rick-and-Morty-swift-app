    //
    //  CreateProfileView.swift
    //  RnMortyApi
    //
    //  Created by Tommy Bakkane on 23/10/2023.
    //

    import SwiftUI
    import KeychainSwift

    struct CreateProfileView: View {
        @State var username: String?
        @State var password = ""
        
        
        func createUserTapped() {
            let keychain = KeychainSwift()
            keychain.set(password, forKey: AppStorageKeys.password.rawValue)
            
            UserDefaults.standard.setValue(username, forKey: AppStorageKeys.username.rawValue)
        }
        
        var body: some View {
            VStack {
                Text("Create Profile")
                    .font(.title)
                    .padding()
                Form {
                    TextField("Brukernavn", text:
                                Binding(get: {
                        if let username = username {
                            return username
                        }
                        return ""
                    }, set: { newValue, transaction in
                        username = newValue
                    }))
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .padding()
                    
                    SecureField("Passord", text: $password)
                        .padding()
                    
                    HStack{
                        Spacer()
                        Button("Create User") {
                            createUserTapped()
                        }
                        .padding(20)
                        Spacer()
                    }
                }
            }
        }
    }

    #Preview {
        CreateProfileView()
    }
