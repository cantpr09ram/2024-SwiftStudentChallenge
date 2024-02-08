//
//  Messenge.swift
//  Truth
//
//  Created by bochain on 2/8/24.
//

import SwiftUI

struct Messange: View {
    @State var isFinished: Bool = false
    @State private var messageText: String = "" // 用于接收用户输入的文本
    @State private var name: String = ""
    @State private var num: Int = 1
    var onUpdate: ((Post) -> Void)? // 闭包属性
    
    var body: some View {
        VStack(spacing: 10) {
            
            HStack (alignment: .center, spacing: 10){
                Text("\(num)")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(10)
                TextField("enter your name", text: $name)
            }
            .padding()
            
            TextEditor(text: $messageText)
                .frame(height: 200)
                .padding()
                .cornerRadius(5)
            
            HStack {
                Button{
                    let newPost = Post(num: num, name: name, messange: messageText) // 这里 "Name" 是假设的名称，你可以根据实际情况修改
                    onUpdate?(newPost)
                    name = ""
                    messageText = ""
                    num += 1
                } label: {
                    Text("Next")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                .padding()
                
                Button {
                    isFinished = true
                } label: {
                    Text("Submit")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                .padding()
            }
            
        }
        .padding(10)
        .background(.gray.opacity(0.15))
        .cornerRadius(20)
    }
}
