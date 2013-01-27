//
//  Item+Helper.h
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import "Item.h"
#import "User.h"

#import "AFNetworking.h"

@interface Item (Helper)

-(void)saveToCloudWithUser:(User *)user;

@end
