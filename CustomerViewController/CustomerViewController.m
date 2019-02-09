//
//  CustomerViewController.m
//  ChitCareDirectorsModule
//
//  Created by kireeti on 11/04/14.
//  Copyright (c) 2014 Madhavi KireetiSoft technologies. All rights reserved.
//

#import "CustomerViewController.h"
#import "Constants.h"
#import "SharedController.h"
#import "LoginViewController.h"
@interface CustomerViewController ()
{
//    NSMutableArray *arrBranchesList;
    BOOL isFirst;
    SharedController *sharedController;
    BOOL isCustomerInf;
    NSMutableArray *arrCustomerInf;
}
@end

@implementation CustomerViewController
@synthesize dictLoginDetails,arrBranchList;
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
    sharedController = [SharedController sharedController];
    
    NSLog(@"%@",dictLoginDetails);
    NSLog(@"%@",arrBranchList);
    //[self setcolourofbutton:_Selectbrachbtn stringtitle:@"Select Branch"];
    isFirst = YES;
    lblCompanyName.text = KStringCompanyName;
    lblCompanyName.lineBreakMode = UILineBreakModeWordWrap;
    lblCompanyName.numberOfLines = 0;
    imgCompanyLogo.image = [UIImage imageNamed:kImageLogo];
//    [imgCompanyLogo setImage:[UIImage imageNamed:kImgCompanyLogo]];

    //self.title = @"Customer Information";
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 300, 50)];
    lblTitle.text = @"Customer Information";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.font = [UIFont boldSystemFontOfSize:15];
    self.navigationItem.titleView = lblTitle;
    arrCustomerInf = [[NSMutableArray alloc] init];
    
    [[btnBranchSelection layer] setCornerRadius:5 ];
    [[btnBranchSelection layer] setMasksToBounds:YES];
    [[btnBranchSelection layer] setBorderWidth:0.1f];
    
    viewBranchDetails.hidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(barBtnLogout_TouchUpInside)];
    [btnLogout setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];

    self.navigationItem.rightBarButtonItem = btnLogout;

    
    // Do any additional setup after loading the view from its nib.
}

-(void)barBtnLogout_TouchUpInside
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)btnBranchSelection_touchUpInside:(id)sender
{
    UITableView *tableView = (UITableView*)[self.view viewWithTag:111];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(16, 189,300 , 270)];
    [[tableView layer] setCornerRadius:5 ];
    [[tableView layer] setMasksToBounds:YES];
    [[tableView layer] setBorderWidth:0.2f];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = 111;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrBranchList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
//    cell.textLabel.text = [arrBranchesList objectAtIndex:indexPath.row];
    NSDictionary *dict = [arrBranchList objectAtIndex:indexPath.row];
    
    UILabel *lblBranchesNames = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 30)];
    lblBranchesNames.text =  [dict objectForKey:@"BranchName"];
    lblBranchesNames.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:lblBranchesNames];
    
//    cell.textLabel.text = [dict objectForKey:@"BranchName"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath  animated:YES];
    tableView.hidden = YES;

    NSDictionary *dict = [arrBranchList objectAtIndex:indexPath.row];
    [btnBranchSelection setTitle:[dict objectForKey:@"BranchName"] forState:UIControlStateNormal];
    
    [sharedController customerInformation:[dict objectForKey:@"BranchId"] delegate:self];
}

-(void)controllerDidFinishLoadingWithResult:(id)result
{
    [arrCustomerInf removeAllObjects];
    [arrCustomerInf addObjectsFromArray:[result objectForKey:@"CompanyInformationResult"]];
    
    if (arrCustomerInf.count > 0){
        
        NSDictionary *dict = [arrCustomerInf objectAtIndex:0];
        if([[[dict objectForKey:@"Total"] stringValue] isEqualToString:@"0"])
        {
            [sharedController showAlertWithTitle:@"" message:@"There are no Subscribers" delegate:self];
            viewBranchDetails.hidden = YES;
        }
        else
        {
            [self loadViewWithData];
            viewBranchDetails.hidden = NO;
        }
    }else{
        [sharedController showAlertWithTitle:@"" message:@"There are no Subscribers" delegate:self];
    }
}

-(void)loadViewWithData
{
    NSDictionary *dict = [arrCustomerInf objectAtIndex:0];
    NSLog(@"%@",dict);
    
    lblNPSValue.text = [[dict objectForKey:@"NPS"] stringValue];
    lblPSValue.text = [[dict objectForKey:@"PS"] stringValue];
    lblSFValue.text = [[dict objectForKey:@"SF"] stringValue];
    lblTotalValue.text = [[dict objectForKey:@"Total"] stringValue];
    
    float floatNPSPercentage = ([[dict objectForKey:@"NPS"] floatValue]/[[dict objectForKey:@"Total"] floatValue]) *100;
    lblNPSPercentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floatNPSPercentage]]];
    
    NSLog(@"%f",floatNPSPercentage);
    NSLog(@"%f",[[dict objectForKey:@"Total"] floatValue]);
    
    float floatPSPercentage = ([[dict objectForKey:@"PS"] floatValue]/[[dict objectForKey:@"Total"] floatValue]) *100;
    
    lblPSPercentage.text = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"% .0f",floatPSPercentage]]];
    
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
