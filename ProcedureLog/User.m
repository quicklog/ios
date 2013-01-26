//
//  User.m
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import "User.h"
#import "AFNetworking.h"
#import "NSString+Helper.h"

static User *sharedUser = nil;

@implementation User

#pragma mark Singleton Methods
+(id)sharedUser
{
	@synchronized(self)
	{
		if(sharedUser == nil)
		{
			sharedUser = [[super allocWithZone:NULL] init];
		}
	}
	return sharedUser;
}

-(id)init
{
	if(self = [super init])
	{
		//set properties to defaults
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"User %@, %@",self.email, self.token];
	
}


#pragma mark User methods
-(BOOL)checkAutoLogin
{
    return YES;
}

-(void)signInEmail:(NSString *)email andPassword:(NSString *)password
{
    
    NSString *login = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *pass = [password stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *test = [NSURL URLWithString:API_ROOT];
    AFHTTPClient *client =  [AFHTTPClient clientWithBaseURL:nil];
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [client setParameterEncoding:AFFormURLParameterEncoding];

    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:login forKey:@"email"];
    [parameters setValue:pass forKey:@"pass"];
    
    NSMutableURLRequest *urlRequest = [client requestWithMethod:@"GET" path:@"register/" parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest
                                                                                        success: ^(NSURLRequest *request, NSURLResponse *response, id JSON)
                                         {
                                             
                                         }
                                                                                        failure:^(NSURLRequest *request, NSURLResponse *response, NSError *error, id JSON){
        
                                                                                        }
                                         ];
}


-(void)registerUser:(NSString *)aemail withPassword:(NSString *)apassword
{
    NSString *user = [aemail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *pass = [apassword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(void)forgetUser
{
    
}



@end
