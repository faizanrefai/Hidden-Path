//
//  ListOfExcercise.h
//  HiddenPath
//
//  Created by Openxcelltech on 4/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListOfExcercise : UIViewController {
		
	
	NSMutableArray *ary_month;
	
	NSString *titleStr;
	NSMutableArray *Ary_Exercise;
	NSMutableArray *Ary_ExeDesc;
	
	DatabaseMethod *obj_databasemethod;
	int Month1;
	ListOfExcercise *obj;
	IBOutlet UITableView *datatable;

}
@property(nonatomic)int Month1;
@property(nonatomic,retain)NSString *titleStr;

@property(nonatomic)BOOL show_nvg;
-(IBAction)btn_homepage_clicked:(id)sender;
-(IBAction)btn_picker_clicked:(id)sender;
-(void)DatafromExercise;

@end
