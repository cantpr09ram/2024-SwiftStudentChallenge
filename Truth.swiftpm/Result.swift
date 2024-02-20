//
//  Result.swift
//  Truth
//
//  Created by bochain on 2/9/24.
//

import SwiftUI
import Charts

struct Result: View {
    //@Binding var Data: [Post]
    @Binding var original: Model
    
    @State private var isOpen: Bool = true
    var body: some View {
        VStack(spacing: 15) {
            Text("Result")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                .padding(15)
            
            if original.messanges.isEmpty {
                Text("Something wrong, try again")
            }else {
                
                VStack {
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
                    
                    Chart(original.messanges) { data in
                        LineMark(
                            x: .value("num", data.num-1),
                            y: .value("acc" ,data.score)
                        )
                        .interpolationMethod(.catmullRom)
                        .lineStyle(.init(lineWidth: 10))
                    }
                    .frame(height: 300)
                    .chartYScale(domain: [1, 5])
                    .chartXAxis {
                        AxisMarks(values: .automatic(desiredCount: 0))
                    }

                    .padding(.leading, 100)
                    .padding(.trailing, 100)
                    .padding(.bottom, 100)
                }
            }
        }
        .padding(10)
    }
}
