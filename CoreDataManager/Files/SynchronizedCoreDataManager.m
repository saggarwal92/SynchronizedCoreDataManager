//
//  SynchronizedCoreDataManager.m
//  SynchronizedCoreDataManager
//
//  Created by shubham on 12/10/16.
//  Copyright © 2016 Sort. All rights reserved.
//

#import "SynchronizedCoreDataManager.h"

@interface SynchronizedCoreDataManager()

@property (nonatomic,strong) Transaction *currentExecutingTransaction;

@property (nonatomic,strong) NSMutableArray *priorityTransactions; //All Priority Transactions
@property (nonatomic,strong) NSMutableArray *allOtherTransactions;  //All Non Priority Transactions

@property (nonatomic,strong) dispatch_queue_t core_data_queue;
@property (nonatomic,strong) dispatch_queue_t priority_transaction_array_queue;
@property (nonatomic,strong) dispatch_queue_t allother_transaction_array_queue;

@property BOOL executing;
@property BOOL willStartExecution;
@property BOOL doStopExecution;

@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic,strong) NSPersistentStoreCoordinator *persistantStoreCoordinator;
@property (nonatomic,strong) NSString *persistantStorePath;

@end



@implementation SynchronizedCoreDataManager

-(instancetype)init{
    self = [super init];
    if(self){
        _priorityTransactions = [NSMutableArray array];
        _allOtherTransactions = [NSMutableArray array];
        
        _core_data_queue = dispatch_queue_create("nc_cd_queue", NULL);
        _priority_transaction_array_queue = dispatch_queue_create("nc_read_queue", NULL);
        _allother_transaction_array_queue = dispatch_queue_create("nc_write_queue", NULL);
        
        _executing = NO;
        _willStartExecution = NO;
        _doStopExecution = NO;
        
        dispatch_sync(_core_data_queue, ^{
            [self initializeCoreData];
        });
    }
    return self;
}

-(void)initializeCoreData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths lastObject];
    
    self.persistantStorePath = [documentDirectory stringByAppendingString:@"/TestModel.sqlite"];
    NSURL *storeURL = [NSURL fileURLWithPath:self.persistantStorePath];
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TestModel" withExtension:@"momd"];
    
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    self.persistantStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    [self.managedObjectContext setPersistentStoreCoordinator:self.persistantStoreCoordinator];
    [self.managedObjectContext setUndoManager:nil];
    
    
    NSDictionary *options = @{NSInferMappingModelAutomaticallyOption: @YES, NSMigratePersistentStoresAutomaticallyOption: @YES, NSSQLitePragmasOption: @{@"synchronous": @"OFF"}};
    
    NSError *error = nil;
    
    if(![self.persistantStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]){
        //NSLog(@"Error creating store %@",error);
        
    }else{
        //NSLog(@"Successfully Created Persistant Store");
    }
    
}

-(void)executeTransactionSync:(Transaction *)transaction{
    [self.managedObjectContext performBlockAndWait:^{
        [transaction executeTransactionInContext:self.managedObjectContext];
    }];
}

-(void)executeTransactionAsync:(Transaction *)transaction{
    if([transaction isPriorityTransaction]){
        dispatch_sync(_priority_transaction_array_queue, ^{
            [_priorityTransactions addObject:transaction];
        });
    }else{
        dispatch_sync(_allother_transaction_array_queue, ^{
            [_allOtherTransactions addObject:transaction];
        });
    }
    
    
}

-(void)executeIfNotExecuting{
    if(_executing == YES || _willStartExecution == YES) return;
    _willStartExecution = YES;
    [self startExecution];
}

-(void)startExecution{
    
    dispatch_async(_core_data_queue, ^{
        
        _willStartExecution = NO;
        _executing = YES;
        
        while(TRUE){
            
            __block Transaction *transaction = nil;
            
            dispatch_sync(_priority_transaction_array_queue, ^{
                if([_priorityTransactions count] > 0){
                    transaction = [_priorityTransactions objectAtIndex:0];
                    [_priorityTransactions removeObject:transaction];
                }
            });
            
            if(transaction == nil){
                dispatch_sync(_allother_transaction_array_queue, ^{
                    if([_allOtherTransactions count] > 0){
                        transaction = [_allOtherTransactions objectAtIndex:0];
                        [_allOtherTransactions removeObject:transaction];
                    }
                    
                });
            }
            
            if(transaction == nil){
                if(_executing == NO){
                    break; // Break the loop since execution was turned off last time.
                }
                _executing = NO;    //DO NOT SIMPLY BREAK THE LOOP
            }else{
                //[LoggerFile log:@"NotebookCoreDataManager: Executing Operation: %@",operation];
                
                _executing = YES;
                if([transaction isPriorityTransaction] == YES){
                    _currentExecutingTransaction = transaction;
                }
                [self.managedObjectContext performBlockAndWait:^{
                    [transaction executeTransactionInContext:self.managedObjectContext];
                }];
                if(transaction.delegate){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if(transaction.delegate){
                            [transaction.delegate onTransactionCompleted:transaction];
                        }
                    });
                }
            }
        }
        
        _executing = NO;
        _currentExecutingTransaction = nil;
        
        //SAVE
        if([self.managedObjectContext hasChanges]){
            @try{
                [self.managedObjectContext performBlockAndWait:^{
                    NSError *error;
                    [self.managedObjectContext save:&error];
                    if(error){
                        //NSLog(@"CoreDataError: while saving context: %@",error);
                    }
                }];
            }@catch(NSException *exception){
                //NSLog(@"CoreDataException: %@",exception);
            }
        }
        
    });
    
}


-(void)saveState{
    
}

@end
