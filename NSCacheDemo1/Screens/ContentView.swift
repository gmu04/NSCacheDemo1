//
//  ContentView.swift
//  NSCacheDemo1
//
//  Created by Gokhan Mutlu on 14.10.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var isdownloading = true
    @State private var image = UIImage()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Button("Fetch and Cache", systemImage: "square.and.arrow.down"){
                    
                }
                .buttonStyle(.bordered)
                .backgroundStyle(.gray)
                .tint(.black)
                .padding(.bottom, 20)
                
                Image(uiImage: image)
                    .resizable()
                    .overlay {
                        if isdownloading{
                            Text("Placeholder image here")
                                .foregroundStyle(.white)
                        }
                    }
                    .background(.gray)
                                
                Spacer()
                .navigationTitle("HowTo: NSCache")
                .navigationBarTitleDisplayMode(.inline)
            }
            .padding()
        }
    }
    
    private func fetchImage() async{
        // no view model for demo
        
    }
    
}

#Preview {
    ContentView()
}
