//
//  Messenge.swift
//  Truth
//
//  Created by bochain on 2/8/24.
//

import SwiftUI

struct NewPostView: View {
    @Binding var original: Model
    @Binding var num: Int
    @Binding var gameState: GameState
    //@Binding var sheetIsPresented: Bool
    
    @State private var messageText: String = ""
    @State private var name: String = ""

    var body: some View {
        VStack(spacing: 10) {
            if num == 1 {
                if (original.Mode == .text) {
                    Text(original.original)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .background(Color.gray.opacity(0.2))
                        .padding()
                } else {
                    original.original_pic
                        .resizable()
                        .scaledToFit()
                        .clipped()
                }
                
            } else {
                let lenOfMessange = original.messanges.count - 1
                let randomNumber = Int.random(in: 0...lenOfMessange)
                if randomNumber == 0 {
                    Text(original.original)
                } else {
                    let selectedMessange = original.messanges[randomNumber].messange
                    Text(selectedMessange)
                }
            }
            HStack(alignment: .center, spacing: 10) {
                Text("\(num)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(10)
                TextField("enter your name", text: $name)
            }
            .padding()

            TextEditor(text: $messageText)
                .frame(height: 300)
                .padding()
                .cornerRadius(5)

            HStack {
                Button("Next") {
                    let newPost = Post(num: num, name: name, messange: messageText)
                    original.messanges.append(newPost)
                    name = ""
                    messageText = ""
                    num += 1
                }
                .font(.title)
                .fontWeight(.bold)
                .padding()

                Button("Submit") {
                    let newPost = Post(num: num, name: name, messange: messageText)
                    original.messanges.append(newPost)
                    gameState = .rate
                    print(num)
                }
                .font(.title)
                .fontWeight(.bold)
                .padding()
            }
        }
        .frame(width: 900, height: 910)
        .padding(10)
        .background(Color.gray.opacity(0.15))
        .cornerRadius(20)
    }
}
