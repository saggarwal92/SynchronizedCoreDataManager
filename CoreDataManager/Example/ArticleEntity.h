//
//  ArticleEntity.h
//  CoreDataManager
//
//  Created by shubham on 12/10/16.
//  Copyright © 2016 Sort. All rights reserved.
//

#import "Entity.h"

@interface ArticleEntity : Entity

@property (nonatomic,strong) NSString *article_id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;

@property (nonatomic,assign) NSTimeInterval created_at;

@end
