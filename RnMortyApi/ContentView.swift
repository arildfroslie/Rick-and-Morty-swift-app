//
//  ContentView.swift
//  RnMortyApi
//
//  Created by Arild Frøslie on 09/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        if isLoggedIn{
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
                ProfileView()
                    .tabItem {
                        Label("Profile" , systemImage: "person.fill")
                    }
            }
        }else{
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
