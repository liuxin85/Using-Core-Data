//
//  VocabulariesViewController.h
//  Using Core Data
//
//  Created by liuxin on 14-7-2.
//  Copyright (c) 2014年 liu xin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vocabulary.h"

@interface VocabulariesViewController : UITableViewController <UIAlertViewDelegate>
@property (strong, nonatomic)NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic)NSFetchedResultsController *fetchedResultsController;
- (id)initWithManagedObjectContext: (NSManagedObjectContext *)context;

@end
