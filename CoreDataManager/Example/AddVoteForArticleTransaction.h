//
//  AddVoteForArticleTransaction.h
//  CoreDataManager
//
//  Created by shubham on 12/10/16.
//  Copyright © 2016 Sort. All rights reserved.
//

#import "Transaction.h"
#import "VoteEntity.h"

@interface AddVoteForArticleTransaction : Transaction

@property VoteEntity *vote;

@end
