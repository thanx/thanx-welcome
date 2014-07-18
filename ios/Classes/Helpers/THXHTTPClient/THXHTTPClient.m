//
//  THXHTTPClient.m
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "THXHTTPClient.h"
#import "AFHTTPRequestOperationManager.h"

#ifdef DEBUG
  static NSString * const THXClientUrl = @"http://thanx-welcome.dev/api";
#else
  static NSString * const THXClientUrl = @"http://welcome.thanx.com/api";
#endif
static NSString * const THXClientVersion = @"v1.0";

@interface THXHTTPClient()
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSString *url;
@end

@implementation THXHTTPClient

+ (THXHTTPClient *)sharedInstance {
  static THXHTTPClient * _sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[self alloc] init];
    _sharedInstance.manager = AFHTTPRequestOperationManager.manager;
    _sharedInstance.url = [NSString stringWithFormat:@"%@/%@", THXClientUrl, THXClientVersion];
  });
  
  return _sharedInstance;
}

- (void)postToPath:(NSString*)path parameters:(NSDictionary *)params {
  [self postToPath:path parameters:params success:nil failure:nil];
}

- (void)postToPath:(NSString*)path
        parameters:(NSDictionary *)params
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
  
  [self.manager POST:[NSString stringWithFormat:@"%@/%@", self.url, path]
          parameters:params
             success:success
             failure:failure
   ];
}

@end
