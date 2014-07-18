//
//  THXAuth.h
//  ThanxWelcome
//
//  Created by Marc Fernandez on 7/18/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THXAuth : NSObject

#pragma mark - Instance attributes

@property (strong, nonatomic) NSString * email;
@property (strong, nonatomic) NSString * apiKey;

#pragma mark - Class methods

+ (THXAuth *)sharedInstance;

#pragma mark - Instance methods

- (void)loginWithAccount:(NSString *)account andPassword:(NSString *)password;
- (void)logout;

- (BOOL)isUserAuthenticated;

@end
