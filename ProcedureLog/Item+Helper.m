//
//  Item+Helper.m
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import "Item+Helper.h"
#import "User.h"

@implementation Item (Helper)

+(NSArray *)getAllMyProceedures
{
    NSArray *myProceedures = [self MR_findAll];
    return myProceedures;
}

-(void)saveToCloudWithUser:(User *)user
{
    AFHTTPClient *client =  [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:API_ROOT]];
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [client setParameterEncoding:AFFormURLParameterEncoding];
    
    
    int timestamp = [[NSDate date] timeIntervalSince1970];

    
    NSMutableArray *tags = [NSMutableArray arrayWithObject:@"testtag"];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue: self.uid forKey:@"id"];
    [parameters setValue:tags forKey:@"tags"];
    [parameters setValue: self.comment forKey:@"comment"];
    [parameters setValue: self.rating forKey:@"rating"];
    [parameters setValue:[NSNumber numberWithInt:timestamp]  forKey:@"timestamp"];
    
    
    NSMutableArray *itemsToSend = [NSMutableArray arrayWithObject:parameters];
    
    
    NSLog(@"Parameters %@", itemsToSend);
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:itemsToSend options:NSJSONWritingPrettyPrinted error:&error];
    
    NSMutableURLRequest *urlRequest = [client requestWithMethod:@"POST" path:@"me/items/" parameters:nil];
    [urlRequest setHTTPBody:jsonData];
    [urlRequest setValue:user.token forHTTPHeaderField:@"USERTOKEN"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest
                                                                                        success: ^(NSURLRequest *request, NSURLResponse *response, id JSON)
                                         {
                                             NSLog(@"Saved %@",JSON);
                                         }
                                                                                        failure:^(NSURLRequest *request, NSURLResponse *response, NSError *error, id JSON){
                                                                                            
                                                                                            NSLog(@"Error %@ ",JSON);
                                                                                            
                                                                                        }
                                         ];
    
    
    [operation start];
}

@end
