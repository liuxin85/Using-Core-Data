//
//  Vocabulary.h
//  Using Core Data
//
//  Created by liuxin on 14-7-2.
//  Copyright (c) 2014年 liu xin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Word;

@interface Vocabulary : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *words;
@end

@interface Vocabulary (CoreDataGeneratedAccessors)

- (void)addWordsObject:(Word *)value;
- (void)removeWordsObject:(Word *)value;
- (void)addWords:(NSSet *)values;
- (void)removeWords:(NSSet *)values;

@end
