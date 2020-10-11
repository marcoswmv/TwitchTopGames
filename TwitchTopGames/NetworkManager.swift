//
//  NetworkManager.swift
//  TwitchTopGames
//
//  Created by Marcos Vicente on 11.10.2020.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var games = [Game]()
    
    init() {
        getGames()
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
                
                DispatchQueue.main.async {
                    self.games = decodedData.top
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
