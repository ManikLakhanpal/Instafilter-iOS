//
//  ContentView.swift
//  Instafilter
//
//  Created by Manik Lakhanpal on 10/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var show = false
    
    var body: some View {
        Button("Random blur") {
            show.toggle()
        }
            .frame(width: 130, height: 130)
            .background(.blue)
            .clipShape(Circle())
            .foregroundStyle(.white)
            .overlay {
                Rectangle().stroke(.clear ,lineWidth: 1)
            }
            .shadow(radius: 3)
            .confirmationDialog("Hi", isPresented: $show) {
                Button("Hi") { }
            }
    }
}

#Preview {
    ContentView()
}
