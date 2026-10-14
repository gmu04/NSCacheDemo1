//
//  Cache.swift
//  NSCacheDemo1
//
//  Created by Gokhan Mutlu on 14.10.2026.
//

import Foundation

final class Cache<Key:Hashable, Value>{
    private let _cache = NSCache<WrappedKey, Entry>()
    private var dateProvider: (() -> Date)?
    private var entryLifetime: TimeInterval?
    
    var builder:Builder = Builder()
    
    private init(){ }
    
}

//MARK: - methods & subscript

extension Cache{
    
    func insert(_ value:Value, forKey key: Key){
        var date:Date? = nil
        if let dateProvider, let entryLifetime {
            date = dateProvider().addingTimeInterval(entryLifetime)
        }
        let entry = Entry(value: value, expirationDate: date)
        _cache.setObject(entry, forKey: WrappedKey(key))
    }
    
    func removeValue(forKey key:Key){
        _cache.removeObject(forKey: WrappedKey(key))
    }
    
    func value(forKey key:Key) -> Value?{
        guard let entry = _cache.object(forKey: WrappedKey(key)) else{ return nil }
        
        // Discard values that have expired
        if let dateProvider,
           let expirationDate = entry.expirationDate,
              dateProvider() > expirationDate {
            removeValue(forKey: key)
            return nil
        }
        return entry.value
    }
    
    func removeAllObjects(){
        _cache.removeAllObjects()
    }
    
    subscript(key:Key) -> Value?{
        get{
            self.value(forKey: key)
        }
        set{
            guard let value = newValue else{
                // if nil was assigned using our subscript,
                // then we remove any value for that key
                removeValue(forKey: key)
                return
            }
            insert(value, forKey: key)
        }
    }
    
}


//MARK: - Builder DP

extension Cache{
    final class Builder{
        
        private(set) var countLimit: Int
        private(set) var totalCostLimit: Int
        private(set) var name: String
        private(set) var entryLifetime: TimeInterval?// = (12 * 60 * 60)
        private(set) var dateProvider: (() -> Date)?// = Date.init
        
        init() {
            countLimit = 0
            totalCostLimit = 0
            name = ""
        }
        
        /**
         convenience Initializer
         - Parameters:
         - countLimit: max number of objects in cache
         - totalCostLimit: how much bytes you need for caching. if items size exceeds, iOS evicts cached items automatically
         - name: name of the cache. It is useful when debugging
         */
        convenience init(countLimit: Int = 100, totalCostLimit: Int = (20 * 1024 * 1024), name: String = "default cache") {
            self.init()
            self.countLimit = countLimit
            self.totalCostLimit = totalCostLimit
            self.name = name
        }
        
        func setName(_ name:String) -> Builder{
            self.name = name
            return self
        }
        
        func setCountLimit(_ countLimit: Int = 100) -> Builder{
            self.countLimit = countLimit
            return self
        }
        
        func setTotalCostLimit(_ totalCostLimit: Int = (20 * 1024 * 1024)) -> Builder{
            self.totalCostLimit = totalCostLimit
            return self
        }
        
        /**
         entryLifetime and dateProvider is complementary
         */
        func setEntryLifetime(_ entryLifetime: TimeInterval?, dateProvider:@escaping (() -> Date)) -> Builder{
            self.entryLifetime = entryLifetime
            self.dateProvider = dateProvider
            return self
        }
        
        func build() -> Cache{
            let cache = Cache()
            cache._cache.countLimit = countLimit
            cache._cache.totalCostLimit = totalCostLimit
            cache._cache.name = name
            
            cache.entryLifetime = entryLifetime
            cache.dateProvider = dateProvider
            
            return cache
        }
    }
}
