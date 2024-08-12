//
//  ContentView.swift
//  Instafilter
//
//  Created by Manik Lakhanpal on 10/08/24.
//

import PhotosUI
import SwiftUI
import StoreKit

struct ContentView: View {
    @State private var pickerItems = [PhotosPickerItem]() // Allows us to select photos from library
    @State private var selectedImages = [Image]() // Array of photos :)
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        VStack {
            PhotosPicker("Select a picture", selection: $pickerItems, maxSelectionCount: 3 ,matching: .images)
            
            ShareLink(item: URL(string: "https://www.w16manik.ninja")!) {
                Label("swift", systemImage: "swift")
            }
            
            ScrollView {
                ForEach(0..<selectedImages.count, id: \.self) { i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
            
            Button("Leave a review") {
                requestReview()
            }
            
        }
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()
                
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
