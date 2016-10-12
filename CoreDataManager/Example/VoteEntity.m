//
//  VoteEntity.m
//  CoreDataManager
//
//  Created by shubham on 12/10/16.
//  Copyright © 2016 Sort. All rights reserved.
//

#import "VoteEntity.h"

@implementation VoteEntity

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timestamp = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}

@end
