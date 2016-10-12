//
//  Entity.h
//  CoreDataManager
//
//  Created by shubham on 12/10/16.
//  Copyright © 2016 Sort. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Entity : NSObject

@property NSManagedObjectID *objectID;

-(id)initWithManagedObject:(NSManagedObject *)managedObject;
-(id)initWithServerDictionary:(NSDictionary *)dictionary;

-(void)storeValuesInManagedObject:(NSManagedObject *)managedObject;

@end
