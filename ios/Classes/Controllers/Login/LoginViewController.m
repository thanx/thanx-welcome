//
//  LoginViewController.m
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "MainViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *emailTextFieldContainer;
- (IBAction)onSubmitButtonClick:(id)sender;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.emailTextFieldContainer.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:0.25];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  self.emailTextField.delegate = self;
}

#pragma mark IBAction Methods
- (IBAction)onSubmitButtonClick:(id)sender {
  
  // MAKE API CALL TO ADD EMAIL
  
  // ON SUCCESS UPDATE NSUserDefaults
  [NSUserDefaults.standardUserDefaults setValue:_emailTextField.text forKey:@"email"];
  [NSUserDefaults.standardUserDefaults synchronize];
  MainViewController *mainViewController = [[MainViewController alloc] init];
  [self presentViewController:mainViewController animated:YES completion:^{}];
  
  // ON FAILURE DISPLAY ALERT
}

#pragma mark UITextViewDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self.view endEditing:YES];
}

@end
