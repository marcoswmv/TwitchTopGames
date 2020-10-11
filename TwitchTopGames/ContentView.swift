//
//  ContentView.swift
//  TwitchTopGames
//
//  Created by Marcos Vicente on 04.10.2020.
//

import SwiftUI

struct ContentView: View {
    @State var games = [Game]()
    
    var body: some View {
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
            .onAppear(perform: getGames)
            .navigationBarTitle("Twitch Top Games")
        }
        
    }
    
    func getGames() {
        let url = URL(string: "https://api.twitch.tv/kraken/games/top")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("sd4grh0omdj9a31exnpikhrmsu3v46", forHTTPHeaderField: "Client-ID")
        request.setValue("application/vnd.twitchtv.v5+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown response").")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try decoder.decode(GameResponse.self, from: data)
                games = decodedData.top
            } catch {
                print(error)
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
