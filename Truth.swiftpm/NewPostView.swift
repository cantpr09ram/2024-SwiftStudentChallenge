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
        VStack(spacing: 8) {
            Text("Please input the correct information as completely as possible after viewing the above photo (text) to help the next person understand the situation comprehensively.")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .multilineTextAlignment(.center)
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
                        .frame(height: 500)
                }
                
            } else {
                let lenOfMessange = original.messanges.count - 1
                let randomNumber = Int.random(in: 0...lenOfMessange)
                if randomNumber == 0 {
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
                    let selectedMessange = original.messanges[randomNumber].messange
                    Text(selectedMessange)
                }
            }
            HStack(spacing: 0) {
                Text("\(num)")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding()

            TextEditor(text: $messageText)
                .frame(width: 700, height: 200)
                .padding(5)
                .background(.gray.opacity(0.15))
                .cornerRadius(5)
            Text("The text you see might have been written by someone else, and the text you write could also be used as a reference by others.")
                .font(.footnote)
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
    }
}
