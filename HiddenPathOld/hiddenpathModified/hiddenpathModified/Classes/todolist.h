//
//  todolist.h
//  TABBAR
//
//  Created by openxcell technolabs on 6/20/11.
//  Copyright 2011 jn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "TABBARAppDelegate.h"
#import "DatabaseMethod.h"

#define FONT_SIZE 17.0f
#define CELL_CONTENT_WIDTH 300.0f
#define CELL_CONTENT_MARGIN 10.0f


@interface todolist : UIViewController <UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIPickerViewDelegate>
{

	IBOutlet UITableView *tbl_todolist;
	IBOutlet  UINavigationBar *nvg_bar;
	BOOL show_nvgbar;
	
	UITableView *tbl_dumy;
	int current_index;
	UIDatePicker *dt_picker;
//	UITableViewCell *cell;
	
	IBOutlet UIBarButtonItem *barbtn_edit;
	IBOutlet UIBarButtonItem *barbtn_done;
	
	NSMutableArray *Ary_title;
	NSMutableArray *Ary_date;
	NSMutableArray *ary_id;
	NSMutableArray *statusAry;
	UITextField	*textf1;
	UIView *footerview;
	UITextView *txtview_footer;
	UIView *headerview;
	NSString *date_str;
	UILabel *lbl_celldate;
	UILabel *main_lbl;
	UILabel *lbl_cellone;
	IBOutlet UIImageView *imgview;
	BOOL flag;
	BOOL isPush;
	int rowheight;
	int i;
	int int_id;
	BOOL show_detailcell;
	UIImageView *imgviewCell;
	UIButton *btn_set;
	NSString *tododate;
	BOOL pickerflag;
	NSMutableDictionary *alermDic;
	
//-------->>>>>>>>>> Database Process ------------->>>>>>>>>>>>>>>>>>>
	
	DatabaseMethod *obj_databasemethod;
	TABBARAppDelegate *obj_AppDelegate;
	
	NSInteger todotaskid;
	CGSize stringsize,str;
	NSDate *today;
	int bagcounter;
	
	BOOL dtbtnselec;
	NSString *todaystringUpdate;
	
}
@property (nonatomic)BOOL show_nvgbar;
@property (nonatomic, retain)  UINavigationBar *nvg_bar;
@property (nonatomic, retain) NSMutableDictionary *alermDic;
@property(nonatomic,retain)UITableView *tbl_todolist;
@property(nonatomic,retain)NSMutableArray *Ary_title;
@property(nonatomic,retain)UITextView *txtview_footer;
@property(nonatomic,retain)NSMutableArray *Ary_date;
@property(nonatomic)BOOL flag;
@property(nonatomic)BOOL isPush;
@property(nonatomic)BOOL dtbtnselec;

@property(nonatomic)int rowheight;
-(IBAction)btn_remainder_clicked:(int)val;
- (void)scheduleNotification:(NSString *)str2;
-(IBAction)btn_EditClicked_home:(id)sender;
-(IBAction)Barbtn_Edit_clicked:(id)sender;
@end
