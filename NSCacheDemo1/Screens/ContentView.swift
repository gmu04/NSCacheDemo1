//
//  ContentView.swift
//  NSCacheDemo1
//
//  Created by Gokhan Mutlu on 14.10.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var isdownloading = false
    @State private var image = UIImage()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Button("Fetch and Cache", systemImage: "square.and.arrow.down"){
                    Task{
                        await self.fetchImage()
                    }
                }
                .buttonStyle(.bordered)
                .backgroundStyle(.gray)
                .tint(.black)
                .padding(.bottom, 20)
                
                Image(uiImage: image)
                    .resizable()
                    .overlay {
                        if isdownloading{
                            Text("Loading...")
                                .foregroundStyle(.white)
                                .font(.title)
                                .bold()
                        }
                    }
                    .background(.gray)
                
                Spacer()
                
                Button("Delete cache", systemImage: "trash"){
                    imageCache.removeAllObjects()
                }
                .buttonStyle(.bordered)
                .backgroundStyle(.gray)
                .tint(.black)
                .padding(.bottom, 20)
                
                .navigationTitle("HowTo: NSCache")
                .navigationBarTitleDisplayMode(.inline)
            }
            .padding()
        }
    }
    
    
    //MARK: - for quick demo - no view model
    
    private let downloadManager = DownloadManager()
    private let imageCache:Cache<String, Data>
    private let imageKey = "imageUniqueKey"
    typealias ImageData = Data
    
    init(){
        self.imageCache = Cache<String, ImageData>.Builder(name: "article cache").build()
    }
    
 
    private func fetchImage() async{
        
        self.isdownloading = false
        
        //image is in cache
        if let data = self.imageCache.value(forKey: imageKey),
           let image = UIImage(data: data) {
            print("Cached image will show")
            self.image = image
            return
        }
        
        self.isdownloading = true
        
        //download image
        guard let data = await downloadManager.downloadImage() else{ return }
        guard let image = UIImage(data: data) else{ return }
        print("Image fetched, cashed, and will show")
        self.imageCache.insert(data, forKey: imageKey)
        self.image = image
        self.isdownloading = false
    }
    
}

#Preview {
    ContentView()
}
