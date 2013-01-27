//
//  Tag.h
//  ProcedureLog
//
//  Created by Andrew Vizor on 27/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Item *item;

@end
