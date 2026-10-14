//
//  DownloadManager.swift
//  NSCacheDemo1
//
//  Created by Gokhan Mutlu on 14.10.2026.
//

import Foundation

class DownloadManager{
    private let urlString = "https://images.unsplash.com/photo-1791237917252-66b8117065c9?q=80&w=2360&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    
    private var url: URL{
        guard let url = URL(string: urlString) else{ fatalError("invalid url") }
        return url
    }
    
    func downloadImage() async -> Data?{
        let request = URLRequest(url: self.url)
        do{
            try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 sn wait
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
        }catch{
            print(error)
            return nil
        }
    }
    
}
