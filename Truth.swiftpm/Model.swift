//
//  Model.swift
//  Truth
//
//  Created by bochain on 2/8/24.
//

import SwiftUI

struct Model: Identifiable {
    var id: UUID = UUID()
    var original: String = ""
    var score: Double = 0
    var messanges: [Post] = []
}

struct Post: Identifiable {
    var id: UUID = UUID()
    var num: Int = 0
    var name: String = ""
    var messange: String = ""
}
