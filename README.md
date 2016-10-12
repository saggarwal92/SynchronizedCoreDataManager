# SynchronizedCoreDataManager
SynchronizedCoreDataManager

# Some listed problems encountered with using Core-Data:
1. How to have thread-safe entities?
2. We needed a proper sequencing between every database transaction.
3. How to have prioritized tasks?

# RE-DESIGN:
1. Converting non-thread-safe entities to a thread-safe entity. We call it Entity.
2. Modifying the blocks into a class Transaction. Only one Transaction can execute at a time.
3. Maintaining the list of priority and all-other tasks independently. Writing SynchronizedCoreDataManager to handle this.

The project also contains the example:
Example-Entities:
 - VoteEntity
 - ArticleEntity
 
Example-Transactions:
 - ReadAllArticles
 - WriteAllArticles
 - WriteVote

# TestFile demonstrates the use of the RE-DESIGN
