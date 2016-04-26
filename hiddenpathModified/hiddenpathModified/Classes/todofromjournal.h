//
//  todofromjournal.h
//  HiddenPath
//
//  Created by openxcell technolabs on 9/30/11.
//  Copyright 2011 jn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseMethod.h"
#import"TABBARAppDelegate.h"


@interface todofromjournal : UIViewController <UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UITextFieldDelegate>
{
		IBOutlet UITableView *tbl_todo;
		IBOutlet UIImageView *pathimgview;
	
	NSMutableArray *Ary_title;
	NSMutableArray *Ary_date;
	NSMutableArray *statusAry;
	UITextField	*textf1;

	UILabel *lbl_celldate;
	UILabel *main_lbl;
	UILabel *lbl_cellone;
	UIButton *btn_set;

	NSString *tododate;
	BOOL pickerflag;
	int current_index;
	int bagcounter;
	
	UIImageView *imgviewCell;
	
	UIDatePicker *dt_picker;
	NSString *fromjornal;

	NSMutableDictionary *alermDic;
	
	DatabaseMethod *obj_databasemethod;
	TABBARAppDelegate *obj_AppDelegate;
	
	CGSize stringsize,str;
	NSString *todaystringUpdate;

	

}

-(IBAction)btn_remainder_clicked:(int)val;
- (void)scheduleNotification:(NSString *)str2;

@end
