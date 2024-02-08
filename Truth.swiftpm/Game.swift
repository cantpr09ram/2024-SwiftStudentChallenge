//
//  Game.swift
//  Truth
//
//  Created by bochain on 2/8/24.
//

import SwiftUI

struct Game: View {
    @State private var newModel: Model = Model()
    @State private var isFinished: Bool = false
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(newModel.messanges) { messange in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(messange.name)
                            Text(messange.messange)
                        }
                    }
                }
            }
            if isFinished == false {
                Messange(isFinished: isFinished) { updatedPost in
                    // 处理更新后的数据
                    self.newModel.messanges.append(updatedPost)
                }
                .padding()
            }
        }
    }
}

#Preview {
    Game()
}
