//
//  Affirmation.h
//  TABBAR
//
//  Created by openxcell technolabs on 7/6/11.
//  Copyright 2011 jn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TABBARAppDelegate.h"
#import <sqlite3.h>
#import "DatabaseMethod.h"


@interface Affirmation : UIViewController<UIActionSheetDelegate ,UIApplicationDelegate,UITableViewDataSource,UITextFieldDelegate,UINavigationBarDelegate,UINavigationControllerDelegate>
{
	IBOutlet  UITableView *tbl_Afffirmation;
	IBOutlet UIImageView *imgview;
	UIAlertView *alert;
	NSMutableArray *Ary_title;
	
	NSMutableArray *Ary_Data22;
	
	NSMutableArray *statusAry;

	
	UITextField	*textf1;
	UITableViewCell *Cell;
	IBOutlet UIView *myview;
	BOOL show_nvgbar;
	IBOutlet UINavigationBar *nvgBar;
	IBOutlet UIBarButtonItem *btn_homepage;
	IBOutlet UIBarButtonItem *barbtn_edit;
	IBOutlet UIBarButtonItem *barbtn_done;
	UILabel *lbl_cell;
	UILabel *Main_lbl2;
	UIImageView *imgviewCell;
	UIButton *btn_set;
	
	UIDatePicker *dt_picker;
	BOOL pickerflag;
	BOOL show_nvg;
	//->>>>>>>>>>>>> Database Process ---------->>>>>>>>>>>>>>>>
	
	TABBARAppDelegate *obj_AppDelegate;
	DatabaseMethod *obj_databasemethod;
	NSString *path;
	sqlite3 *database;
	NSString *str_task;
	int i;
	int int_id;
	NSMutableArray *ary_id;
	CGSize stringsize;
	
	NSString *goaldate;
	IBOutlet UINavigationBar *nvg_bar;
	int current_index;
	
}
@property(nonatomic)BOOL show_nvgbar;
- (void)scheduleNotification:(NSString *)str;

-(IBAction)btn_remainder_clicked:(int)Val;
-(IBAction)btn_homepage_clicked:(id)sender;
-(IBAction)Barbtn_Edit_clicked:(id)sender;
-(IBAction)Barbtn_Done_clicked:(id)sender;



@end
