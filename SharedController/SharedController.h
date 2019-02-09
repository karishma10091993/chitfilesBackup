//
//  SharedController.h
//  Us2Guntur
//
//  Created by ~Madhavi~ on 13/12/11.
//  Copyright 2011 kireetisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJSON.h"
#import "Reachability.h"
#import "NSNetwork.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
@class AppDelegate;
@protocol SharedControllerDelegate <NSObject>

-(void)controllerDidFinishLoadingWithResult:(id)result;
-(void)controllerDidFailLoadingWithError:(NSError*)error;

@end

@interface SharedController : NSObject
{
//    id<SharedControllerDelegate> delegate;
    Reachability *reach;
    NSMutableData *data;
    UIAlertView *Alert_UserLocation;
    
    AppDelegate *appDelegate;
}

@property (nonatomic,retain) NSMutableData *data;
@property(nonatomic,assign)id<SharedControllerDelegate> delegate;
+ (SharedController *)sharedController;
+ (AppDelegate*)appDelegate;
- (void)sendRequest:(NSMutableURLRequest *)urlRequest;

-(void)getSeasonalSpecialsdelegate:(id)aDelegate;

-(void)loginDetails:(NSString*)userName Password:(NSString*)password delegate:(id)aDelegate;

-(void)BranchesSelection:(NSString*)userID delegate:(id)aDelegate;

-(void)customerInformation:(NSString*)branchID delegate:(id)aDelegate;

-(void)collectionDetails:(NSString*)branchID toDate:(NSString*)todate delegate:(id)aDelegate;

-(void)outstandingInformation:(NSString*)branchID asOnDate:(NSString*)asOnDate delegate:(id)aDelegate;

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id)aDelegate;

-(void)BusinessAgentPerformance:(NSString*)branchID fromDate:(NSString*)fromDate toDate:(NSString*)toDate delegate:(id)aDelegate;

-(void)CompanyInvestmentRequest:(NSString*)branchID  delegate:(id)aDelegate;

-(void)BidPayableOutstanding:(NSString*)branchID  delegate:(id)aDelegate;

- (UIAlertView *)createProgressViewToParentView:(UIView *)view withTitle:(NSString *)title;
- (void)hideProgressView:(UIAlertView *)inProgressView;
@end
