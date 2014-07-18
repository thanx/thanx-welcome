//
//  THXHTTPClient.h
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

@interface THXHTTPClient : NSObject

+ (THXHTTPClient *)sharedInstance;

- (void)postToPath:(NSString*)path
       parameters:(NSDictionary *)params;

- (void)postToPath:(NSString*)path
        parameters:(NSDictionary *)params
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
