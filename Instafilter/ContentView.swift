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
    @State private var amount = 0.0
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Set filter amount") {
                    Text("Amount of Filter: \(amount, format: .number.precision(.fractionLength(2)))")
                    Slider(value: $amount, in: 0...1)
                        .onChange(of: amount, loadImage)
                }
                
                VStack{
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onAppear(perform: loadImage)
            }
            .navigationTitle("Filter")
            
        }
    }
    
    func loadImage() {
        let inputImage = UIImage(resource: .example)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
