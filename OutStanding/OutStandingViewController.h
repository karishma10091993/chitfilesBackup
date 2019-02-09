//
//  OutStandingViewController.h
//  ChitCareDirectorsModule
//
//  Created by kireeti on 11/04/14.
//  Copyright (c) 2014 Madhavi KireetiSoft technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OutStandingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    IBOutlet UIButton *btnBranchSelection;
    IBOutlet UILabel *lblNPSValue;
    IBOutlet UILabel *lblPSValue;
    IBOutlet UILabel *lblSFValue;
    IBOutlet UILabel *lblTotalValue;
    IBOutlet UIView *viewBranchDetails;
   
    IBOutlet UILabel *lblNPSPercentage;
    IBOutlet UILabel *lblPSPercentage;
    IBOutlet UILabel *lblSFPercentage;
    
    IBOutlet UILabel *lblCompanyName;
    IBOutlet UIImageView *imgCompanyLogo;
}

@property(nonatomic,retain)NSMutableArray *arrBranchesList;
@property(nonatomic,retain)NSDictionary *dictLoginDetails;

-(IBAction)btnBranchSelection_touchUpInside:(id)sender;

@end
