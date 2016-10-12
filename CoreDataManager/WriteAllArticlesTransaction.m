//
//  WriteAllArticlesTransaction.m
//  CoreDataManager
//
//  Created by shubham on 12/10/16.
//  Copyright © 2016 Sort. All rights reserved.
//

#import "WriteAllArticlesTransaction.h"

@implementation WriteAllArticlesTransaction

-(void)executeTransactionInContext:(NSManagedObjectContext *)managedObjectContext{
    
    for(ArticleEntity *article in self.articles){
        NSManagedObject *mObject = [[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"Article" inManagedObjectContext:managedObjectContext] insertIntoManagedObjectContext:managedObjectContext];
        [article storeValuesInManagedObject:mObject];
    }
    
}

@end
