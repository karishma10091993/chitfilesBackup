//
//  CollectiosDetailsViewController.m
//  ChitCareDirectorsModule
//
//  Created by kireeti on 11/04/14.
//  Copyright (c) 2014 Madhavi KireetiSoft technologies. All rights reserved.
//

#import "CollectiosDetailsViewController.h"
#import "SharedController.h"
#import "LoginViewController.h"
#import "Constants.h"
@interface CollectiosDetailsViewController ()
{
    NSMutableArray *arrCollectionDetails;
    SharedController *sharedController;
    int indexValue;
}
@end

@implementation CollectiosDetailsViewController
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
    
    arrCollectionDetails = [[NSMutableArray alloc] init];
    sharedController= [SharedController sharedController];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(barBtnLogOut_TouchUpInside)];
    
    [btnLogout setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];

    self.navigationItem.rightBarButtonItem = btnLogout;


   // self.title = @"Collection Details";
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 300, 50)];
    lblTitle.text = @"Collection Details";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font = [UIFont boldSystemFontOfSize:15];
    self.navigationItem.titleView = lblTitle;
    lblCompanyName.text = KStringCompanyName;
    lblCompanyName.lineBreakMode = UILineBreakModeWordWrap;
    lblCompanyName.numberOfLines = 0;

    imgCompanyLogo.image = [UIImage imageNamed:kImageLogo];

    viewBranchDetails.hidden = YES;
    
    [[btnBranchSelection layer] setCornerRadius:5 ];
    [[btnBranchSelection layer] setMasksToBounds:YES];
    [[btnBranchSelection layer] setBorderWidth:0.1f];
    
    [[btnDateSelection layer] setCornerRadius:5 ];
    [[btnDateSelection layer] setMasksToBounds:YES];
    [[btnDateSelection layer] setBorderWidth:0.1f];
    
    UITableView *tableView  = [[UITableView alloc] initWithFrame:CGRectMake(7, 175,300 , 270)];
    tableView.delegate = self;
    [[tableView layer] setCornerRadius:5 ];
    [[tableView layer] setMasksToBounds:YES];
    [[tableView layer] setBorderWidth:0.2f];
    tableView.dataSource = self;
    tableView.tag = 111;
    [self.view addSubview:tableView];
    tableView.hidden = YES;
    // Do any additional setup after loading the view from its nib.
}

-(void)barBtnLogOut_TouchUpInside
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)getDate
{
    
}

-(IBAction)btnDateselection:(id)sender
{
    NSString *strBranchName = [btnBranchSelection titleForState:UIControlStateNormal];
    if([strBranchName isEqualToString:@"Select Branch"])
    {
        [sharedController showAlertWithTitle:@"" message:@"Please select Branch" delegate:nil];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:Nil otherButtonTitles:@"Today",@"Yesterday", nil];
        [actionSheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSDictionary *dict = [arrBranchesList objectAtIndex:indexValue];
    
    NSLog(@"Index: %li",(long)buttonIndex);
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [btnDateSelection setTitle:@"Today" forState:UIControlStateNormal];
    [dateFormat setDateFormat:@"dd MMM yyyy"];

    if(buttonIndex == 1)
    {
        [btnDateSelection setTitle:@"Yesterday" forState:UIControlStateNormal];
        NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
        [componentsToSubtract setDay:-1];
        
        date = [[NSCalendar currentCalendar] dateByAddingComponents:componentsToSubtract toDate:[NSDate date] options:0];
        NSLog(@"yester day..%@",date);
    }
    
    NSString *dateString = [dateFormat stringFromDate:date];
    NSLog(@"%@",dateString);
    
   [sharedController collectionDetails:[dict objectForKey:@"BranchId"] toDate:dateString delegate:self];
}

-(IBAction)btnBranchSelection_touchUpInside:(id)sender
{
    [btnDateSelection setTitle:@"Today" forState:UIControlStateNormal];
    UITableView *tablewView = (UITableView*)[self.view viewWithTag:111];
    tablewView.hidden = NO;
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
    
    NSDictionary *dict = [arrBranchesList objectAtIndex:indexPath.row];
    [btnBranchSelection setTitle:[dict objectForKey:@"BranchName"] forState:UIControlStateNormal];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd MMM yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    indexValue = indexPath.row;
    
    [sharedController collectionDetails:[dict objectForKey:@"BranchId"] toDate:dateString delegate:self];
}

-(void)controllerDidFinishLoadingWithResult:(id)result
{
    [arrCollectionDetails removeAllObjects];
    [arrCollectionDetails addObjectsFromArray:[result objectForKey:@"CollectionInformationResult"]];
    
    if([arrCollectionDetails count])
    {
        NSDictionary *dict = [arrCollectionDetails objectAtIndex:0];
        NSLog(@"%@",dict);
        if([[[dict objectForKey:@"Total"] stringValue] isEqualToString:@"0"])
        {
            [sharedController showAlertWithTitle:@"" message:@"No details for this branch" delegate:nil];
            
            viewBranchDetails.hidden = YES;
        }
        else
            [self loadViewWithData];
    }else{
        [sharedController showAlertWithTitle:@"" message:@"No details for this branch" delegate:nil];
    }
}

-(void)loadViewWithData
{
    viewBranchDetails.hidden = NO;

    NSDictionary *dict = [arrCollectionDetails objectAtIndex:0];
    NSLog(@"%@",dict);
    
    lblAdjValue.text = [[dict objectForKey:@"Adj"] stringValue];
    lblCashValue.text = [[dict objectForKey:@"cash"] stringValue];
    lblCheck_DDValue.text = [[dict objectForKey:@"ChequeDD"] stringValue];
    lblRTGSValue.text = [[dict objectForKey:@"RTGSNEFT"] stringValue];
    lblTotalValue.text = [[dict objectForKey:@"Total"] stringValue];
    
    float floatAdjPercentage = ([[dict objectForKey:@"Adj"] floatValue]/[[dict objectForKey:@"Total"] floatValue]) *100;
    lblAdjPercentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floatAdjPercentage]]];
    
    float floatCashPercentage = ([[dict objectForKey:@"cash"] floatValue]/[[dict objectForKey:@"Total"] floatValue]) *100;
    lblCashPercentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floatCashPercentage]]];
    
    float floatRTGSPercentage = ([[dict objectForKey:@"RTGSNEFT"] floatValue]/[[dict objectForKey:@"Total"] floatValue]) *100;
    lblRTGSVPercentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floatRTGSPercentage]]];
    
    float floatCheck_DDPercentage = ([[dict objectForKey:@"ChequeDD"] floatValue]/[[dict objectForKey:@"Total"] floatValue]) *100;
    lblCheck_DDPercentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floatCheck_DDPercentage]]];
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
