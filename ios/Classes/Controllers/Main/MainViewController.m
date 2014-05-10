//
//  MainViewController.m
//  ThanxWelcome
//
//  Created by THOMAS CHEN on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "MainViewController.h"

NSString * const UserDidRemoveEmail = @"UserDidRemoveEmail";

@interface MainViewController ()
- (IBAction)onRemoveEmailClick:(id)sender;
- (IBAction)onUpdateEmailClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIView *emailFieldContainer;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *email = [defaults valueForKey:@"email"];
  
  self.emailField.delegate = self;
  self.emailField.text = email;
  
  self.emailFieldContainer.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:0.25];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark IBAction Methods
- (IBAction)onRemoveEmailClick:(id)sender {
  NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
  [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:UserDidRemoveEmail object:nil];
  
  // API CALL TO REMOVE REMOVE
}

- (IBAction)onUpdateEmailClick:(id)sender {
  // DISPLAY SPINNER
  // CALL TO SEND TO API
  // ON SUCCESS SET NSUSERDEFAULTS
  [NSUserDefaults.standardUserDefaults setValue:self.emailField.text forKey:@"email"];
  [NSUserDefaults.standardUserDefaults synchronize];
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
