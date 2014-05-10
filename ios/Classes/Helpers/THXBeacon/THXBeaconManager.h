//
//  THXBeacon.h
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESTBeaconManager.h"

@interface THXBeaconManager : NSObject <ESTBeaconManagerDelegate>

@property (nonatomic, strong) ESTBeaconManager *beaconManager;

@end
