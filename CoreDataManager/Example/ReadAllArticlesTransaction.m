//
//  ReadAllArticlesTransaction.m
//  CoreDataManager
//
//  Created by shubham on 12/10/16.
//  Copyright © 2016 Sort. All rights reserved.
//

#import "ReadAllArticlesTransaction.h"

@implementation ReadAllArticlesTransaction

-(void)executeTransactionInContext:(NSManagedObjectContext *)managedObjectContext{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Article" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects) {
        NSMutableArray *articles = [NSMutableArray array];
        for(NSManagedObject *mObject in fetchedObjects){
            [articles addObject:[[ArticleEntity alloc] initWithManagedObject:mObject]];
        }
        _articles = [articles copy];
    }
    
}

@end
