//
//  ReadAllArticlesTransaction.h
//  CoreDataManager
//
//  Created by shubham on 12/10/16.
//  Copyright © 2016 Sort. All rights reserved.
//

#import "Transaction.h"
#import "ArticleEntity.h"

@interface ReadAllArticlesTransaction : PriorityTransaction
@property (readonly) NSArray<ArticleEntity *> *articles;
@end
