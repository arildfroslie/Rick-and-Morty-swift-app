//
//  ContentView.swift
//  RnMortyApi
//
//  Created by Arild Frøslie on 09/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }
            CharacterListView()
                .tabItem{
                    Label("Characters", systemImage: "figure.stand")
                }
            LocationListView()
                .tabItem{
                    Label("Locations", systemImage: "location.circle.fill")
                }
            EpisodeView()
                .tabItem{
                    Label("Episodes", systemImage: "play.square.stack")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
