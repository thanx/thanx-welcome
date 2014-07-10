//
//  THXBeacon.m
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "THXBeaconManager.h"
#import "THXHTTPClient.h"

static NSString *THXBeaconsUUID = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"; // @todo: change UUID for beacons

@interface THXBeaconManager()

@property (nonatomic, strong) ESTBeaconRegion* region;
@property (nonatomic, strong) THXHTTPClient* client;

@end

@implementation THXBeaconManager

- (id)init {
  self = [super init];
  if (self) {
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;

    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:THXBeaconsUUID];
    self.region = [[ESTBeaconRegion alloc] initWithProximityUUID:uuid
                                                      identifier:@"ThanxOffice"];
    self.region.notifyOnEntry = YES;
    self.region.notifyOnExit = YES;

    [self.beaconManager startMonitoringForRegion:self.region];

    self.client = [[THXHTTPClient alloc] init];
  }
  return self;
}

-(void)beaconManager:(ESTBeaconManager *)beaconManager
      didEnterRegion:(ESTBeaconRegion *)region {
  [self.client postToPath:@"events" andParams:@{@"event": @"enter_region"}];
}

-(void)beaconManager:(ESTBeaconManager *)beaconManager
       didExitRegion:(ESTBeaconRegion *)region {
  [self.client postToPath:@"events" andParams:@{@"event": @"exit_region"}];
}

@end
