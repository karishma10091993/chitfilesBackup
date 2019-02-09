//
//  CustomerViewController.h
//  ChitCareDirectorsModule
//
//  Created by kireeti on 11/04/14.
//  Copyright (c) 2014 Madhavi KireetiSoft technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface CustomerViewController : ViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIImageView *imgCompanyLogo;
    IBOutlet UILabel *lblCompanyName;
    IBOutlet UIButton *btnBranchSelection;
    IBOutlet UILabel *lblNPSValue;
    IBOutlet UILabel *lblPSValue;
    IBOutlet UILabel *lblSFValue;
    IBOutlet UILabel *lblTotalValue;
    IBOutlet UIView *viewBranchDetails;
    IBOutlet UILabel *lblNPSPercentage;
    IBOutlet UILabel *lblPSPercentage;
    IBOutlet UILabel *lblSFPercentage;
    IBOutlet UIImageView *imgLogo;
    
    UIPickerView *pickerView;
    UIView *customPickerView;
}
@property(nonatomic,retain)NSDictionary *dictLoginDetails;
@property(nonatomic,retain)NSMutableArray *arrBranchList;
-(IBAction)btnBranchSelection_touchUpInside:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *Selectbrachbtn;

@end
