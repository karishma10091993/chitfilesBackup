//
//  LoginViewController.m
//  ChitCareDirectorsModule
//
//  Created by kireeti on 11/04/14.
//  Copyright (c) 2014 Madhavi KireetiSoft technologies. All rights reserved.
//
#import "SharedController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "Constants.h"
@interface LoginViewController ()
{
    SharedController *sharedController;
    NSMutableDictionary *dictLoginResult;
}
@end

@implementation LoginViewController

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
    
//    self.title = @"CHITCARE ERP Director's Module";
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 300, 50)];
    lblTitle.text = @"CHITCARE ERP Director's Module";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor blackColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font = [UIFont boldSystemFontOfSize:15];
    self.navigationItem.titleView = lblTitle;

    sharedController = [SharedController sharedController];
    lblCompanyName.text = KStringCompanyName;
    imgCompanyLogo.image = [UIImage imageNamed:kImageLogo];
    
    dictLoginResult = [[NSMutableDictionary alloc] init];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    txtFldPwd.text = @"siva";
    txtFldUserName.text = @"siva";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [scrollView setContentOffset:CGPointMake(0,-60) animated:YES];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag == 111)
    {
        [scrollView setContentOffset:CGPointMake(0,50) animated:YES];
    }
    else
    {
        [scrollView setContentOffset:CGPointMake(0,60) animated:YES];
    }
}

-(IBAction)submit_TouchUpInside:(UIButton*)sender
{
    if(txtFldPwd.text.length == 0 || txtFldUserName.text.length == 0)
    {
        [sharedController showAlertWithTitle:@"" message:@"Please enter user name and password" delegate:nil];
    }
    else
    {
        [sharedController loginDetails:txtFldUserName.text Password:txtFldPwd.text delegate:self];
    }
}

-(void)controllerDidFinishLoadingWithResult:(id)result
{
    NSLog(@"result  is %@",result);
    
    [dictLoginResult removeAllObjects];
    dictLoginResult = [result objectForKey:@"LoginResult"];
    NSLog(@"%@",dictLoginResult);
    
    if([[[dictLoginResult objectForKey:@"RoleID"] stringValue] isEqualToString:@"4"] && [[[dictLoginResult objectForKey:@"DirectorType"] stringValue] isEqualToString:@"1"])
//    if([[dictLoginResult objectForKey:@"RoleID"] isEqualToString:@"4"])
    {
        MainViewController *mainVc = [[MainViewController alloc] init];
        mainVc.dictLoginDetails = dictLoginResult;
        [self.navigationController pushViewController:mainVc animated:YES];
    }
    else
    {
        [sharedController showAlertWithTitle:@"" message:@"Please enter Director Credentials" delegate:self];
    }
}

- (void)controllerDidFailLoadingWithError:(NSError*)error
{
    NSLog(@"%@",error);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
