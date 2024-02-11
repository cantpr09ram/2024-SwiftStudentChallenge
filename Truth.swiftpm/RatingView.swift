//
//  RatingView.swift
//  Truth
//
//  Created by bochain on 2/10/24.
//

import SwiftUI

struct RatingView: View {
    @Binding var original: Model
    @Binding var num: Int
    @Binding var gameState: GameState
    @Binding var sheetIsPresented: Bool
    
    @State private var userScore: Score = .completelyFake
    @State private var randomNumber: Int?
    @Namespace private var animation
    
    
    var body: some View {
        VStack {
            VStack {
                Text("This is the article you need to review, please rate this article base on the original post below")
                    .font(.subheadline)
                
                VStack {
                    Text("Original")
                        .font(.title3.bold())
                        .frame(alignment: .leading)
                    Text(original.original)
                }
                .padding()
            }
            .padding(20)
            
            VStack {
                Text("Rate the Post below base on the acc compare to original post")
                if (num == 0){
                    Text("Something wrong")
                    Text("\(num)")
                }else{
                    
                    let selectedMessange = original.messanges[randomNumber ?? 0].messange
                    Text("\(num)")
                    Text(selectedMessange)
                }
            }
            .padding(20)
            .onAppear {
                randomNumber = generateRandomNumber()
            }
            
            HStack {
                
                Text("COMPLETELY FAKE")
                    .font(.title3.bold())
                Spacer()
                    .frame(minWidth: 0, idealWidth: 150, maxWidth: 250)
                Text("COMPLETELY TRUE")
                    .font(.title3.bold())
            }
            HStack(spacing: 0) {
                ForEach(Score.allCases, id: \.rawValue) { mode in
                    Text("\(mode.rawValue)")
                        .padding(.vertical, 10)
                        .frame(width: 100)
                        .background {
                            ZStack {
                                if userScore == mode {
                                    Capsule()
                                        .fill(.gray)
                                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                }
                            }
                            .animation(.snappy, value: userScore)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            userScore = mode
                        }
                }
            }
            .padding(3)
            .background(Color.primary.opacity(0.06), in: Capsule())
            .padding(.top, 20)
            
            
            HStack {
                Button("Next") {
                    print(userScore)
                    print(num)
                    original.messanges[randomNumber ?? 0].isRate = true
                    original.messanges[randomNumber ?? 0].score = userScore.rawValue
                    num -= 1
                    randomNumber = generateRandomNumber()
                }
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .disabled(num == 1)

                Button("Submit") {
                    original.messanges[randomNumber ?? 0].isRate = true
                    original.messanges[randomNumber ?? 0].score = userScore.rawValue
                    sheetIsPresented = true
                }
                .font(.title)
                .fontWeight(.bold)
                .padding()
            }
        }
    }
    
    func generateRandomNumber() -> Int {
        var randomNum: Int = 0
        
        while num > 0 {
            randomNum = Int.random(in: 0...original.messanges.count - 1)
            print(randomNum)
            if (original.messanges[randomNum].isRate == false) {
                break
            }
        }
        
        return randomNum
    }
}


enum Score: Int, CaseIterable {
    case completelyFake = 1
    case mostlyFake = 2
    case halfTrueHalfFake = 3
    case mostlyTrue = 4
    case completelyTrue = 5
}
