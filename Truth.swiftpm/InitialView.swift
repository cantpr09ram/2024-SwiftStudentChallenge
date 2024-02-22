//
//  InitialView.swift
//  Truth
//
//  Created by bochain on 2/10/24.
//

import SwiftUI
import PhotosUI

struct InitialView: View {
    @Binding var original: Model
    @Binding var num: Int
    @Binding var gameState: GameState
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
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
                            original.Mode = userMode
                        }
                }
            }
            .padding(3)
            .background(.primary.opacity(0.06), in: .capsule)
            .padding(.top, 20)
            
            if userMode == .Default {
                original.original_pic
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .frame(height: 530)
            } else if  userMode == .img{
                VStack {
                    //Text("Input news clip text to start game")
                    ZStack {
                        if let selectedPhotoData,
                            let image = UIImage(data: selectedPhotoData) {

                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
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
                    .frame(height: 530)
                }
            } else {
                //Text("Input news clip text to start game")
                //    .font(.title3)
                TextEditor(text: $messageText)
                    .frame(height: 520)
                    .padding(5)
                    .background(.gray.opacity(0.15))
                    
            }

            Button("Start") {
                gameState = .post
                
                if original.Mode == .text {
                    original.original = messageText
                } else if (original.Mode == .img) {
                    original.original_pic = Image(uiImage: UIImage(data: selectedPhotoData!)!)
                }
                
                num += 1
                messageText = ""
            }
            .font(.title)
            .fontWeight(.bold)
            .padding()
            .tint(.purple)
        }
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(width: 900, height: 970)
        .padding(10)
        .cornerRadius(20)
    }
}

enum Mode: String, CaseIterable{
    case Default = "Default"
    case img = "Image"
    case text = "Text"
    
   
}
