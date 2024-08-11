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
        ContentUnavailableView {
            Label("No snippets", systemImage: "swift")
        } description: {
            Text("No data available right now :)")
        } actions: {
            Button("Create a snippet") {}
                .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentView()
}
