//
//  BussinessPerformanceViewController.m
//  ChitCareDirectorsModule
//
//  Created by kireeti on 11/04/14.
//  Copyright (c) 2014 Madhavi KireetiSoft technologies. All rights reserved.
//

#import "BussinessPerformanceViewController.h"
#import "SharedController.h"
#import "LoginViewController.h"
#import "Constants.h"
@interface BussinessPerformanceViewController ()
{
    SharedController *sharedController;
    BOOL isBranches;
    NSMutableArray *arrAgentsList;
}
@end

@implementation BussinessPerformanceViewController
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
    
    lblCompanyName.text = KStringCompanyName;
    imgCompanyLogo.image = [UIImage imageNamed:kImageLogo];
    

    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 300, 50)];
    lblTitle.text = @"Agents Performance";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font = [UIFont boldSystemFontOfSize:15];
    self.navigationItem.titleView = lblTitle;
    lblCompanyName.text = KStringCompanyName;
    lblCompanyName.lineBreakMode = UILineBreakModeWordWrap;
    lblCompanyName.numberOfLines = 0;
    arrAgentsList = [[NSMutableArray alloc] init];
    UIBarButtonItem *barBtnHome = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(barBtnHome_TouchUpInside)];
    barBtnHome.image = [UIImage imageNamed:@"home.jpg"];
//    self.navigationItem.leftBarButtonItem = barBtnHome;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[btnSelectBranch layer] setCornerRadius:5 ];
    [[btnSelectBranch layer] setMasksToBounds:YES];
    [[btnSelectBranch layer] setBorderWidth:0.1f];
    
    sharedController = [SharedController sharedController];
    viewBussinessData.hidden = YES;
    // Do any additional setup after loading the view from its nib.
}

-(void)barBtnHome_TouchUpInside
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!isBranches)
        return 60;
    else
        return 50;
}
-(IBAction)btnSelectBranch_touchUpInside:(id)sender;
{
    UITableView *tableViewBranches = [[UITableView alloc] initWithFrame:CGRectMake(12, 170, 299, 250)];
    tableViewBranches.delegate = self;
    tableViewBranches.dataSource = self;
    [[tableViewBranches layer] setCornerRadius:5 ];
    [[tableViewBranches layer] setMasksToBounds:YES];
    [[tableViewBranches layer] setBorderWidth:0.2f];
    tableViewBranches.tag = 111;
    isBranches = YES;
    [self.view addSubview:tableViewBranches];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isBranches == YES)
        return [arrBranchesList count];
    else
        return [arrAgentsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView1 dequeueReusableCellWithIdentifier:nil];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    if(isBranches == YES)
    {
        NSDictionary *dict = [arrBranchesList objectAtIndex:indexPath.row];
        
        UILabel *lblBranchesNames = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 30)];
        lblBranchesNames.text =  [dict objectForKey:@"BranchName"];
        lblBranchesNames.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:lblBranchesNames];
    }
    else
    {
        NSLog(@"arrAgentsList in table cell %@",arrAgentsList);
        
        NSDictionary *dict = [arrAgentsList objectAtIndex:indexPath.row];
        
        UILabel *lblAgentName = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 140, 50)];
        lblAgentName.numberOfLines = 2;
        lblAgentName.backgroundColor = [UIColor clearColor];
        lblAgentName.font = [UIFont systemFontOfSize:15];
        lblAgentName.text = [dict objectForKey:@"AgntName"];
        [cell.contentView addSubview:lblAgentName];
        
        UILabel *lblAgentAmount = [[UILabel alloc] initWithFrame:CGRectMake(165, 5, 150, 50)];
        lblAgentAmount.numberOfLines =2;
        lblAgentAmount.textAlignment = NSTextAlignmentCenter;
        lblAgentAmount.backgroundColor = [UIColor clearColor];
        
        lblAgentAmount.font = [UIFont systemFontOfSize:15];
        lblAgentAmount.text = [[dict objectForKey:@"BusinessAmt"] stringValue];
        [cell.contentView addSubview:lblAgentAmount];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableView *tableViewBranches = (UITableView*)[self.view viewWithTag:111];
    tableViewBranches.hidden = YES;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(isBranches == YES)
    {
        UITableView *tableViewBranches = (UITableView*)[self.view viewWithTag:111];
        tableViewBranches.hidden = YES;
        
        NSDictionary *dict = [arrBranchesList objectAtIndex:indexPath.row];
        [btnSelectBranch setTitle:[dict objectForKey:@"BranchName"] forState:UIControlStateNormal];
        
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"ddMMM yyyy"];
        NSString *dateString = [dateFormat stringFromDate:date];
        
        NSString *string =  [dateString substringWithRange:NSMakeRange(2, 3)];
        
        [sharedController BusinessAgentPerformance:[dict objectForKey:@"BranchId"] fromDate:[NSString stringWithFormat:@"01 %@ 2014",string] toDate:dateString delegate:self];
    }
    else
    {
        UITableView *tableViewBranches = (UITableView*)[self.view viewWithTag:111];
        tableViewBranches.hidden = YES;
        isBranches = NO;
    }
}

-(void)controllerDidFinishLoadingWithResult:(id)result
{
    UITableView *tableViewBranches = (UITableView*)[self.view viewWithTag:111];
    tableViewBranches.hidden = YES;
    
    if([result objectForKey:@"BussAgntPerformanceInformationResult"] == (id) [NSNull null])
    {
        UITableView *tableViewBranches = (UITableView*)[self.view viewWithTag:111];
        tableViewBranches.hidden = YES;
        
        [sharedController showAlertWithTitle:@"" message:@"There is no bussiness for this month" delegate:nil];
    }
    else
    {
        viewBussinessData.hidden = NO;
        
        [arrAgentsList removeAllObjects];
        [arrAgentsList addObjectsFromArray:[result objectForKey:@"BussAgntPerformanceInformationResult"]];
        isBranches = NO;
        UITableView *tableViewAgents = [[UITableView alloc] initWithFrame:CGRectMake(1, 31, 320, 354)];
        tableViewAgents.delegate = self;
        tableViewAgents.dataSource = self;
        tableViewAgents.tag = 111;
        [viewBussinessData addSubview:tableViewAgents];
        [tableView reloadData];
    }
    
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
