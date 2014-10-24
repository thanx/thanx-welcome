//
//  LoginViewController.m
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "MainViewController.h"

@interface LoginViewController ()
- (IBAction)onSubmitButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIView *emailTextFieldContainer;
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
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  self.emailField.delegate = self;
}

#pragma mark IBAction Methods
- (IBAction)onSubmitButtonClick:(id)sender {

  [NSUserDefaults.standardUserDefaults setValue:self.emailField.text forKey:@"email"];
  [NSUserDefaults.standardUserDefaults synchronize];
  MainViewController *mainViewController = [[MainViewController alloc] init];
  [self presentViewController:mainViewController animated:YES completion:^{}];
  
}

#pragma mark - UITextViewDelegate Methods

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
