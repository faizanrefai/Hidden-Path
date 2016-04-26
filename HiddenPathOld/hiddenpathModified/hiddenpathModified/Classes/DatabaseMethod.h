//
//  DatabaseMethod.h
//  TABBAR
//
//  Created by openxcell technolabs on 7/20/11.
//  Copyright 2011 jn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TABBARAppDelegate.h"
@class FirstViewController;

@interface DatabaseMethod : UIView 
{
	
	
	
	
	
	NSString *path;
	sqlite3 *database;
	NSString *str_task;
	NSString *str_date33;
	NSString *str_date11;
	NSString *str_date22;
	NSString *str_statusToDo;
	NSString *str_remainder;
	NSString *str_status;
	NSString *str_username,*str_password,*str_selecteddate;
	
	int i;
	int int_id;
	TABBARAppDelegate *obj_AppDelegate;
	FirstViewController *obj_firstview;
	
}
//----------- Declaration of Loginview And Logintable ----------------------------

-(BOOL)UserNameAndPasswordSerching_FromLogin:(NSString *)username passwordString:(NSString *)password;
-(NSString *)ForgotPasswordAndUsername:(NSString *)user mobile:(NSString *)mob;
-(NSMutableArray *)Serching_FromLogin;

//----------- Declaration of Registration View database Methdo --------------------

//-(void)insertdata_IntoLoginTable:(NSString *)username Password:(NSString *)password;
-(void)insertdata_IntoLoginTable:(NSMutableDictionary *)Dict;
-( NSMutableArray *)RandomDataSerching_FromLogin;

//----------- Declaration of Journal View And Mastetable -------------------------

-(void)insertdata_MasterTable:(NSMutableArray *)Ary_Journal;
-(NSMutableArray *) RandomDataSerching_FromQuoates;
-(NSMutableArray *)fillarray_affirmation:(int)number;
-(NSMutableArray *)fillarray_goal:(int)number;
-(NSMutableArray *)fillarray:(int)number;
-(NSMutableArray *)fillarray_gratitude:(int)number;


//----------- Declaration of Goal Table database Process -------------------------

-(void)insertdata_Goal:(NSString *)str_text Date:(NSString*)date;
-(void)updateGoal_AlermValue:(NSString *)str_text  Date:(NSString *)date;

-(NSMutableDictionary *)RandomDataSerching_FromGoal;
-(void)DeleteDataFromDatabase:(NSString *)str_delete deleteYesNO:(NSString *)bool_dele;
-(void)updatecell:(NSString *)str_update update:(NSString *)str_bool;
-(void)updateToDocell:(NSString *)str_update update:(NSString *)str_bool;
//----------- Declaration of TodoTask Table Database Process ----------------------

-(void)insertdata_todotask:(NSString *)str_data remeinderdate:(NSString *)str_date;
-(NSMutableDictionary *)RandomDataSerching_FromToDotask:(NSString *)date;
-(void)DeleteDataFromTodoList:(NSString *)str_delete;


-(void)updateTodo_AlermValue:(NSString *)str_text  Date:(NSString *)date  updateToday_date:(NSString*)updateTodaydat;

-(NSMutableDictionary *)RandomDataTodoFromJournal_FromToDotask:(NSString *)date;

-(NSString *)GetRemindar:(NSString *)task;

//-(void)DeleteDataFromDatabase:(NSString *)str_delete remainderdate:(NSString *)str_remaind;

//----------- Declaration of Gratitute Table Database Process ------------------------

-(NSMutableDictionary *)RandomDataSerching_FromGratitudeTable;
-(void)DeleteDataFromGratitude:(NSString *)str_delete deleteYesNO:(NSString *)bool_dele;
-(void)insertdata:(NSString *)str_textfield Date:(NSString*)date;
-(void)UpdateGratitude_AlermValue:(NSString *)str_text  Date:(NSString *)date;
-(void)updatecellofGratitude:(NSString *)str_update update:(NSString *)str_bool;



//----------- Declaration of Affirmation Database Process --------------------------

-(void)insertdata_Affirmation:(NSString *)strind_field Date:(NSString*)date;
-(void)DeleteDataFromAffirmation:(NSString *)str_delete deleteYesNO:(NSString *)bool_dele;
-(NSMutableDictionary *)RandomDataSerching_FromAffirmationTable;
-(void)updateAffirmation_AlermValue:(NSString *)str_text  Date:(NSString *)date;
-(void)updatecellofAffirmation:(NSString *)str_update update:(NSString *)str_bool;



//----------- Login View -------------------------------------------------------------

-(BOOL)RandomDataSerching_FromLogin:(NSString *)username  password:(NSString *)password;

//----------- Calender View -----------------------------------------------------------
-(NSMutableArray *)RandomDataSerching_FromMasterTable;
-(NSMutableDictionary  *)RandomDataSerching_FromMasterTableForJournalPage:(NSString *)date;

//------------ Exercise --------------------------------------------------------------
-(NSMutableDictionary *)RandomDataSerching_FromExercise:(int)month;

-(NSString *)RandomDataSerching_FromExerciseDetail:(NSString *)exercise;

@end
