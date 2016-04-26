//
//  Homepage.h
//  TABBAR
//
//  Created by openxcell technolabs on 6/20/11.
//  Copyright 2011 jn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TABBARAppDelegate.h"
#import "DatabaseMethod.h"


@interface Homepage : UIViewController <UINavigationControllerDelegate,UITextFieldDelegate>
{

	UINavigationController  *nvgContrl;
	
//	IBOutlet UINavigationBar *nvg_Barstyle;
//	IBOutlet UIBarButtonItem *btn_Loginpage;
	IBOutlet UIImageView *title_imgviewl;
 	IBOutlet UIButton *bnt_click;
	TABBARAppDelegate *obj_delegate;
	IBOutlet UIButton *btn_Journal;
	IBOutlet UIButton *btn_todolist;
	IBOutlet UIButton *btn_Goal;
	IBOutlet UIButton *btn_pdffile;
	IBOutlet UIButton *btn_more;
	IBOutlet UIImageView *imgview;
	IBOutlet UIButton *btn_facebook;
	IBOutlet UIButton *btn_twitter;
	IBOutlet UILabel *lbl_Goal;
	IBOutlet UILabel *lbl_gra;
	IBOutlet UILabel *lbl_twi;
	IBOutlet UILabel *lbl_fb;
	IBOutlet UILabel *lbl_todo;
	IBOutlet UILabel *lbl_jornal;
	IBOutlet UILabel *lbl_pdf;
	IBOutlet UIButton *btn_exercise;
	IBOutlet UIButton *btn_Logout;
	
	//================== LoginView Process ===========================
	UITextField *txt_username;
	UITextField *txt_password;
	UIAlertView *alert;
	UIButton *btn_login;
	UIButton *btn_logout;
	UIView *loginview;
	UIImageView *imgview_logingpage;
	UILabel *lbl_counter;

	UIButton *btn_registration;
	DatabaseMethod *obj_databasemethod;

	
	//IBOutlet UITextField *img_text;
	UIImage *background;	
	
	
	
	
	
}
@property(nonatomic, retain) UIImage *background;
@property(nonatomic,retain)UINavigationController *nvgContrl;
@property(nonatomic,retain)UINavigationBar *nvg_Barstyle;
-(IBAction)btn_Loginpage_clicked:(id)sender;
-(IBAction)btn_clicked:(id)sender;
-(IBAction)btn_Goal_clicked:(id)sender;
-(IBAction)btn_todolist_clicked:(id)sender;
-(IBAction)btn_Journal_clicked:(id)sender;
-(IBAction)btn_pdffile_clicked:(id)sender;
-(IBAction)btn_more_clicked:(id)sender;
-(IBAction)btn_facebook_clicked:(id)sender;
-(IBAction)btn_twitter_clicked:(id)sender;
-(IBAction)btn_Logout_clicked:(id)sender;
-(IBAction)btn_exercise_clicked:(id)sender;
-(IBAction)btn_aff_clicked:(id)sender;


@end
