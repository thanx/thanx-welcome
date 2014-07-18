//
//  THXAuth.m
//  ThanxWelcome
//
//  Created by Marc Fernandez on 7/18/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "THXAuth.h"
#import "THXHTTPClient.h"
#import <SSKeychain.h>

NSString * const THXWelcomeServiceName = @"WelcomeService";

@implementation THXAuth

+ (THXAuth *)sharedInstance {
  static THXAuth * _sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[self alloc] init];
    _sharedInstance.email = _sharedInstance.emailFromKeyChain;
    _sharedInstance.apiKey = [_sharedInstance apiKeyForAccount:_sharedInstance.email];
  });
  
  return _sharedInstance;
}

- (void)loginWithAccount:(NSString *)account andPassword:(NSString *)password {
  [THXHTTPClient.sharedInstance postToPath:@"auth"
                                parameters:@{@"email": account, @"password": password}
                                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    NSString * apiKey = [responseObject[@"api_key"] stringValue];
    if (apiKey && apiKey.length > 0) {
      NSError * error;
      [SSKeychain setPassword:apiKey forService:THXWelcomeServiceName account:account error:&error];
      if (!error) {
        _email = account;
        _apiKey = apiKey;
        [RootViewController.sharedInstance handleLogin];
      }
    }
    
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"There was an error logging in"
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
  }];
  
}

- (void)logout {
  NSError * error;
  [SSKeychain deletePasswordForService:THXWelcomeServiceName account:_email error:&error];
  if (!error) {
    [RootViewController.sharedInstance handleLogout];
  }
}

- (BOOL)isUserAuthenticated {
  return _email != nil && _apiKey != nil;
}

#pragma mark - Private instance methods

- (NSString *)emailFromKeyChain {
  NSArray * accounts = [SSKeychain accountsForService:THXWelcomeServiceName];
  if(accounts.count > 0) {
    return accounts.firstObject[@"acct"];
  }
  return nil;
}

- (NSString *)apiKeyForAccount:(NSString *)account {
  return [SSKeychain passwordForService:THXWelcomeServiceName account:account];
}

@end
