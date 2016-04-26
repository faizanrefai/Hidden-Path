//
//  Gratitude.h
//  TABBAR
//
//  Created by openxcell technolabs on 6/23/11.
//  Copyright 2011 jn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "TABBARAppDelegate.h"
#import "DatabaseMethod.h"


@interface Gratitude : UIViewController <UIActionSheetDelegate,UIApplicationDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
	
	BOOL show_nvg;
	
	NSMutableArray *Ary_title;
	NSMutableArray *Ary_date33;
	NSMutableArray *ary_id;
	NSMutableArray *statusAry;
	UIAlertView *alert;
	
	UITableViewCell *Cell;
	UITextField	*textf1;
	IBOutlet UITableView *tbl_gratitude;
	IBOutlet UIImageView *imgview;
	IBOutlet UIView *myview;
	IBOutlet UINavigationBar *nvgBar;
	
	DatabaseMethod *obj_databasemethod;
	TABBARAppDelegate *obj_AppDelegate;
	
	NSString *path;
	sqlite3 *database;
	NSString *str_task;
	int i;
	int int_id;
	UILabel *lbl_cell;
	UILabel *Main_lbl2;
	UIImageView *imgviewCell;
	UIButton *btn_set;
	
	CGSize stringsize;
	
	NSString *goaldate;
	BOOL pickerflag;
	BOOL isPush;
	UIDatePicker *dt_picker;
	int current_index;

	
	IBOutlet UIBarButtonItem *barbtn_edit;
	IBOutlet UIBarButtonItem *barbtn_done;
	

	
}
@property(nonatomic,retain) UINavigationBar *nvgBar;
@property (nonatomic)BOOL show_nvg;
@property(nonatomic)BOOL isPush;
@property(nonatomic,retain)NSMutableArray *Ary_title;
-(IBAction)btn_pickerview_selected:(id)sender;
- (void)scheduleNotification:(NSString *)str;
-(IBAction)btn_remainder_clicked:(int)val;
-(IBAction)btn_homepage_clicked:(id)sender;
-(IBAction)Barbtn_Edit_clicked:(id)sender;
//-(void)insertdata;
//-(void)DeleteDataFromDatabase:(NSString *)str_delete;
//-(void)RandomDataSerching_FromGratitudeTable;

@end
