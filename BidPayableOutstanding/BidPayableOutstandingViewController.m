//
//  BidPayableOutstandingViewController.m
//  chitcareerpdirectorsmodule
//
//  Created by kireeti on 15/04/14.
//  Copyright (c) 2014 Madhavi KireetiSoft technologies. All rights reserved.
//

#import "BidPayableOutstandingViewController.h"
#import "SharedController.h"
#import "Constants.h"
#import "LoginViewController.h"
@interface BidPayableOutstandingViewController ()
{
    NSMutableArray *arrBidPay;
    SharedController *sharedController;
}
@end

@implementation BidPayableOutstandingViewController
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
   // self.title = @"Bid Payable";
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 300, 50)];
    lblTitle.text = @"Bid Payable";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font = [UIFont boldSystemFontOfSize:15];
    self.navigationItem.titleView = lblTitle;
    lblComapnyName.text = KStringCompanyName;
    imgCompanyLogo.image = [UIImage imageNamed:kImageLogo];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    sharedController = [SharedController sharedController];
    arrBidPay = [[NSMutableArray alloc] init];
    UIBarButtonItem *barBtnLogout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(barBtnLogout_TouchUpInside)];
    
    [barBtnLogout setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];

    self.navigationItem.rightBarButtonItem = barBtnLogout;
    
    [[btnSelectBranch layer] setCornerRadius:5 ];
    [[btnSelectBranch layer] setMasksToBounds:YES];
    [[btnSelectBranch layer] setBorderWidth:0.1f];

    viewBIDPAY.hidden=YES;
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)btnSelectBranch_TouchUpInside:(id)sender;
{
    UITableView *tableView = (UITableView*)[self.view viewWithTag:111];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 178,300 , 270)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [[tableView layer] setCornerRadius:5 ];
    [[tableView layer] setMasksToBounds:YES];
    [[tableView layer] setBorderWidth:0.2f];
    tableView.tag = 111;
    [self.view addSubview:tableView];
}

-(void)barBtnLogout_TouchUpInside
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    tableView.hidden = YES;
    viewBIDPAY.hidden = NO;
    NSDictionary *dict = [arrBranchesList objectAtIndex:indexPath.row];
    [btnSelectBranch setTitle:[dict objectForKey:@"BranchName"] forState:UIControlStateNormal];
    
//    [sharedController CompanyInvestmentRequest:[dict objectForKey:@"BranchId"] delegate:self];
    [sharedController BidPayableOutstanding:[dict objectForKey:@"BranchId"] delegate:self];
    [sharedController createProgressViewToParentView:self.view withTitle:@"Loading.."];
}

-(void)controllerDidFinishLoadingWithResult:(id)result
{
    [arrBidPay removeAllObjects];
    [arrBidPay addObject:[result objectForKey:@"BidPayableOutstandingResult"]];
    
    
    if (arrBidPay.count > 0){
        NSDictionary *dict = [arrBidPay objectAtIndex:0];
        if([[[dict objectForKey:@"Total"] stringValue] isEqualToString:@"0"])
        {
            [sharedController showAlertWithTitle:@"" message:@"No details for this branch" delegate:nil];
            viewBIDPAY.hidden = YES;
        }
        else
        {
            viewBIDPAY.hidden = NO;
            [self loadViewWithData];
        }
        [self loadViewWithData];
    }else{
        [sharedController showAlertWithTitle:@"" message:@"No details for this branch" delegate:nil];
    }
    
  
    NSLog(@"%@",result);
}

-(void)loadViewWithData
{
    NSLog(@"%@",[arrBidPay objectAtIndex:0]);
    NSDictionary *dict = [arrBidPay objectAtIndex:0];
    NSLog(@"%@",dict);
    
    [sharedController hideProgressView:self.view];
    
    lblAbove90Value.text = [NSString stringWithFormat:@"%@ L", [[dict objectForKey:@"Above90"] stringValue]];
    lblBtn30_90Value.text = [NSString stringWithFormat:@"%@ L",[[dict objectForKey:@"Btn30_90"] stringValue]];
    lblBtn15_30Value.text = [NSString stringWithFormat:@"%@ L",[[dict objectForKey:@"Btn15_30"] stringValue]];
    lblLess15Value.text = [NSString stringWithFormat:@"%@ L",[[dict objectForKey:@"Less15"] stringValue]];
    lblTotalValue.text = [NSString stringWithFormat:@"%.2f L",[[dict objectForKey:@"Total"] floatValue]];
    
    float floatAbove90Percentage = ([[dict objectForKey:@"Above90"] floatValue]/[[dict objectForKey:@"Total"] floatValue]) *100;
    lblAbove90Percentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floatAbove90Percentage]]];

    float floatbtn30_90Percentage = ([[dict objectForKey:@"Btn30_90"] floatValue]/[[dict objectForKey:@"Total"] floatValue]) *100;

    lblBtn30_90Percentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floatbtn30_90Percentage]]];

    float floatbtn15_30Percentage = ([[dict objectForKey:@"Btn15_30"] floatValue]/[[dict objectForKey:@"Total"] floatValue]) *100;

    lblBtn15_30Percentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floatbtn15_30Percentage]]];
    
    float floatLess15Percentage = ([[dict objectForKey:@"Less15"] floatValue]/[[dict objectForKey:@"Total"] floatValue]) *100;
    
    lblLess15Percentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floatLess15Percentage]]];
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
