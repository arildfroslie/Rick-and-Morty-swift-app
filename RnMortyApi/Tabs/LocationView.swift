//
//  LocationView.swift
//  RnMortyApi
//
//  Created by Arild Frøslie on 09/10/2023.
//

import SwiftUI

struct LocationListView: View {
    @State private var locations: [Location] = []
    
    var body: some View {
        NavigationView {
            List(locations) { location in
                NavigationLink(destination: LocationDetailView(location: location)) {
                    Text(location.name)
                }
            }
            .navigationTitle("Locations")
            .onAppear {
                Task {
                    do {
                        let fetchedLocations = try await GetLocations()
                        locations = fetchedLocations
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
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
