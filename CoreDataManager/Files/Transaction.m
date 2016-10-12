//
//  Transaction.m
//  CoreDataManager
//
//  Created by shubham on 12/10/16.
//  Copyright © 2016 Sort. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction

-(BOOL)isPriorityTransaction{
    return NO;
}

-(void)executeTransactionInContext:(NSManagedObjectContext *)managedObjectContext{
}

@end


@implementation PriorityTransaction

@end


