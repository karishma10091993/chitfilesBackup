//
//  CompanyInvestmentViewController.m
//  ChitCareDirectorsModule
//
//  Created by kireeti on 14/04/14.
//  Copyright (c) 2014 Madhavi KireetiSoft technologies. All rights reserved.
//

#import "CompanyInvestmentViewController.h"
#import "Constants.h"
#import "SharedController.h"
#import "LoginViewController.h"
@interface CompanyInvestmentViewController ()
{
    SharedController *sharedController;
    NSMutableArray *arrCompanyInvestment;
}
@end

@implementation CompanyInvestmentViewController
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
    
   // self.title = @"Comapny Investment";
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 300, 50)];
    lblTitle.text = @"Company Investment";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font = [UIFont boldSystemFontOfSize:15];
    self.navigationItem.titleView = lblTitle;
    imgCompanyLogo.image = [UIImage imageNamed:kImageLogo];
    lblCompanyName.text = KStringCompanyName;
    lblCompanyName.lineBreakMode = UILineBreakModeWordWrap;
    lblCompanyName.numberOfLines = 0;
    sharedController = [SharedController sharedController];
    arrCompanyInvestment = [[NSMutableArray alloc] init];
    viewCompanyInvestmentTable.hidden = YES;
   
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(barBtnLogOut_TouchUpInside)];
    
    [btnLogout setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];

    self.navigationItem.rightBarButtonItem = btnLogout;

    
    [[btnSelectBranch layer] setCornerRadius:5 ];
    [[btnSelectBranch layer] setMasksToBounds:YES];
    [[btnSelectBranch layer] setBorderWidth:0.1f];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)barBtnLogOut_TouchUpInside
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)btnSelectBranch_TouchUpInside:(id)sender
{
    UITableView *tableView = (UITableView*)[self.view viewWithTag:111];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(13, 193,300 , 270)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = 111;
    [[tableView layer] setCornerRadius:5 ];
    [[tableView layer] setMasksToBounds:YES];
    [[tableView layer] setBorderWidth:0.2f];
    [self.view addSubview:tableView];
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
    //    cell.textLabel.text = [arrBranchesList objectAtIndex:indexPath.row];
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
    NSDictionary *dict = [arrBranchesList objectAtIndex:indexPath.row];
    [btnSelectBranch setTitle:[dict objectForKey:@"BranchName"] forState:UIControlStateNormal];
    
    [sharedController CompanyInvestmentRequest:[dict objectForKey:@"BranchId"] delegate:self];
}

-(void)controllerDidFinishLoadingWithResult:(id)result
{
    [arrCompanyInvestment removeAllObjects];
    [arrCompanyInvestment addObject:[result objectForKey:@"CompanyInvestmentResult"]];
    
    NSDictionary *dict = [arrCompanyInvestment objectAtIndex:0];
    
    float floatTotal = [[dict objectForKey:@"Dividend"] floatValue]+ [[dict objectForKey:@"Investment"] floatValue]+ [[dict objectForKey:@"VacantCount"] floatValue];

    if(floatTotal == 0)
    {
        [sharedController showAlertWithTitle:@"" message:@"There are no details" delegate:nil];
        viewCompanyInvestmentTable.hidden = YES;
    }
    else
    {
        viewCompanyInvestmentTable.hidden = NO;
        [self loadViewWithData];
    }
    NSLog(@"%@",result);
}

-(void)loadViewWithData
{
    NSLog(@"%@",[arrCompanyInvestment objectAtIndex:0]);
    NSDictionary *dict = [arrCompanyInvestment objectAtIndex:0];
    NSLog(@"%@",dict);
    
    lblDividendValue.text = [[dict objectForKey:@"Dividend"] stringValue];
    lblInvestmentValue.text = [[dict objectForKey:@"Investment"] stringValue];
    lblVacantCountValue.text = [[dict objectForKey:@"VacantCount"] stringValue];
    
    float floatTotal = [[dict objectForKey:@"Dividend"] floatValue]+ [[dict objectForKey:@"Investment"] floatValue]+ [[dict objectForKey:@"VacantCount"] floatValue];
        
    float floatDividendPercentage = ([[dict objectForKey:@"Dividend"] floatValue]/floatTotal) *100;
    lblDividendPercentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floatDividendPercentage]]];
    
    float floatInvestmentPercentage = ([[dict objectForKey:@"Investment"] floatValue]/floatTotal) *100;
    
    lblInvestmentPercentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floatInvestmentPercentage]]];
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
