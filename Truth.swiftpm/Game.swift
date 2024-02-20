//
//  Game.swift
//  Truth
//
//  Created by bochain on 2/8/24.
//

import SwiftUI

struct Game: View {
    @State private var newModel: Model = Model()
    @State private var gameState: GameState = .initial
    @State private var num: Int = 0
    @State private var sheetIsPresented: Bool = false
    
    var body: some View {
        VStack {
            if gameState == .initial {
                InitialView(original: $newModel, num: $num, gameState: $gameState)
            }else if (gameState == .post){
                //Text("post")
                NewPostView(original: $newModel, num: $num, gameState: $gameState)
            }else if gameState == .rate {
                //Text("rate")
                RatingView(original: $newModel, num: $num, gameState: $gameState, sheetIsPresented: $sheetIsPresented)
            }else{
                Text("something wrong")
            }
        }
        .sheet(isPresented: $sheetIsPresented, content: {
            Result(original: $newModel)
                .onAppear {
                    gameState = .initial
                }
            })
    }
}

enum GameState {
    case initial
    case post
    case rate
}

#Preview {
    Game()
}
//gameState: $gameState
//InitialView(original: $newModel.original, num: $num, isFinished: $isFinished)
//NewPostView(original: $newModel, num: $num, isFinished: $isFinished)
