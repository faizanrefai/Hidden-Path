//
//  calender.h
//  TABBAR
//
//  Created by openxcell technolabs on 6/29/11.
//  Copyright 2011 jn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLCalendarView.h"
#import"CheckmarkTile.h"
#import "FirstViewController.h"
#import <sqlite3.h>
#import "DatabaseMethod.h"




@interface calender : UIViewController<UIWebViewDelegate,KLCalendarViewDelegate> 
{
	IBOutlet UIImageView *imgview;

	KLCalendarView *calendarView;
	KLTile *currentTile;
	NSMutableArray *SelectedDate_Ary;
	KLTile *tile;
	BOOL shouldPushAnotherView;
	FirstViewController *obj_firstview;
	TABBARAppDelegate *obj_AppDelegate;
	DatabaseMethod *obj_databasemethod;
		
	NSString *path;
	NSString *str_selecteddate;
	sqlite3 *database;
	BOOL flag; 
	int tilecounter;
			
		
}
-(void)setParentObj:(FirstViewController *)obj;


@end
