//
//  Game.swift
//  TwitchTopGames
//
//  Created by Marcos Vicente on 04.10.2020.
//

import SwiftUI

struct GameResponse: Codable {
    var top: [Game]
}

struct Game: Codable, Identifiable {
    
    enum CodingKeys: String, CodingKey {
        case game = "game"
        case viewers = "viewers"
        case channels = "channels"
    }
    
    enum GameCodingKeys: String, CodingKey {
        case id = "_id"
        case name = "name"
        case logo = "logo"
    }
    
    enum LogoCodingKeys: String, CodingKey {
        case thumbnail = "small"
        case banner = "large"
    }
    
    var id = 0
    var name = "COD"
    var channels = 10
    var viewers = 90
    var thumbnailImage = "image1"
    var bannerImage = "image2"
    
    init () { }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let game = try container.nestedContainer(keyedBy: GameCodingKeys.self, forKey: .game)
        let logo = try game.nestedContainer(keyedBy: LogoCodingKeys.self, forKey: .logo)
        
        id = try game.decode(Int.self, forKey: .id)
        name = try game.decode(String.self, forKey: .name)
        channels = try container.decode(Int.self, forKey: .channels)
        viewers = try container.decode(Int.self, forKey: .viewers)
        thumbnailImage = try logo.decode(String.self, forKey: .thumbnail)
        bannerImage = try logo.decode(String.self, forKey: .banner)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var game = container.nestedContainer(keyedBy: GameCodingKeys.self, forKey: .game)
        var logo = game.nestedContainer(keyedBy: LogoCodingKeys.self, forKey: .logo)
        
        try game.encode(id, forKey: .id)
        try game.encode(name, forKey: .name)
        try container.encode(channels, forKey: .channels)
        try container.encode(viewers, forKey: .viewers)
        try logo.encode(thumbnailImage, forKey: .thumbnail)
        try logo.encode(bannerImage, forKey: .banner)
    }
}
