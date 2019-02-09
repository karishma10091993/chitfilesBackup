//
//  OutStandingViewController.m
//  ChitCareDirectorsModule
//
//  Created by kireeti on 11/04/14.
//  Copyright (c) 2014 Madhavi KireetiSoft technologies. All rights reserved.
//

#import "OutStandingViewController.h"
#import "SharedController.h"
#import "LoginViewController.h"
#import "Constants.h"

@interface OutStandingViewController ()
{
    SharedController *sharedController;
    NSMutableArray *arrOutStandingDetails;
}
@end

@implementation OutStandingViewController
@synthesize arrBranchesList,dictLoginDetails;

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
    
    //self.title = @"Outstanding Details";
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 300, 50)];
    lblTitle.text =  @"Outstanding Details";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font = [UIFont boldSystemFontOfSize:15];
    self.navigationItem.titleView = lblTitle;
    lblCompanyName.text = KStringCompanyName;
    lblCompanyName.lineBreakMode = UILineBreakModeWordWrap;
    lblCompanyName.numberOfLines = 0;

    imgCompanyLogo.image = [UIImage imageNamed:kImageLogo];
    
    sharedController = [SharedController sharedController];
    arrOutStandingDetails= [[NSMutableArray alloc] init];
//    UIBarButtonItem *barBtnHome = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(barBtnHome_TouchUpInside)];
//    barBtnHome.image = [UIImage imageNamed:@"home.jpg"];
//    self.navigationItem.leftBarButtonItem = barBtnHome;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(barBtnLogOut_TouchUpInside)];
    [btnLogout setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];

    self.navigationItem.rightBarButtonItem = btnLogout;
    viewBranchDetails.hidden = YES;
    
    [[btnBranchSelection layer] setCornerRadius:5 ];
    [[btnBranchSelection layer] setMasksToBounds:YES];
    [[btnBranchSelection layer] setBorderWidth:0.1f];
    
    UITableView *tableView  = [[UITableView alloc] initWithFrame:CGRectMake(20, 173,280 , 270)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag= 111;
    [[tableView layer] setCornerRadius:5 ];
    [[tableView layer] setMasksToBounds:YES];
    [[tableView layer] setBorderWidth:0.2f];
    [self.view addSubview:tableView];
    tableView.hidden = YES;

    // Do any additional setup after loading the view from its nib.
}

-(void)barBtnLogOut_TouchUpInside
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)btnBranchSelection_touchUpInside:(id)sender;
{
    UITableView *tableView = (UITableView*)[self.view viewWithTag:111];
    tableView.hidden = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrBranchesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    NSDictionary *dict = [arrBranchesList objectAtIndex:indexPath.row];
    
    UILabel *lblBranchesNames = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 30)];
    lblBranchesNames.text =  [dict objectForKey:@"BranchName"];
    lblBranchesNames.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:lblBranchesNames];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath  animated:YES];

    tableView.hidden = YES;
    
//    viewBranchDetails.hidden = NO;
    
    NSDictionary *dict = [arrBranchesList objectAtIndex:indexPath.row];
    [btnBranchSelection setTitle:[dict objectForKey:@"BranchName"] forState:UIControlStateNormal];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd MMM yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];
        
    [sharedController outstandingInformation:[dict objectForKey:@"BranchId"] asOnDate:dateString delegate:self];
    
    [sharedController createProgressViewToParentView:self.view withTitle:@"Loading.."];
}

-(void)controllerDidFinishLoadingWithResult:(id)result
{
    [sharedController hideProgressView:self.view];
    if([result objectForKey:@"OutstandingInformationResult"] == (id) [NSNull null])
    {
        
        [sharedController showAlertWithTitle:@"" message:@"No details for this branch" delegate:nil];
    }
   else
   {
        [arrOutStandingDetails removeAllObjects];
        [arrOutStandingDetails addObjectsFromArray:[result objectForKey:@"OutstandingInformationResult"]];
        
        if([arrOutStandingDetails count])
        {
            NSDictionary *dict = [arrOutStandingDetails objectAtIndex:0];
            NSLog(@"%@",dict);
            if([[[dict objectForKey:@"Total"] stringValue] isEqualToString:@"0"])
            {
                [sharedController showAlertWithTitle:@"" message:@"No details for this branch" delegate:nil];
                viewBranchDetails.hidden = YES;
            }
        
            else
            {
               [self loadViewWithData];
            }
        }else{
             [sharedController showAlertWithTitle:@"" message:@"No details for this branch" delegate:nil];
        }
    }
    
}

-(void)loadViewWithData
{
    viewBranchDetails.hidden = NO;
    
    NSDictionary *dict = [arrOutStandingDetails objectAtIndex:0];
    NSLog(@"%@",dict);
    
    lblNPSValue.text = [NSString stringWithFormat:@"%@ L", [[dict objectForKey:@"NPS"] stringValue]];
    lblPSValue.text = [NSString stringWithFormat:@"%@ L", [[dict objectForKey:@"PS"] stringValue]];
    lblSFValue.text = [NSString stringWithFormat:@"%@ L", [[dict objectForKey:@"SF"] stringValue]];
    lblTotalValue.text = [NSString stringWithFormat:@"%.2f L", [[dict objectForKey:@"Total"] floatValue]];
    
    float floaNPSPercentage = ([[dict objectForKey:@"NPS"] floatValue]/[[dict objectForKey:@"Total"] floatValue]) *100;
    lblNPSPercentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floaNPSPercentage]]];
    
    float floatPSPercentage = ([[dict objectForKey:@"PS"] floatValue]/[[dict objectForKey:@"Total"] floatValue]) *100;
    lblPSPercentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floatPSPercentage]]];
    
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:13]; // Set this if you need 2 digits
    NSString * newString = [formatter stringFromNumber:[NSNumber numberWithFloat:floatPSPercentage]];
    
    NSLog(@"%@",newString);

    float floatSFPercentage = ([[dict objectForKey:@"SF"] floatValue]/[[dict objectForKey:@"Total"] floatValue]) *100;
    lblSFPercentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floatSFPercentage]]];
}

- (void)controllerDidFailLoadingWithError:(NSError*)error
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
