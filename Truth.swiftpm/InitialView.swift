//
//  InitialView.swift
//  Truth
//
//  Created by bochain on 2/10/24.
//

import SwiftUI

struct InitialView: View {
    @Binding var original: String
    @Binding var num: Int
    @Binding var gameState: GameState
    
    @State private var messageText: String = ""
    @State private var userMode: Mode = .Default
    // for sliding Effect
    @Namespace private var animation
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 10) {
                Text("Input original news clip in order to start this game. You can either use default case or upload Photo")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                .multilineTextAlignment(.center)
            }
            //Custom Segmented Picker
            HStack(spacing: 0) {
                ForEach(Mode.allCases, id: \.rawValue) { mode in
                    Text(mode.rawValue)
                        .padding(.vertical, 10)
                        .frame(width: 100)
                        .background {
                            ZStack {
                                if userMode == mode {
                                    Capsule()
                                        .fill(.gray)
                                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                }
                            }
                            .animation(.snappy, value: userMode)
                        }
                        .contentShape(.rect)
                        .onTapGesture {
                            userMode = mode
                        }
                }
            }
            .padding(3)
            .background(.primary.opacity(0.06), in: .capsule)
            .padding(.top, 20)
            
            if userMode == .Default {
                Text("using default mode")
                    .frame(height: 530)
            } else if  userMode == .img{
                Text("upload image from photo app")
                    .frame(height: 530)
            } else {
                TextEditor(text: $messageText)
                    .frame(height: 500)
                    .padding(20)
            }

            Button("Start") {
                gameState = .post
                original = messageText
                num += 1
                messageText = ""
            }
            .font(.title)
            .fontWeight(.bold)
            .padding()
        }
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(width: 900, height: 910)
        .padding(10)
        .background(Color.gray.opacity(0.15))
        .cornerRadius(20)
    }
}

enum Mode: String, CaseIterable{
    case Default = "Default"
    case img = "Image"
    case text = "Text"
    
   
}
