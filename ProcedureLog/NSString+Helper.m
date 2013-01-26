//
//  NSString+Helper.m
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

-(BOOL) empty
{
	return ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0);
}

@end
