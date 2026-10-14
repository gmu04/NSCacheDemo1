//
//  NSCacheDemo1Tests.swift
//  NSCacheDemo1Tests
//
//  Created by Gokhan Mutlu on 14.10.2026.
//

import Testing
@testable import NSCacheDemo1
import Foundation

struct NSCacheDemo1Tests {

    /*@Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        // Swift Testing Documentation
        // https://developer.apple.com/documentation/testing
    }*/
    
    let article:Article
    let key:String
    var cacheBuilder = Cache<String, Article>.Builder(name: "article cache")
    
    init(){
        article = Article(name: "How to use NSCache")
        key = "gmu_docid_1.11"
    }
    
    @Test func retrieve_cached_item(){
        let cache = cacheBuilder.build()
        
        cache.insert(article, forKey: key)
        
        let expectedValue = article
        let cachedArticle = cache.value(forKey: key)
        #expect(cachedArticle == expectedValue)
    }
    
    @Test func retrieve_cached_item_with_subscript(){
        let cache = cacheBuilder.build()
        
        cache[key] = article
        
        let expectedValue = article
        let cachedArticle = cache[key]
        #expect(cachedArticle == expectedValue)
    }
    
    private func dateProvider() -> Date{
        Date()
    }
    
    @Test func retrieve_cached_notExpired_item(){
        let cache = cacheBuilder
            .setEntryLifetime(4, dateProvider: dateProvider)
            .build()

        //expires in 4 seconds
        cache.insert(article, forKey: key)
        
        let expectedValue = article
        let cachedArticle = cache.value(forKey: key)
        #expect(cachedArticle == expectedValue)
    }
    
    @Test func cannot_retrieve_expired_item(){
        let cache = cacheBuilder
            .setEntryLifetime(4, dateProvider: dateProvider)
            .build()
        
        //expires in 4 seconds
        cache.insert(article, forKey: key)
        
        Thread.sleep(until: dateProvider().addingTimeInterval(5))
        
        let cachedArticle = cache.value(forKey: key)
        #expect(cachedArticle == nil)
    }
    
    @Test func retrieve_cached_notExpired_item_with_subscript(){
        let cache = cacheBuilder
            .setEntryLifetime(4, dateProvider: dateProvider)
            .build()
        
        //expires in 4 seconds
        cache[key] = article
        
        let expectedValue = article
        let cachedArticle = cache[key]
        #expect(cachedArticle == expectedValue)
    }
    
    @Test func retrieve_cached_expired_item_with_subscript(){
        let cache = cacheBuilder
            .setEntryLifetime(4, dateProvider: dateProvider)
            .build()
        
        //expires in 4 seconds
        cache[key] = article
        
        Thread.sleep(until: dateProvider().addingTimeInterval(5))
        
        let cachedArticle = cache[key]
        #expect(cachedArticle == nil)
    }
    
    @Test func remove_cached_item_by_set_nil_with_subscript(){
        let cache = cacheBuilder
            .setEntryLifetime(4, dateProvider: dateProvider)
            .build()
         
        //expires in 4 seconds
        cache[key] = article
        let cachedArticle = cache[key]
        #expect(cachedArticle != nil && article == cachedArticle)
        
        cache[key] = nil
        let cachedArticleNil = cache[key]
        #expect(cachedArticleNil == nil)
    }
    
    

}
