//
//  Thread.swift
//  Truth
//
//  Created by bochain on 2/8/24.
//

import SwiftUI
import PhotosUI

struct Thread: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    
    var body: some View {
        if let selectedPhotoData,
            let image = UIImage(data: selectedPhotoData) {

            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .clipped()

        }
        
        PhotosPicker(selection: $selectedItem, matching: .any(of: [.images, .not(.livePhotos)])) {
            Label("Select a photo", systemImage: "photo")
        }
        .tint(.purple)
        .controlSize(.large)
        .buttonStyle(.borderedProminent)
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    selectedPhotoData = data
                }
            }
        }
    }
}

#Preview {
    Thread()
}
