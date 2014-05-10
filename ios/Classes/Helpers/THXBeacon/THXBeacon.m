//
//  THXBeacon.m
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "THXBeacon.h"

static NSInteger THXDetectionHourInterval = 1;

@implementation THXBeacon

-(id)initWithESTBeacon:(ESTBeacon *)beacon {
  self = [super init];
  if (self) {

  }
  return self;
}

-(BOOL)hasBeenDetectedSoon {
  return (_lastTimeDetected.timeIntervalSinceNow / 3600) > THXDetectionHourInterval;
}

@end
