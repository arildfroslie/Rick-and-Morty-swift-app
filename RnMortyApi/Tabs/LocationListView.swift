//
//  LocationListView.swift
//  RnMortyApi
//
//  Created by Arild Frøslie on 09/10/2023.
//

import SwiftUI

struct LocationListView: View {
    @StateObject private var viewModel = YourViewModel() // Replace 'YourViewModel' with your actual ViewModel class

    var body: some View {
        NavigationView {
            List(viewModel.locations) { location in
                NavigationLink(destination: LocationDetailView(location: location)) {
                    Text(location.name)
                }
            }
            .navigationTitle("Locations")
            .onAppear {
                viewModel.fetchLocations {
                    // Optional: Add any logic you need when locations are fetched.
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
 
