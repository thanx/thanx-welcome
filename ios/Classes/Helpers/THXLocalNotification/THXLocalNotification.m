//
//  THXLocalNotification.m
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/14/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "THXLocalNotification.h"

@implementation THXLocalNotification

+(void)notify:(NSString *)notificationText {
  UILocalNotification *notification = [[UILocalNotification alloc] init];
  notification.alertBody = notificationText;
  notification.soundName = UILocalNotificationDefaultSoundName;
  [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

@end
