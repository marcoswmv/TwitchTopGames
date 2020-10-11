//
//  GameDetail.swift
//  TwitchTopGames
//
//  Created by Marcos Vicente on 04.10.2020.
//

import SwiftUI
import struct Kingfisher.KFImage

struct GameDetail: View {
    @State var game: Game
    
    var body: some View {
        
        VStack(alignment: .leading,spacing: 40) {
            
            if let url = URL(string: game.bannerImage) {
                KFImage(url)
                    .placeholder  {
                        Image("image2")
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(Rectangle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 20)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(game.name)")
                    .font(.title)
                
                Text("Channel: \(game.channels)")
                Text("Viewers: \(game.viewers)")
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
        
    }
}

struct GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        GameDetail(game: Game())
    }
}
