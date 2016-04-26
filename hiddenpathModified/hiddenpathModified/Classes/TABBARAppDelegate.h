//
//  TABBARAppDelegate.h
//  TABBAR
//
//  Created by openxcell technolabs on 6/18/11.
//  Copyright 2011 jn. All rights reserved.
//my view

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class Loginview;

@interface TABBARAppDelegate : NSObject <UIApplicationDelegate,UINavigationControllerDelegate,UINavigationBarDelegate,UIAlertViewDelegate,UITabBarControllerDelegate,UITextFieldDelegate,UIAccelerometerDelegate>
{
    
	UIWindow *window;
    UITabBarController *tabBarController;
	UIView *loginview;
	UINavigationController *Viewnavigation;
	UITextField *txt_username;
	UITextField *txt_password;
	
	NSString *str_selecteddate;
	
	NSMutableArray *CurMonth_Ary;
	Loginview *obj_logview;
	

//----------  DATABASE PROCESS -------------
	
	NSString *path;
	sqlite3 *database;
	NSString *str_username,*str_password;
	
	NSString *DBName;
	NSString *DBPath;
	int CounterAtile;
	BOOL isStatus;
	BOOL isStatusToDo;
	BOOL isStatusGrati;
	BOOL isStatusAffr;
	BOOL islogout;
	BOOL isforgot;
	BOOL istoday;
		
	NSString *loginIdStr;
	BOOL isRememberLogin;
	BOOL fromHome;
	BOOL isTodo;
	NSString  *insertdatecal;
}


extern NSString *kRemindMeNotificationDataKey;
@property (nonatomic, retain)NSString *loginIdStr;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property(nonatomic,retain)UINavigationController *Viewnavigation;
@property(nonatomic,retain)NSMutableArray *CurMonth_Ary;
@property(nonatomic)int CounterAtile;
@property(nonatomic)BOOL isRememberLogin;
@property(nonatomic)BOOL isStatus;
@property(nonatomic)BOOL isStatusGrati;
@property(nonatomic)BOOL isStatusAffr;
@property(nonatomic)BOOL islogout;
@property(nonatomic)BOOL isforgot;
@property(nonatomic)BOOL istoday;
@property(nonatomic)BOOL isTodo;
@property (nonatomic)BOOL fromHome;
@property (nonatomic)BOOL isStatusToDo;

@property(nonatomic,retain)NSString *insertdatecal;



- (void)showReminder:(NSString *)text;
-(NSString *)getdatabasepath;
-(void)CheckedAndCreateDatabase;


@end
