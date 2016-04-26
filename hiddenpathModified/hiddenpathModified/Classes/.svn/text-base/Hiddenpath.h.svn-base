//
//  Hiddenpath.h
//  TABBAR
//
//  Created by openxcell technolabs on 7/1/11.
//  Copyright 2011 jn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TABBARAppDelegate.h"
#import "DatabaseMethod.h"


@interface Hiddenpath : UIViewController <UITextViewDelegate,UITextFieldDelegate,UIApplicationDelegate,UIScrollViewDelegate>
{
	IBOutlet UIBarButtonItem *btn_homepage;
	IBOutlet UINavigationBar *nvg_bar;
	BOOL show_nvg;
	IBOutlet UIScrollView *MainScrollview;
	IBOutlet UIImageView *imgview;
	IBOutlet UILabel *lbl_username;
	IBOutlet UILabel *lbl_password;
	IBOutlet UILabel *lbl_Registration;
	IBOutlet UIButton *btn_Registration;
	IBOutlet UIButton *btn_cancel;
	IBOutlet UITextField *txt_username;
	IBOutlet UITextField *txt_password;
	IBOutlet UITextView *textview;
	IBOutlet UILabel *lbl_Address;
	IBOutlet UILabel *lbl_Mobile;
	IBOutlet UITextField *txt_mobile;
	IBOutlet UITextField *txt_email;
	IBOutlet UILabel *lbl_email;
	
	UIActivityIndicatorView *indicator;
	UILabel *lbl_counter;
	UIAlertView *alert;
	TABBARAppDelegate *obj_AppDelegate;
	DatabaseMethod *obj_databasemethod;
	
	NSString *str_username;
	NSString *str_password;
	BOOL flage;
	
	
}
@property(nonatomic)BOOL show_nvg;
-(IBAction)btn_homepage_clicked:(id)sender;
-(IBAction)btn_Registration_clicked:(id)sender;
-(IBAction)btn_cancel_clicked:(id)sender;


- (BOOL) validateEmail: (NSString *) candidate;

@end
