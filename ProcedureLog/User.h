//
//  User.h
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *email, *token, *userID;
@property (nonatomic, assign) bool shouldAutoLogin;


+(id)sharedUser;

-(BOOL)checkAutoLogin;
-(void)signInEmail:(NSString *)email andPassword:(NSString *)password;
-(void)registerUser:(NSString *)aemail withPassword:(NSString *)apassword;

-(void)forgetUser;

@end
