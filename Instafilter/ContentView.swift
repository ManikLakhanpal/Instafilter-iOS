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
    @State private var pickerItems: PhotosPickerItem?
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                if let processedImage {
                    processedImage
                        .resizable()
                        .scaledToFit()
                } else {
                    PhotosPicker(selection: $pickerItems, matching: .images) {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                                
                Spacer()
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity, in:0...1)
                }
                .padding(.vertical)

                HStack {
                    Button("Change Filter") {
                        // Change filter
                    }
                    
                    Spacer()
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: pickerItems) {
                Task {
                    processedImage = try await pickerItems?.loadTransferable(type: Image.self)
                }
            }
            .toolbar {
                Button("Remove", systemImage: "trash") {
                    pickerItems = nil
                    processedImage = nil
                }
                .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    ContentView()
}
