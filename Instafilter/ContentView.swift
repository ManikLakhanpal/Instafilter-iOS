//
//  ContentView.swift
//  Instafilter
//
//  Created by Manik Lakhanpal on 10/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0
    
    var body: some View {
        Text("Hello World")
            .blur(radius: blurAmount)
        
        Slider(value: $blurAmount, in: 0...20)
        
        Button("Random blur") {
            blurAmount = Double.random(in: 0...20)
        }
    }
}

#Preview {
    ContentView()
}
