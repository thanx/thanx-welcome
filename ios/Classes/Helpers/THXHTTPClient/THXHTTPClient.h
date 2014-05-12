//
//  THXHTTPClient.h
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THXHTTPClient : NSObject

-(void)postToPath:(NSString*)path andParams:(NSDictionary *)params;

@end
