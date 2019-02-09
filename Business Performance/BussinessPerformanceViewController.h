//
//  BussinessPerformanceViewController.h
//  ChitCareDirectorsModule
//
//  Created by kireeti on 11/04/14.
//  Copyright (c) 2014 Madhavi KireetiSoft technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BussinessPerformanceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIButton *btnSelectBranch;
    IBOutlet UITableView *tableView;
    IBOutlet UIView *viewBussinessData;
    
    IBOutlet UILabel *lblCompanyName;
    IBOutlet UIImageView *imgCompanyLogo;
    IBOutlet UIButton *btnChange;
    
    IBOutlet UILabel *lblCity;
}
-(IBAction)btnSelectBranch_touchUpInside:(id)sender;
-(IBAction)btnChange_TouchUpInside:(id)sender;

@property(nonatomic,retain)NSMutableArray *arrBranchesList;
@property(nonatomic,retain)NSDictionary *dictLoginDetails;

@end
