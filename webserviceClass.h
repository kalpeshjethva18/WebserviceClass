//
//  webserviceClass.h
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

#import <Foundation/Foundation.h>
@interface webserviceClass : NSObject
@property (weak) id <WebserviceProtocol> delegate;
-(void)webservice:(NSString *)apistring didFetchPosts:(NSString *)postData;
@end
