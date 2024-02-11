//
//  Result.swift
//  Truth
//
//  Created by bochain on 2/9/24.
//

import SwiftUI
import Charts

struct Result: View {
    @Binding var Data: [Post]
    
    @State private var isOpen: Bool = true
    var body: some View {
        VStack(spacing: 15) {
            Text("Result")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
            
            if Data.isEmpty {
                Text("Something wrong, try again")
            }else {
                Chart(Data) { data in
                    LineMark(
                        x: .value("num", data.num-1),
                        y: .value("acc" ,data.score)
                    )
                    .interpolationMethod(.catmullRom)
                }
                .padding(.leading, 100)
                .padding(.trailing, 100)
                .padding(.bottom, 100)
            }
        }
    }
}

struct Result_Previews: PreviewProvider {
    static var previews: some View {
        let Data: [Post] = [
            //.init(num: 0, name: "hello", messange: "hello world", score: 5, isRate: true),
            .init(num: 1, name: "hello", messange: "hello world", score: 4, isRate: true),
            .init(num: 2, name: "hello", messange: "hello world", score: 5, isRate: true),
            .init(num: 3, name: "hello", messange: "hello world", score: 3, isRate: true),
            .init(num: 4, name: "hello", messange: "hello world", score: 5, isRate: true),
            .init(num: 5, name: "hello", messange: "hello world", score: 2, isRate: true),
            .init(num: 6, name: "hello", messange: "hello world", score: 1, isRate: true),
            .init(num: 7, name: "hello", messange: "hello world", score: 5, isRate: true),
            .init(num: 8, name: "hello", messange: "hello world", score: 2, isRate: true),
            .init(num: 9, name: "hello", messange: "hello world", score: 5, isRate: true),
            .init(num: 10, name: "hello", messange: "hello world", score: 4, isRate: true),
            .init(num: 11, name: "hello", messange: "hello world", score: 5, isRate: true),
            .init(num: 12, name: "hello", messange: "hello world", score: 3, isRate: true),
            .init(num: 13, name: "hello", messange: "hello world", score: 2, isRate: true),
            .init(num: 14, name: "hello", messange: "hello world", score: 1, isRate: true),
            .init(num: 15, name: "hello", messange: "hello world", score: 2, isRate: true),
        ]
        
        Result(Data: .constant(Data))
    }
}
