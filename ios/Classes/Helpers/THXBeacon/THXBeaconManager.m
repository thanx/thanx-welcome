//
//  THXBeacon.m
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "THXBeaconManager.h"
#import "THXHTTPClient.h"
#import "THXAuth.h"

NSString * const THXBeaconsUUID = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"; // @todo: change UUID for beacons
NSString * const THXBeaconsRegionName = @"ThanxOffice";

@interface THXBeaconManager()

@property (nonatomic, strong) ESTBeaconRegion* region;

@end

@implementation THXBeaconManager

- (id)init {
  self = [super init];
  if (self) {
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;

    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:THXBeaconsUUID];
    self.region = [[ESTBeaconRegion alloc] initWithProximityUUID:uuid
                                                      identifier:THXBeaconsRegionName];
    self.region.notifyOnEntry = YES;
    self.region.notifyOnExit = YES;

    [self.beaconManager startMonitoringForRegion:self.region];
  }
  return self;
}

-(void)beaconManager:(ESTBeaconManager *)beaconManager
      didEnterRegion:(ESTBeaconRegion *)region {
  if (THXAuth.sharedInstance.isUserAuthenticated) {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"event": @"enter_region"}];
    parameters[@"email"] = THXAuth.sharedInstance.email;
    [THXHTTPClient.sharedInstance postToPath:@"events" parameters:parameters];
  }
}

-(void)beaconManager:(ESTBeaconManager *)beaconManager
       didExitRegion:(ESTBeaconRegion *)region {
  if (THXAuth.sharedInstance.isUserAuthenticated) {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"event": @"exit_region"}];
    parameters[@"email"] = THXAuth.sharedInstance.email;
    [THXHTTPClient.sharedInstance postToPath:@"events" parameters:parameters];
  }
}

@end
