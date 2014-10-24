//
//  MainViewController.m
//  ThanxWelcome
//
//  Created by THOMAS CHEN on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "MainViewController.h"

NSString * const UserDidRemoveEmail = @"UserDidRemoveEmail";

@interface MainViewController () <CLLocationManagerDelegate>
- (IBAction)onRemoveEmailClick:(id)sender;
- (IBAction)onUpdateEmailClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIView *emailFieldContainer;
@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation MainViewController

- (id)init {
    self = [super init];
    if (self) {
      self.manager = [[CLLocationManager alloc] init];
      self.manager.delegate = self;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
  if([self.manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
    [self.manager requestAlwaysAuthorization];
  }
  [self.manager startUpdatingLocation];
}


#pragma mark - IBAction Methods

- (IBAction)onRemoveEmailClick:(id)sender {
  NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
  [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:UserDidRemoveEmail object:nil];
}

- (IBAction)onUpdateEmailClick:(id)sender {
  [NSUserDefaults.standardUserDefaults setValue:self.emailField.text forKey:@"email"];
  [NSUserDefaults.standardUserDefaults synchronize];
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
