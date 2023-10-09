//
//  CharacterListView.swift
//  RnMortyApi
//
//  Created by Arild Frøslie on 09/10/2023.
//

import SwiftUI

struct CharacterListView: View {
    @State private var characters: [RMUser] = []

    var body: some View {
        NavigationView {
            List(characters) { character in
                NavigationLink(destination: CharacterDetailView(rmUser: character)) {
                    HStack {
                        AsyncImage(url: URL(string: character.image)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit() // Scale the image to fit the frame
                                    .frame(width: 50, height: 50) // Adjust the size as needed
                                    .cornerRadius(25) // Make it circular
                            default:
                                Color.clear
                            }
                        }
                        .padding(.trailing, 10) // Add some spacing between the image and text
                    }
                        Text(character.name)
                    }
                }
            .navigationTitle("Characters")
            }
            .onAppear {
                Task {
                    do {
                        let fetchedCharacters = try await GetAllCharacters()
                        characters = fetchedCharacters
                    } catch RMError.invalidURL {
                        print("Invalid URL!")
                    } catch RMError.invalidResponse {
                        print("Invalid response!")
                    } catch RMError.invalidData {
                        print("Invalid data!")
                    } catch {
                        print("Unexpected error!")
                    }
                }
            }
        }
    }



struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
