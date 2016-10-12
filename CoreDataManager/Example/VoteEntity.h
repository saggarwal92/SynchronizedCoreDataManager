//
//  VoteEntity.h
//  CoreDataManager
//
//  Created by shubham on 12/10/16.
//  Copyright © 2016 Sort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

@interface VoteEntity : Entity

@property (nonatomic,strong) NSString *article_id;
@property (nonatomic,assign) BOOL vote_flag;
@property (nonatomic,assign) NSTimeInterval timestamp;

@end
