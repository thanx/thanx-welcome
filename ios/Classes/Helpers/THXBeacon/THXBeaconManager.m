//
//  THXBeacon.m
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "THXBeaconManager.h"
#import "AFHTTPRequestOperationManager.h"

static NSString *THXBeaconsUUID = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"; // @todo: change UUID for beacons

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
                                                      identifier:@"ThanxOffice"];
    self.region.notifyOnEntry = YES;
    self.region.notifyOnExit = YES;

    [self.beaconManager startMonitoringForRegion:self.region];
  }
  return self;
}

-(void)beaconManager:(ESTBeaconManager *)beaconManager
      didEnterRegion:(ESTBeaconRegion *)region {

  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  NSString *email = [NSUserDefaults.standardUserDefaults valueForKey:@"email"];
  NSDictionary *parameters = @{@"email": email, @"event": @"enter_region"};
  [manager POST:@"http://welcome.thanx.com/api/v1.0/events"
     parameters:parameters
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          NSLog(@"JSON: %@", responseObject);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"Error: %@", error);
        }
   ];
}

-(void)beaconManager:(ESTBeaconManager *)beaconManager
       didExitRegion:(ESTBeaconRegion *)region {

  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  NSString *email = [NSUserDefaults.standardUserDefaults valueForKey:@"email"];
  NSDictionary *parameters = @{@"email": email, @"event": @"enter_region"};
  [manager POST:@"http://welcome.thanx.com/api/v1.0/events"
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
