//
//  GameRow.swift
//  TwitchTopGames
//
//  Created by Marcos Vicente on 04.10.2020.
//

import SwiftUI
import struct Kingfisher.KFImage

struct GameRow: View {
    @State var game: Game
    @State var position = 0
    
    var body: some View {
        HStack(spacing: 20) {
            
            Text("\(position)")
                .font(.title)
            
            if let url = URL(string: game.thumbnailImage) {
                KFImage(url)
                    .placeholder  {
                        Image("image1")
                    }
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(game.name)
                    .font(.headline)
                    
                HStack {
                    Text("Channels: \(game.channels)")
                    Text("Viewers: \(game.viewers)")
                }
                .font(.footnote)
            }
        }
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(game: Game())
            .previewLayout(.fixed(width: 300, height: 80))
    }
}
