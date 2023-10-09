//
//  LocationDetailView.swift
//  RnMortyApi
//
//  Created by Arild Frøslie on 09/10/2023.
//

import SwiftUI
import Foundation

class LocationDetailViewModel: ObservableObject {
    @Published var residents: [RMUser] = []
    
    func fetchResidents(residentURLs: [String]) async {
        do {
            var fetchedResidents: [RMUser] = []
            
            for residentURL in residentURLs {
                if let url = URL(string: residentURL) {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    if let resident = try? decoder.decode(RMUser.self, from: data) {
                        fetchedResidents.append(resident)
                    }
                }
            }
            
            residents = fetchedResidents
        } catch {
            print("Error fetching residents: \(error)")
        }
    }
}
struct LocationDetailView: View {
    let location: Location
    @State private var residents: [RMUser] = []

    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Image(systemName: "globe.americas.fill")
                        Text("Type")
                        Spacer()
                        Text("\(location.type)")
                    }
                    HStack {
                        Image(systemName: "star.fill")
                        Text("Dimension")
                        Spacer()
                        Text("\(location.dimension)")
                    }
                    HStack{
                        Image(systemName: "questionmark.circle.fill")
                        Text("Id")
                        Spacer()
                        Text("\(location.id)")
                    }
                }

                Section(header: Text("Residents")) {
                    List(residents) { resident in
                        NavigationLink(destination: CharacterDetailView(rmUser: resident)) {
                            Text(resident.name)
                        }
                    }
                }
            }
            .onAppear {
                fetchResidents()
            }
        }
        .navigationTitle(location.name)
    }

    private func fetchResidents() {
        Task {
            do {
                let residentURLs = location.residents
                var fetchedResidents: [RMUser] = []

                for residentURL in residentURLs {
                    if let url = URL(string: residentURL) {
                        let (data, _) = try await URLSession.shared.data(from: url)
                        
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        if let resident = try? decoder.decode(RMUser.self, from: data) {
                            fetchedResidents.append(resident)
                        }
                    }
                }
                
                residents = fetchedResidents
            } catch {
                // Handle errors
                print("Error fetching residents: \(error)")
            }
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: Location(
            id: 1,
            name: "Earth",
            type: "Planet",
            dimension: "Dimension C-137",
            residents: [], // Provide an empty array or placeholder data
            url: "https://rickandmortyapi.com/api/location/1",
            created: "2017-11-10T12:42:04.162Z"
        ))
    }
}
