This demo app is about NSCache.

The following article is great starting source in addition to several medium articles, and Apple documentation.
https://www.swiftbysundell.com/articles/caching-in-swift/

NSCache is great to handle temporary caching needs for many scenarios,
however when the expire date is necessary for items, then it becomes complex to initialize.

In this demo, I have added builder pattern to Cache class to make it more intuitive abd usable.

Note:
I believe that Cache class which is a wrapper for NSCache type should not have caching permanently for two reasons.
1. "Caching" sounds like temporary cache
2. Based on SOLID.1 (single responsibility), permanent caching should be in another manager class.
   Once you put some method for it, you need to handle other edge cases (ex:how manage, when to delete, etc.) which temporary caching does not care at all.
   Besides, listening to memory warnings not enough, you need to observe file-system events.
   
So, my Cache class does not have permanent (file-based) caching

Happy Coding.
