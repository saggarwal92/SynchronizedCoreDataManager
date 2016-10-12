//
//  AddVoteForArticleTransaction.m
//  CoreDataManager
//
//  Created by shubham on 12/10/16.
//  Copyright © 2016 Sort. All rights reserved.
//

#import "AddVoteForArticleTransaction.h"

@implementation AddVoteForArticleTransaction

-(void)executeTransactionInContext:(NSManagedObjectContext *)managedObjectContext{
    
    NSManagedObject *mObject = [[NSManagedObject alloc] initWithEntity:[NSEntityDescription entityForName:@"Vote" inManagedObjectContext:managedObjectContext] insertIntoManagedObjectContext:managedObjectContext];
    
    [self.vote storeValuesInManagedObject:mObject];
    
}

@end
