//
//  ContentView.swift
//  TwitchTopGames
//
//  Created by Marcos Vicente on 04.10.2020.
//

import SwiftUI

struct ContentView: View {
    @State var games = [Game]()
    @ObservedObject private var networkManager = NetworkManager()
    
    var body: some View {
        
        let games = networkManager.games
        
        NavigationView {
            
            List {
                ForEach(Array(zip(games.indices, games)), id: \.0) { index, game in
                    NavigationLink(
                        destination: GameDetail(game: game),
                        label: {
                            GameRow(game: game, position: index+1)
                                .padding(EdgeInsets(top: 10,
                                                    leading: 0,
                                                    bottom: 10,
                                                    trailing: 0))
                        })
                }
            }
            .navigationBarTitle("Twitch Top Games")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
