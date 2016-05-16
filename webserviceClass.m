//
//  webserviceClass.m
//  NearbyOfferz
//
//  Created by macpc on 13/05/16.
//  Copyright (c) 2016 shah.harshul@yahoo.com. All rights reserved.
//
/*
 @protocol WebserviceProtocol <NSObject>
 
 -(void)WSprotocol:(NSMutableDictionary *)responseDict;
 
 @end
 */

#import "webserviceClass.h"

@implementation webserviceClass

@synthesize delegate;

-(void)webservice:(NSString *)webservice didFetchPosts:(NSString *)postData;
{
    NSMutableURLRequest *apiRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[webservice stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    [apiRequest setTimeoutInterval:30.0];
    [apiRequest setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration  defaultSessionConfiguration];
    defaultConfigObject.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    [apiRequest setHTTPMethod:@"POST"];
    [apiRequest setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [apiRequest setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:apiRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSString *responseString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
         if(![responseString isKindOfClass:[NSNull class]])
         {
             if(!([responseString isEqualToString:@""]||[responseString isEqualToString:@"(null)"]||responseString==nil))
             {
                 NSMutableDictionary *responseDict = nil;
                 NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                 NSError *e;
                 responseDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&e];
                 
                 if(responseDict != NULL)
                 {
                     if([[responseDict valueForKeyPath:@"header.status"] isEqualToString:@"200"])
                     {
                         [delegate WSprotocol:responseDict];
                     }
                 }
             }
             else{
                 NSLog(@"time out of request");
                 NSMutableDictionary *responseDict = nil;
                 [responseDict setValue:@"yes" forKey:@"TimeOut"];
                 [delegate WSprotocol:responseDict];
             }
         }
     }];
}
@end