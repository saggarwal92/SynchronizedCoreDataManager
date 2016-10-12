//
//  SynchronizedCoreDataManager.h
//  SynchronizedCoreDataManager
//
//  Created by shubham on 12/10/16.
//  Copyright © 2016 Sort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transaction.h"

@interface SynchronizedCoreDataManager : NSObject

-(void)executeTransactionSync:(Transaction *)transaction;
-(void)executeTransactionAsync:(Transaction *)transaction;

-(void)saveState;   //Call this When App is Crashed or Terminated

@end
