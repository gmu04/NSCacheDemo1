//
//  Article.swift
//  NSCacheDemo1
//
//  Created by Gokhan Mutlu on 14.10.2026.
//

import Foundation

class Article: Identifiable, Equatable{
    let id = UUID()
    var name:String
    init(name: String) {
        self.name = name
    }
    static func == (lhs: borrowing Article, rhs: borrowing Article) -> Bool {
        lhs.id == rhs.id
    }
    
}
