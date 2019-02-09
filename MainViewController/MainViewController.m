//
//  MainViewController.m
//  ChitCareDirectorsModule
//
//  Created by kireeti on 11/04/14.
//  Copyright (c) 2014 Madhavi KireetiSoft technologies. All rights reserved.
//

#import "MainViewController.h"
#import "CustomerViewController.h"
#import "CollectiosDetailsViewController.h"
#import "OutStandingViewController.h"
#import "LoginViewController.h"
#import "BussinessPerformanceViewController.h"
#import "SharedController.h"
#import "BidPayableOutstandingViewController.h"
#import "CompanyInvestmentViewController.h"
#import "Constants.h"
@interface MainViewController ()
{
    NSArray *arrColumnNames;
    NSArray *arrColumnImages;
    SharedController *sharedController;
}
@end

@implementation MainViewController
@synthesize dictLoginDetails,arrBranchesList;

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
    
    NSLog(@"%@",dictLoginDetails);
    
    self.navigationItem.hidesBackButton = YES;
    arrBranchesList= [[NSMutableArray alloc] init];
    self.title = KStringCompanyName;
   
    UIBarButtonItem *barBtnLogOut = [[UIBarButtonItem alloc] initWithTitle:@"LogOut" style:UIBarButtonItemStylePlain target:self action:@selector(btnLogOut_TouchUpInside)];
    self.navigationItem.rightBarButtonItem = barBtnLogOut;
    
    arrColumnNames = [[NSArray alloc] initWithObjects:@"Customer Information",@"Collection Details",@"Outstanding Details",@"Agents Performance",@"Company Investment",@"Bid Payable", nil];
    
//    arrColumnImages = [[NSArray alloc] initWithObjects:@"personal-information.png",@"stock_view.png",
//                       @"out.png",@"agents.png",@"Invest.png", @"Invest.png",nil];
    
    arrColumnImages = [[NSArray alloc] initWithObjects:@"personal-information.png",@"collectionDetails.png",
                       @"outstanding.png",@"agents.png",@"CompanyInvestment.png", @"Invest.png",nil];
    
    sharedController = [SharedController sharedController];
    [sharedController BranchesSelection:[dictLoginDetails objectForKey:@"UserID"] delegate:self];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)btnLogOut_TouchUpInside
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrColumnNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView1 dequeueReusableCellWithIdentifier:nil];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.imageView.image =  [UIImage imageNamed:[arrColumnImages objectAtIndex:indexPath.row]];

    cell.textLabel.text = [arrColumnNames objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView1 deselectRowAtIndexPath:indexPath  animated:YES];

    if(indexPath.row == 0)
    {
        CustomerViewController *customerVC = [[CustomerViewController alloc] init];
        customerVC.dictLoginDetails = dictLoginDetails;
        customerVC.arrBranchList = arrBranchesList;
        [self.navigationController pushViewController:customerVC animated:YES];
    }
    else if(indexPath.row ==1)
    {
        CollectiosDetailsViewController *collectionVC = [[CollectiosDetailsViewController alloc] init];
        collectionVC.dictLoginDetails = dictLoginDetails;
        collectionVC.arrBranchesList = arrBranchesList;
        [self.navigationController pushViewController:collectionVC  animated:YES];
    }
    else if(indexPath.row == 2)
    {
        OutStandingViewController *outstandingVC = [[OutStandingViewController alloc] init];
        outstandingVC.dictLoginDetails = dictLoginDetails;
        outstandingVC.arrBranchesList = arrBranchesList;
        [self.navigationController pushViewController:outstandingVC animated:YES];
    }
    else if(indexPath.row ==3)
    {
        BussinessPerformanceViewController *bussinessVC = [[BussinessPerformanceViewController alloc] init];
        bussinessVC.dictLoginDetails = dictLoginDetails;
        bussinessVC.arrBranchesList = arrBranchesList;
        [self.navigationController pushViewController:bussinessVC animated:YES];
    }
    else if(indexPath.row == 4)
    {
        CompanyInvestmentViewController *companyInvest = [[CompanyInvestmentViewController alloc] init];
        companyInvest.dictLoginDetails = dictLoginDetails;
        companyInvest.arrBranchesList = arrBranchesList;
        [self.navigationController pushViewController:companyInvest animated:YES];
    }
    else
    {
        BidPayableOutstandingViewController *bid = [[BidPayableOutstandingViewController alloc] init];
        bid.arrBranchesList = arrBranchesList;
         bid.dictLoginDetails = dictLoginDetails;
        [self.navigationController pushViewController:bid animated:YES];
    }
}

-(void)controllerDidFinishLoadingWithResult:(id)result
{
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"All Branches",@"BranchName",@"0",@"BranchId",[dictLoginDetails objectForKey:@"UserID"],@"UserID", nil];
    [arrBranchesList removeAllObjects];
    [arrBranchesList addObjectsFromArray:[result objectForKey:@"BranchesFillResult"]];
        
    [arrBranchesList insertObject:dict atIndex:0];
    NSLog(@"%@",result);
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
