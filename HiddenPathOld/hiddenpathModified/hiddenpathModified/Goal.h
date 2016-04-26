//
//  Goal.h
//  TABBAR
//
//  Created by openxcell technolabs on 6/22/11.
//  Copyright 2011 jn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "TABBARAppDelegate.h"
#import "DatabaseMethod.h"


@interface Goal : UIViewController <UINavigationBarDelegate,UIActionSheetDelegate, UIApplicationDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	
	BOOL show_nvg;
	IBOutlet UIBarButtonItem *barbtn_edit;
	IBOutlet UIBarButtonItem *barbtn_done;
	IBOutlet UITableView *tbl_Goal;
	NSMutableArray *Ary_GoalData;
	NSMutableArray *statusAry;
	NSMutableArray *Ary_Data;
	UIButton *btn_cheched;
	NSIndexPath *chekedindexpath;
	UITextField	*textf1;
	UITableViewCell *Cell;
	IBOutlet UIImageView *imgview;
	IBOutlet UIView *myview;
	UIAlertView *alert;
	UILabel *Main_lbl;
	
	UILabel *Main_lbl2;
	
	UIImageView *imgviewCell;
	
	UIDatePicker *dt_picker;
	//---->>>>>>> Data base ------>>>>>>>>>>>
	TABBARAppDelegate *obj_AppDelegate;
	DatabaseMethod  *obj_databaseMethod;
	
	NSString *str_textfielddata;
	int i;
	int int_id;
	BOOL isPush;
	BOOL pickerflag;
	CGSize stringsize;
	UIButton *btn_set;
	NSString *goaldate;
	int current_index;
	IBOutlet UINavigationBar *nvg_bar;
	
}

@property (nonatomic, retain)  UINavigationBar *nvg_bar;
@property (nonatomic)BOOL show_nvg;
@property(nonatomic,retain)NSMutableArray *Ary_GoalData;
@property(nonatomic,retain)NSIndexPath *chekedindexpath;
@property(nonatomic)BOOL isPush;
@property(nonatomic,retain)NSString *str_textfielddata;

-(IBAction)btn_homepage_clicked:(id)sender;
- (void)scheduleNotification:(NSString *)str;
-(IBAction)btn_remainder_clicked:(int)val;
-(IBAction)Barbtn_Edit_clicked:(id)sender;
//- (void)animateTextField:(UITextField*) textField up: (BOOL) up ;
@end
