//
//  Word.h
//  Using Core Data
//
//  Created by liuxin on 14-7-2.
//  Copyright (c) 2014年 liu xin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Word : NSManagedObject

@property (nonatomic, retain) NSString * word;
@property (nonatomic, retain) NSString * translation;
@property (nonatomic, retain) NSManagedObject *vocabulary;

@end
