**This demo app is about NSCache.**

The following article is great starting source in addition to several medium articles, and Apple documentation.
https://www.swiftbysundell.com/articles/caching-in-swift/

NSCache is great to handle temporary caching needs for many scenarios,
however when the expire date is necessary for items, then it becomes complex to initialize.


In this demo, I have added the builder pattern to Cache class to make it more intuitive and usable.


**Notes:**
Permanent caching is necessary for offline-first, or caching big data scenarios. We can also use SQLite DB instead of file system (with CoreData or Swift Data).

I think Cache class which is a wrapper for NSCache type do not cache permanently for two reasons:
   1. "Caching" sounds like a temporary cache,
   2. Based on SOLID.1 (single responsibility), permanent caching needs to be in another manager class.
      Once you put some method for it, you need to handle other cases (ex:how to manage, when to delete, etc.) which temporary caching does not care about them at all.
      Besides, listening to memory warnings is not enough, you need to observe file-system events.
   
So, my Cache class does not have permanent (file-based) caching.


🐝 Happy coding.
