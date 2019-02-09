 //
//  SharedController.m
//  Us2Guntur
//
//  Created by ~Madhavi~ on 13/12/11.
//  Copyright 2011 kireetisoft. All rights reserved.
//

#import "SharedController.h"

static SharedController *sharedController;

@implementation SharedController
@synthesize data,delegate;

//http://192.168.1.23:8075/Categoryinfo.svc/GetAllCategories/0
#define kServerURL @"http://m.sbsrchits.com/ChitcareServices.svc/"

#pragma mark--- Initialization Methods ---

+(SharedController *)sharedController
{
	if (sharedController == nil)
	{
		sharedController = [[self alloc] init];
	}
	return sharedController;
}

- (id)init
{
	if ((self = [super init]))
	{
        
	}
	return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
	@synchronized(self)
	{
		if (sharedController == nil)
		{
			sharedController = [super allocWithZone:zone];
			return sharedController; // assignment and return on first allocation
		}
	}
	return nil; //on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

+ (AppDelegate*)appDelegate
{
	return (AppDelegate*)[UIApplication sharedApplication].delegate;
}
#pragma mark - Seasonal Specials

-(void)getSeasonalSpecialsdelegate:(id)aDelegate
{
    self.delegate = aDelegate;
    
    NSString *strURL = [NSString stringWithFormat:@"%@GetAllCategories",kServerURL];
    
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:strURL]];
     
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self sendRequest:request];
}

- (void)loginDetails:(NSString*)userName Password:(NSString*)password delegate:(id)aDelegate
{
    self.delegate = aDelegate;
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:userName,@"UserName",password,@"UserPwd", nil];
    NSLog(@"%@-------",dict);
    NSDictionary *dictLogin = [[NSDictionary alloc] initWithObjectsAndKeys:dict,@"LoginRequest", nil];
     NSLog(@"%@---@@@@@@@@@-------",dictLogin);
    SBJSON *jsonObject = [SBJSON new];
    
    NSString *jsonString = [jsonObject stringWithObject:dictLogin];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *strURL = [NSString stringWithFormat:@"%@Login",kServerURL];
    NSLog(@"strURL--------->%@",strURL);
    NSURL *url = [[NSURL alloc]initWithString:strURL];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self sendRequest:request];
}

-(void)BranchesSelection:(NSString*)userID delegate:(id)aDelegate
{
    self.delegate = aDelegate;
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:userID,@"UserID", nil];
    
    NSDictionary *dictLogin = [[NSDictionary alloc] initWithObjectsAndKeys:dict,@"BranchesFillRequest", nil];
    SBJSON *jsonObject = [SBJSON new];
    
    NSString *jsonString = [jsonObject stringWithObject:dictLogin];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *strURL = [NSString stringWithFormat:@"%@BranchesFill",kServerURL];
    NSURL *url = [[NSURL alloc]initWithString:strURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self sendRequest:request];

}

-(void)customerInformation:(NSString*)branchID delegate:(id)aDelegate
{
    self.delegate = aDelegate;
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:branchID,@"BranchId", nil];
    
    NSDictionary *dictLogin = [[NSDictionary alloc] initWithObjectsAndKeys:dict,@"CompanyInformationRequest", nil];
    SBJSON *jsonObject = [SBJSON new];
    
    NSString *jsonString = [jsonObject stringWithObject:dictLogin];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *strURL = [NSString stringWithFormat:@"%@CompanyInformation",kServerURL];
    NSURL *url = [[NSURL alloc]initWithString:strURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self sendRequest:request];
    
}
//{"CollectionDetailsRequest":{"BranchId":2,"ToDate":"20 mar 2014"}}
//http://iphone.balusserychits.com/ChitcareServices.svc/CollectionInformation

-(void)collectionDetails:(NSString*)branchID toDate:(NSString*)todate delegate:(id)aDelegate
{
    self.delegate = aDelegate;
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:branchID,@"BranchId",todate,@"ToDate", nil];
    
    NSDictionary *dictLogin = [[NSDictionary alloc] initWithObjectsAndKeys:dict,@"CollectionDetailsRequest", nil];
    SBJSON *jsonObject = [SBJSON new];
    
    NSString *jsonString = [jsonObject stringWithObject:dictLogin];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *strURL = [NSString stringWithFormat:@"%@CollectionInformation",kServerURL];
    NSURL *url = [[NSURL alloc]initWithString:strURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self sendRequest:request];
}

//{"OutstandingDetailsRequest":{"BranchId":2,"ASOnDate":"20 mar 2014"}}
//http://iphone.balusserychits.com/ChitcareServices.svc/OutstandingInformation
-(void)outstandingInformation:(NSString*)branchID asOnDate:(NSString*)asOnDate delegate:(id)aDelegate
{
    self.delegate = aDelegate;
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:branchID,@"BranchId",asOnDate,@"ASOnDate", nil];
    
    NSDictionary *dictLogin = [[NSDictionary alloc] initWithObjectsAndKeys:dict,@"OutstandingDetailsRequest", nil];
    SBJSON *jsonObject = [SBJSON new];
    
    NSString *jsonString = [jsonObject stringWithObject:dictLogin];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *strURL = [NSString stringWithFormat:@"%@OutstandingInformation",kServerURL];
    NSURL *url = [[NSURL alloc]initWithString:strURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self sendRequest:request];
}

//http://iphone.balusserychits.com/ChitcareServices.svc/BussAgntPerformanceInformation
//{"BusinessAgentPerformanceRequest":{"BranchId":2,"FromDate":"01 Mar 2014","ToDate":"31mar 2014"}}
-(void)BusinessAgentPerformance:(NSString*)branchID fromDate:(NSString*)fromDate toDate:(NSString*)toDate delegate:(id)aDelegate
{
    self.delegate = aDelegate;
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:branchID,@"BranchId",fromDate,@"FromDate",toDate,@"ToDate", nil];
    
    NSDictionary *dictLogin = [[NSDictionary alloc] initWithObjectsAndKeys:dict,@"BusinessAgentPerformanceRequest", nil];
    SBJSON *jsonObject = [SBJSON new];
    
    NSString *jsonString = [jsonObject stringWithObject:dictLogin];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *strURL = [NSString stringWithFormat:@"%@BussAgntPerformanceInformation",kServerURL];
    NSURL *url = [[NSURL alloc]initWithString:strURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self sendRequest:request];
}

//Url:- http://iphone.balusserychits.com/ChitcareServices.svc/CompanyInvestment

-(void)CompanyInvestmentRequest:(NSString*)branchID  delegate:(id)aDelegate
{
    self.delegate = aDelegate;
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:branchID,@"BranchId", nil];
    
    NSDictionary *dictLogin = [[NSDictionary alloc] initWithObjectsAndKeys:dict,@"CompanyInvestmentRequest", nil];
    SBJSON *jsonObject = [SBJSON new];
    
    NSString *jsonString = [jsonObject stringWithObject:dictLogin];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *strURL = [NSString stringWithFormat:@"%@CompanyInvestment",kServerURL];
    NSURL *url = [[NSURL alloc]initWithString:strURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self sendRequest:request];
}
//url:- http://dm.balusserychits.com/ChitcareServices.svc/BidPayableOutstanding
//input:- {"BidPayableOutstandigRequest":{"BranchId":2}}


-(void)BidPayableOutstanding:(NSString*)branchID  delegate:(id)aDelegate
{
    self.delegate = aDelegate;
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:branchID,@"BranchId", nil];
    
    NSDictionary *dictLogin = [[NSDictionary alloc] initWithObjectsAndKeys:dict,@"BidPayableOutstandigRequest", nil];
    SBJSON *jsonObject = [SBJSON new];
    
    NSString *jsonString = [jsonObject stringWithObject:dictLogin];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *strURL = [NSString stringWithFormat:@"%@BidPayableOutstanding",kServerURL];
    NSURL *url = [[NSURL alloc]initWithString:strURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [self sendRequest:request];
}


- (void)sendRequest:(NSMutableURLRequest *)urlRequest
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	reach = [Reachability reachabilityWithHostName:@"www.google.co.in"];
	
	if (reach != nil)
	{
		NetworkStatus internetStatus = [reach currentReachabilityStatus];
		
		if (( internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
		{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self showAlertWithTitle:@"NetWorkStatus" message:@"Internet Connection Required" delegate:nil];
            [delegate controllerDidFailLoadingWithError:nil];
            return;
		}
        [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    }
}

#pragma mark--- URL Connection Delegate Methods ---

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)aData
{
    [self.data appendData:aData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    SBJSON *jsonParser = [SBJSON new];
    
    NSString *jsonString = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    NSError *outError = nil;
    
    id result = [jsonParser objectWithString:jsonString error:&outError];
    if (outError == nil)
    {
        NSLog(@" result ----- :%@",result);
        [delegate controllerDidFinishLoadingWithResult:result];
    }
    else
    {
        NSLog(@" result :%@ -----  error :%@",result, outError);
        
        [delegate controllerDidFailLoadingWithError:outError];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [delegate controllerDidFailLoadingWithError:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    if( [[protectionSpace authenticationMethod] isEqualToString:NSURLAuthenticationMethodServerTrust] )
    {
        return YES;
    }
    return NO;
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return YES;
}

#pragma mark--- Alert Methods ---

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)aDelegate
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:aDelegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

//Creating Progreessview wth label
- (UIAlertView *)createProgressViewToParentView:(UIView *)view withTitle:(NSString *)title
{
	Alert_UserLocation = [[UIAlertView alloc] initWithTitle:@"" message:title delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
	[Alert_UserLocation show];
	
	UIActivityIndicatorView *loaderView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(130, 60, 25, 25)];
	loaderView.tag = 3333;
	loaderView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
	loaderView.backgroundColor = [UIColor clearColor];
	[Alert_UserLocation addSubview:loaderView];
	[loaderView startAnimating];
	return Alert_UserLocation;
}

- (void)hideProgressView:(UIAlertView *)inProgressView
{
	if(Alert_UserLocation != nil)
	{
		[Alert_UserLocation dismissWithClickedButtonIndex:0 animated:YES];
		Alert_UserLocation = nil;
	}
}

@end
