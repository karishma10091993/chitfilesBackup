//
//  BidPayableOutstandingViewController.h
//  chitcareerpdirectorsmodule
//
//  Created by kireeti on 15/04/14.
//  Copyright (c) 2014 Madhavi KireetiSoft technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BidPayableOutstandingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIButton *btnSelectBranch;
    IBOutlet UILabel *lblComapnyName;
    IBOutlet UILabel *lblAbove90Value;
    IBOutlet UILabel *lblBtn15_30Value;
    IBOutlet UILabel *lblLess15Value;
    IBOutlet UILabel *lblTotalValue;
    
    IBOutlet UILabel *lblAbove90Percentage;
    IBOutlet UILabel *lblBtn15_30Percentage;
    IBOutlet UILabel *lblLess15Percentage;
    IBOutlet UILabel *lblBtn30_90Percentage;
    IBOutlet UILabel *lblBtn30_90Value;
    
    IBOutlet UIView *viewBIDPAY;
    
    IBOutlet UIImageView *imgCompanyLogo;

}

@property(nonatomic,retain)NSMutableArray *arrBranchesList;
@property(nonatomic,retain)NSDictionary *dictLoginDetails;

-(IBAction)btnSelectBranch_TouchUpInside:(id)sender;


@end
