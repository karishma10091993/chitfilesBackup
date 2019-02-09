//
//  LoginViewController.h
//  ChitCareDirectorsModule
//
//  Created by kireeti on 11/04/14.
//  Copyright (c) 2014 Madhavi KireetiSoft technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *txtFldUserName;
    IBOutlet UITextField *txtFldPwd;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *lblCompanyName;
    IBOutlet UIImageView *imgCompanyLogo;
}
-(IBAction)submit_TouchUpInside:(UIButton*)sender;

@end
