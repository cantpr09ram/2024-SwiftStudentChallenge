//
//  Test.swift
//  Truth
//
//  Created by bochain on 2/11/24.
//

import SwiftUI

struct Test: View {
    // 定义一个状态变量来存储符合条件的随机数
    @State private var randomNumber: Int?
    
    var body: some View {
        VStack {
            Text("Random Number: \(randomNumber ?? 0)")
                .padding()
            
            Button("Generate Random Number") {
                // 生成符合条件的随机数
                randomNumber = generateRandomNumber()
            }
            .padding()
        }
    }
    
    // 生成符合条件的随机数的函数
    func generateRandomNumber() -> Int {
        var randomNum: Int = 0
        
        // 循环直到符合条件的随机数生成为止
        while true {
            // 生成随机数
            randomNum = Int.random(in: 1...10)
            
            // 检查随机数是否满足条件（示例中条件为偶数）
            if randomNum % 2 == 0 {
                break // 如果满足条件，则退出循环
            }
        }
        
        return randomNum
    }
}

#Preview {
    Test()
}
