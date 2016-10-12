//
//  Transaction.h
//  CoreDataManager
//
//  Created by shubham on 12/10/16.
//  Copyright © 2016 Sort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Transaction;

@protocol TransactionDelegate <NSObject>
-(void)onTransactionCompleted:(Transaction *)transaction;
@end


@interface Transaction : NSObject

@property (nonatomic,weak) id<TransactionDelegate> delegate;

-(BOOL)isPriorityTransaction;
-(void)executeTransactionInContext:(NSManagedObjectContext *)managedObjectContext;

@end


//Prioritized Transactions
@interface PriorityTransaction : Transaction

@end
