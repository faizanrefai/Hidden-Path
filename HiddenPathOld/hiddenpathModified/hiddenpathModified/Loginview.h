//
//  Loginview.h
//  TABBAR
//
//  Created by openxcell technolabs on 8/4/11.
//  Copyright 2011 jn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TABBARAppDelegate.h"
@class DatabaseMethod;


@interface Loginview : UIViewController <UITextFieldDelegate,UIAlertViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
	TABBARAppDelegate *obj_AppDelegate;

    
    
    //Custome table ---
    
    UITableView *tbl_login;
    NSMutableArray *Ary_Data;
    NSMutableArray *Ary_filter;
    
	
    IBOutlet UIScrollView *scroll;
	IBOutlet	UIView *myview;
	IBOutlet	UIImageView *imgview_logingpage;
	IBOutlet UITextField *txt_password;
	IBOutlet UITextField *user_name;
	IBOutlet UIButton *btn_login;
	IBOutlet UIButton *btn_logout;
	IBOutlet UIButton *btn_Registration;
	IBOutlet UILabel *lbl_username;
	IBOutlet UILabel *lbl_password;
	
	IBOutlet UIButton *btn_forgot;
	UITextField *txt_usr;
	UITextField *txt_mo;
	UIAlertView *alertinvalid;
	UIAlertView *alertvalid;
	
	IBOutlet UIButton *rememberMeBtn;
	
	UIView  *ForgotView;
	//IBOutlet UINavigationBar *nvigationBar;
	
	DatabaseMethod *obj_databasemethod;
	UIAlertView *alert;

	UIScrollView *forscrollview;	

}
@property (nonatomic, retain) UIButton *rememberMeBtn;

-(IBAction)Reset_clicked:(id)sender;
-(IBAction)btn_login_clicked:(id)sender;
-(IBAction)btn_Registration_clicked:(id)sender;
-(IBAction)forGopassword:(id)sender;
- (BOOL) validateEmail: (NSString *) candidate;
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring ;
- (void) finishedSearching ;
-(IBAction)RememberMe;

@end
