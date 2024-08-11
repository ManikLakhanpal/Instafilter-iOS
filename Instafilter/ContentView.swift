//
//  ContentView.swift
//  Instafilter
//
//  Created by Manik Lakhanpal on 10/08/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFill()
        }
        .ignoresSafeArea()
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        // Converts UI image to Core Image for editing.
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext() // object to use full potential of CPU and the GPU.
        let currentFilter = CIFilter.sepiaTone() // basically our filter.
        
        currentFilter.inputImage = beginImage // Image which is beign given to modify.
        
        let amount = 0.4
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return } // gets the output CI image.
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }  // Converts CI to CG.
        
        let uiImage = UIImage(cgImage: cgImage) // CG to UI image.
        image = Image(uiImage: uiImage)
        
    }
}

#Preview {
    ContentView()
}
