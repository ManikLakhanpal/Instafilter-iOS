//
//  ContentView.swift
//  Instafilter
//
//  Created by Manik Lakhanpal on 10/08/24.
//

import PhotosUI
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                if let processedImage {
                    processedImage
                        .resizable()
                        .scaledToFit()
                } else {
                    PhotosPicker(selection: $selectedItem) {
                        if let processedImage {
                            processedImage
                                .resizable()
                                .scaledToFit()
                        } else {
                            ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Import a photo to get started"))
                        }
                    }
                    .onChange(of: selectedItem, loadImage)
                }
                                
                Spacer()
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity, in:0...1)
                        .onChange(of: filterIntensity, applyProcessing)
                }
                .padding(.vertical)

                HStack {
                    Button("Change Filter", action: changeFilter)
                    
                    Spacer()
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .toolbar {
                Button("Remove Item", systemImage: "trash") {
                selectedItem = nil
                processedImage = nil
                }
            }

        }
    }
    
    func changeFilter() {
        // functioning
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        currentFilter.intensity = Float(filterIntensity)

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
