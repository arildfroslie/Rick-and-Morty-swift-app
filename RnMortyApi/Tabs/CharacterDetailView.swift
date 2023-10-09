//
//  CharacterDetailView.swift
//  RnMortyApi
//
//  Created by Arild Frøslie on 09/10/2023.
//

import SwiftUI


struct CharacterDetailView: View {
    
    @State private var characters: RMUser?
    let rmUser: RMUser
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: rmUser.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Rectangle())
                    .cornerRadius(8)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 220, height: 220)
            
            // User info
            Text(rmUser.name)
                .bold()
                .font(.title)
            
            Form {
                Section {
                    // ID
                    HStack {
                        Image(systemName: "questionmark.circle.fill")
                        Text("ID")
                        Spacer()
                        Text(String(rmUser.id))
                            .foregroundColor(.orange)
                    }
                    
                    // Status
                    HStack {
                        Image(systemName: "staroflife.fill")
                        Text("Status")
                        Spacer()
                        Text(rmUser.status)
                            .foregroundColor(getStatusColor(rmUser.status))
                    }
                    
                    // Species
                    HStack {
                        Image(systemName: "atom")
                        Text("Species")
                        Spacer()
                        Text(rmUser.species)
                            .foregroundColor(.orange)
                    }
                    
                    // Gender
                    HStack {
                        Image(systemName: "figure.dress.line.vertical.figure")
                        Text("Gender")
                        Spacer()
                        Text(rmUser.gender)
                            .foregroundColor(.orange)
                    }
                }
                .cornerRadius(5)
                
            }
            .padding()
            .task {
                do {
                    characters = try await GetCharacter()
                } catch RMError.invalidURL{
                    print("Invalid URL!")
                } catch RMError.invalidResponse{
                    print("Invalid response!")
                } catch RMError.invalidData{
                    print("Invalid data!")
                } catch {
                    print("unexpected error!")
                }
            }
        }
    }
}

func getStatusColor(_ status: String?) -> Color {
    switch status {
    case "Alive":
        return Color.green
    case "Dead":
        return Color.red
    case "unknown":
        return Color.gray
    default:
        return Color.gray // Default to gray for any other status
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a placeholder RMUser here
        CharacterDetailView(rmUser: RMUser(name: "Placeholder Name", status: "Alive", species: "Human", gender: "Male", image: "example-image-url", type: "", id: 1))
    }
}


