//
//  THXHTTPClient.m
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "THXHTTPClient.h"
#import "AFHTTPRequestOperationManager.h"

static NSString *THXClientUrl = @"http://welcome.thanx.com/api";
static NSString *THXClientVersion = @"v1.0";

@interface THXHTTPClient()
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSString *url;
@end

@implementation THXHTTPClient

-(id)init {
  self = [super init];
  if (self) {
    self.manager = [AFHTTPRequestOperationManager manager];
    self.url = [NSString stringWithFormat:@"%@%@", THXClientUrl, THXClientVersion];
  }
  return self;
}

-(void)postToPath:(NSString*)path andParams:(NSDictionary *)params {
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:params];
  parameters[@"email"] = [NSUserDefaults.standardUserDefaults valueForKey:@"email"];
  [self.manager POST:[NSString stringWithFormat:@"%@/%@", self.url, path]
     parameters:parameters
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          NSLog(@"JSON: %@", responseObject);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"Error: %@", error);
        }
   ];

}

@end
