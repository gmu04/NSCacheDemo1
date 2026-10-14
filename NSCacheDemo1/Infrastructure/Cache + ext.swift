//
//  Cache + ext.swift
//  NSCacheDemo1
//
//  Created by Gokhan Mutlu on 14.10.2026.
//

import Foundation

extension Cache{
    
    final class WrappedKey:NSObject{
        let key: Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        override var hash: Int{ key.hashValue }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else { return false }
            return value.key == key
        }
    }
    
    final class Entry{
        let value: Value
        let expirationDate: Date?
        
        init(value: Value, expirationDate: Date? = nil) {
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}





