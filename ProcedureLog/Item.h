//
//  Item.h
//  ProcedureLog
//
//  Created by Andrew Vizor on 27/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tag;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) Tag *tag;

@end
