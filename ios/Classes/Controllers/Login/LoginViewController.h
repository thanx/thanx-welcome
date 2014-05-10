//
//  LoginViewController.h
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UIButton* submitButton;
@property (nonatomic, weak) IBOutlet UITextField * emailTextField;
@end
