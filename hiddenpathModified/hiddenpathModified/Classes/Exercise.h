//
//  Exercise.h
//  TABBAR
//
//  Created by openxcell technolabs on 8/25/11.
//  Copyright 2011 jn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseMethod.h"
#import "ListOfExcercise.h"


@interface Exercise : UIViewController <UIPickerViewDelegate,UITableViewDelegate,UIPickerViewDataSource>
{
	IBOutlet UIImageView *imgview;
	IBOutlet UITableView *tbl_exercise;
	IBOutlet UILabel *lbl;
	UIView *selView;
	
	IBOutlet UIBarButtonItem *btn_homepage;
	IBOutlet UINavigationBar *nvg_bar;
	BOOL show_nvg;
	 UIButton *btn_picker;
	IBOutlet UILabel *lbl_exe;
	NSMutableArray *ary_month;

	NSString *titleStr;
	NSMutableArray *Ary_Exercise;
	NSMutableArray *Ary_ExeDesc;
	
	DatabaseMethod *obj_databasemethod;
	int Month1;
	ListOfExcercise *obj;
	
}

@property(nonatomic)BOOL show_nvg;
-(IBAction)btn_homepage_clicked:(id)sender;
-(IBAction)btn_picker_clicked:(id)sender;
-(void)DatafromExercise;

@end
