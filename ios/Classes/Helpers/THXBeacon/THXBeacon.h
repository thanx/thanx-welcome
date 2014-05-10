//
//  THXBeacon.h
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESTBeacon.h"

@interface THXBeacon : ESTBeacon

@property (strong, nonatomic) NSDate *lastTimeDetected;

-(id)initWithESTBeacon:(ESTBeacon *)beacon;

-(BOOL)hasBeenDetectedSoon;

@end
