//
//  Entity.m
//  CoreDataManager
//
//  Created by shubham on 12/10/16.
//  Copyright © 2016 Sort. All rights reserved.
//

#import "Entity.h"

@implementation Entity


-(id)initWithManagedObject:(NSManagedObject *)managedObject{
    self = [self init];
    if(self){
        if(managedObject){
            NSDictionary *attributes = [[managedObject entity] attributesByName];
            for(NSString *attributeName in attributes){
                NSObject *value = [managedObject valueForKey:attributeName];
                if(value){
                    [self setValue:value forKey:attributeName];
                }
            }
            self.objectID = managedObject.objectID;
        }
    }
    return self;
}

-(id)initWithServerDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(void)storeValuesInManagedObject:(NSManagedObject *)managedObject{
    NSDictionary *attributes = [[managedObject entity] attributesByName];
    for(NSString *attributeName in attributes){
        NSObject *value = [self valueForKey:attributeName];
        if([value isKindOfClass:[NSNull class]]){
            //NSLog(@"Value For Attribute: %@ is Null",attributeName );
            continue;   //Do Not Store Null Class Values
        }
        [managedObject setValue:value forKey:attributeName];
    }
}

@end
