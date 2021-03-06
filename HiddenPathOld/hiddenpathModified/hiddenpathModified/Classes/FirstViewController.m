//
//  FirstViewController.m
//  TABBAR
//
//  Created by openxcell technolabs on 6/18/11.
//  Copyright 2011 jn. All rights reserved.
//
#import "FirstViewController.h"
#import "Homepage.h"
#import "calender.h"
#import "todolist.h"
#import "Goal.h"
#import "Affirmation.h"
#import <sqlite3.h>
#import <QuartzCore/QuartzCore.h>
#import "DatabaseMethod.h"
#import "Gratitude.h"
#import "todofromjournal.h"

static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;


@implementation FirstViewController
@synthesize tbl_journal,txtview_footer,str_Calendar,Selecteddate_Ary,isMaster,lblDateName;



-(void)Save {	
	Ary_Master=[[NSMutableArray alloc]initWithObjects:lbl_quotation.text,lbl_date.text,[Ary_Todo objectAtIndex:0],[Ary_Todo objectAtIndex:1],[Ary_Affirmation objectAtIndex:0],[Ary_Affirmation objectAtIndex:1],[Ary_Affirmation objectAtIndex:2],[Ary_goal objectAtIndex:0],[Ary_goal objectAtIndex:1],[gratitude_arr objectAtIndex:0],[gratitude_arr objectAtIndex:1],txtview_footer.text, nil];
	[obj_databasemethod insertdata_MasterTable:Ary_Master];
	alert=[[UIAlertView alloc]initWithTitle:@"Hidden Path Alert" message:@"Journal Save Succesfuly" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
	[alert show];
	[alert release];	
	tbl_journal.frame=CGRectMake(0, 44, 320, 460);
	txtview_footer.text=@"";	
	[txtview_footer resignFirstResponder];
	[tbl_journal reloadData];
	
 
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	[self viewWillAppear:YES];
}
- (void)scheduleNotification {
	UILabel *lbl=[[UILabel alloc]init];
	lbl.text=@"Hiddenpath";
        
    NSString *everday=@"2011-09-13 09:20:00";
	
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	[df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];

	NSDate *parsed = [df dateFromString:everday];
	NSLog(@"date Parsed is------ %@",parsed);
	
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    Class cls = NSClassFromString(@"UILocalNotification");
    if (cls != nil) {
        
        UILocalNotification *notif = [[cls alloc] init];
        notif.fireDate = parsed;
        notif.timeZone = [NSTimeZone defaultTimeZone];
		//notif.repeatInterval=24*60*60;
        notif.repeatInterval= NSDayCalendarUnit;

        
        notif.alertBody = @"Did you forget something?";
        notif.alertAction = @"Show me";
        notif.soundName = UILocalNotificationDefaultSoundName;
        notif.applicationIconBadgeNumber = 1;
        
        NSDictionary *userDict = [NSDictionary dictionaryWithObject:lbl.text
                                                             forKey:@"matchDateandTime"];
        notif.userInfo = userDict;
        
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        [notif release];
        
    }
}


- (void)viewDidLoad 
{
    [super viewDidLoad];
	flage = TRUE;
	isMaster=FALSE;
	
	
	NSDate *today=[NSDate date];
	NSLog(@"today is %@",today);
	[self scheduleNotification];
	
	Ary_Exercise=[[NSMutableArray alloc]init];
	Ary_ExeDesc=[[NSMutableArray alloc]init];

	
	self.navigationItem.title=@"Journal";
	tbl_journal.backgroundColor=[UIColor clearColor];
	obj_AppDelegate=(TABBARAppDelegate *)[[UIApplication sharedApplication]delegate];
	obj_databasemethod=[[DatabaseMethod alloc]init];
	
	Selecteddate_Ary=[[NSMutableArray alloc]init];
	Fill_ary=[[NSMutableArray alloc]init];
	fill_affi_ary=[[NSMutableArray alloc]init];
	fill_goal_ary=[[NSMutableArray alloc]init];
	Ary_date=[[NSMutableArray alloc]init];
	Ary_Affirmation=[[[NSMutableArray alloc]init]retain];
	Ary_goal=[[[NSMutableArray  alloc]init]retain];
	Ary_Quoates=[[NSMutableArray alloc]init];
	Ary_Todo =[[[NSMutableArray alloc]init]retain];
	gratitude_arr = [[[NSMutableArray alloc] init]retain];
	fill_gra_ary = [[NSMutableArray alloc]init];
	Ary_GoalDate=[[NSMutableArray alloc]init];
	tbl_journal.backgroundColor=[UIColor clearColor];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonSystemItemFastForward  target:self action:@selector(btn_EditClicked:)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(Save)];
	
	
	
	
//===== tablefooter===================
	
	footerview=[[UIView alloc]initWithFrame:CGRectMake(05, 02,300,130)];
	footerview.backgroundColor=[UIColor lightGrayColor];
	footerview.layer.cornerRadius=5.0;
	txtview_footer=[[UITextView alloc]initWithFrame:CGRectMake(10, 11, 295,110)];
	txtview_footer.backgroundColor=[UIColor whiteColor];
	txtview_footer.delegate=self;
	[txtview_footer	setAlwaysBounceVertical:YES];
	txtview_footer.textColor=[UIColor blackColor];
	txtview_footer.font=[UIFont fontWithName:@"Georgia" size:15.0];
	txtview_footer.clipsToBounds = YES;
	txtview_footer.layer.cornerRadius=5.0;
	txtview_footer.keyboardAppearance=UIKeyboardTypeDefault;
	txtview_footer.returnKeyType=UIReturnKeyDone;
	//txtview_footer.backgroundColor=[UIColor whiteColor];
	txtview_footer.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];

	[footerview addSubview:txtview_footer];
	
	//=============tableHeade ==========================
	
	headerview=[[UIView alloc]initWithFrame:CGRectMake(01, 0, 278, 80)];
	//headerview.backgroundColor=[UIColor lightGrayColor];
	headerview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	
	//UIView *hdview=[[UIView alloc]initWithFrame:CGRectMake(02, 01, 120, 76)];
	UIView *hdview=[[UIView alloc]initWithFrame:CGRectMake(70, 01, 180, 20)];
	hdview.backgroundColor = [UIColor clearColor];
	//hdview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	UIButton *btn_date=[UIButton buttonWithType:UIButtonTypeCustom];
	//[btn_date setBackgroundColor:[UIColor grayColor]];
	
	
	//[btn_date setFrame:CGRectMake(0, 01, 120,76)];
	btn_date.font =[UIFont fontWithName:@"Georgia" size:14.0];
	[btn_date setFrame:CGRectMake(100, 0, 95,20)];
	[btn_date addTarget:self action:@selector(btn_date_clicked:)forControlEvents:UIControlEventTouchUpInside];
	//[btn_date setImage:[UIImage imageNamed:@"CellBK.png"] forState:UIControlStateNormal];
	lbl_day=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 120, 20)];
	lbl_day.backgroundColor=[UIColor redColor];
	//lbl_day.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBk.png"]];
	lbl_day.font=[UIFont fontWithName:@"Georgia" size:14.0];
	lbl_day.textColor=[UIColor blackColor];
	lbl_day.shadowColor=[UIColor whiteColor];
	lbl_execiseheding=[[UILabel alloc]initWithFrame:CGRectMake(0, 41, 120,25)];
	lbl_execiseheding.font=[UIFont fontWithName:@"Georgia" size:14.0];
	lbl_execiseheding.textColor=[UIColor blackColor];
	lbl_execiseheding.shadowColor=[UIColor whiteColor];
	lbl_execiseheding.backgroundColor=[UIColor clearColor];
	lbl_execiseheding.adjustsFontSizeToFitWidth=TRUE;
	//lbl_execiseheding.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];

	
	//lbl_date=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 77)];
	lblDateName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 110, 20)];
	lblDateName.textColor = [UIColor blackColor];
	lblDateName.font=[UIFont fontWithName:@"Georgia-Bold" size:14.0];
	lblDateName.text = @"Journal Date :";
	lblDateName.backgroundColor = [UIColor clearColor];
	lbl_date=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 20)];
	lbl_date.textColor = [UIColor redColor];
	lbl_date.backgroundColor = [UIColor clearColor];
	//lbl_date.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	[lbl_date setTextAlignment:UITextAlignmentCenter];
	lbl_date.font=[UIFont fontWithName:@"Georgia" size:14.0];
	lbl_quotation=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 316, 60)];
	//lbl_quotation=[[UILabel alloc]initWithFrame:CGRectMake(124, 01, 192, 77)];
	lbl_quotation.backgroundColor=[UIColor clearColor];
	[lbl_quotation setTextAlignment:UITextAlignmentCenter];
	lbl_quotation.numberOfLines=999;
	lbl_quotation.lineBreakMode = UILineBreakModeWordWrap; 
   
	lbl_quotation.textColor=[UIColor blackColor];
	lbl_quotation.adjustsFontSizeToFitWidth=TRUE;
    [lbl_quotation setLineBreakMode:UILineBreakModeWordWrap];
	//lbl_quotation.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	lbl_quotation.font=[UIFont fontWithName:@"Georgia"size:14.0];
	lbl_date.textColor=[UIColor blackColor];
	[btn_date addSubview:lbl_date];
	
	//[btn_date addSubview:lbl_day];
//	[btn_date addSubview:lbl_execiseheding];
	[hdview addSubview:lblDateName];
	[hdview addSubview:btn_date];
	[headerview addSubview:hdview];
    headerview.layer.cornerRadius=5.5;
	[headerview addSubview:lbl_quotation];
	
	
	[self.tbl_journal setTableHeaderView:headerview];
	[self.tbl_journal setTableFooterView:footerview];
	
	randomno_ARR1 =[[NSMutableArray alloc]init];
	randomno_ARR2 =[[NSMutableArray alloc]init];
	randomno_ARR3 =[[NSMutableArray alloc]init];
		
	
}

-(void)viewWillAppear:(BOOL)animated
{
	
	NSDate *parsed = [NSDate date];
	NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
	[dateFormat1 setDateFormat:@"dd/MMM/yyyy"];
	NSString *dateString = [dateFormat1 stringFromDate:parsed];
	
	NSLog(@"Compartion date is - %@",dateString);
	NSLog(@"Compartion date is - %@",str_Calendar);
	
	if([str_Calendar isEqualToString:@""]||str_Calendar == nil )
	{
		NSDate *today = [NSDate date];
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"dd MMM, yyyy"];
		NSString *dateString = [dateFormat stringFromDate:today];
		lbl_date.text=[NSString stringWithFormat:@"%@",dateString];
		
		
		
		NSDateComponents *components=[[NSCalendar currentCalendar]components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:today];
		NSInteger day = [components day];    
		NSInteger month = [components month];
		Month1=month;
		//NSInteger year = [components year];
		lbl_day.text=[NSString stringWithFormat:@"Day %d Of",day];
		
		NSMutableDictionary *dict_Exe=[obj_databasemethod RandomDataSerching_FromExercise:Month1];
		
		//[Ary_Exercise addObject:[dict_Exe valueForKey:@"exercise"]];
		Ary_Exercise=[dict_Exe objectForKey:@"exercise"];
		//Ary_Exercise=[obj_databasemethod RandomDataSerching_FromExercise:1];
		titleStr=[dict_Exe objectForKey:@"title"];
		lbl_execiseheding.text=titleStr;
		Ary_ExeDesc=[dict_Exe objectForKey:@"description"];		
	}
	
	else{		
		//NSLog(str_Calendar);
		NSDateFormatter *mmddccyy = [[NSDateFormatter alloc] init];
		mmddccyy.timeStyle = NSDateFormatterNoStyle;
		mmddccyy.dateFormat = @"dd MMM, yyyy";
		NSDate *d = [mmddccyy dateFromString:str_Calendar];
		NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:d];
		NSInteger day = [components day];    
		NSInteger month = [components month];
		Month1=month;
		lbl_date.text=[NSString stringWithFormat:@"%@",str_Calendar];
		lbl_day.text=[NSString stringWithFormat:@"Day of %d",day];
		
		
		NSMutableDictionary *dict_Exe=[obj_databasemethod RandomDataSerching_FromExercise:Month1];
		
		//[Ary_Exercise addObject:[dict_Exe valueForKey:@"exercise"]];
		Ary_Exercise=[dict_Exe objectForKey:@"exercise"];
		//Ary_Exercise=[obj_databasemethod RandomDataSerching_FromExercise:1];
		titleStr=[dict_Exe objectForKey:@"title"];
		lbl_execiseheding.text=titleStr;
		Ary_ExeDesc=[dict_Exe objectForKey:@"description"];		
		//	NSInteger year = [components year];				
	}
	
	
	
	
    Ary_Quoates=[obj_databasemethod RandomDataSerching_FromQuoates];
    int i =arc4random()%[Ary_Quoates count];
    
	//NSString *str_t  = @"All the breaks you need in life wait within your imagination. Imagination is the workshop of your mind, capable of turning mind energy into accomplishment and wealth... Napoleon Hill";
	
	
    NSString *str_t = [Ary_Quoates objectAtIndex:i];
	CGSize actualSize = [str_t sizeWithFont:[UIFont fontWithName:@"Georgia" size:14.0]
						  constrainedToSize:CGSizeMake(316, 9999) lineBreakMode:UILineBreakModeWordWrap];	
	CGSize textLabelSize = {actualSize.width, actualSize.height};
	lbl_quotation.font=[UIFont fontWithName:@"Georgia"size:14.0];
	if(textLabelSize.height >47){
		NSLog(@"font size decrese");
		lbl_quotation.font=[UIFont fontWithName:@"Georgia"size:12.0];
	}
	lbl_quotation.text=[Ary_Quoates objectAtIndex:i];
	//lbl_quotation.text=str_t;
    [lbl_quotation setAdjustsFontSizeToFitWidth:YES];
	//[lbl_quotation sizeToFit];
	obj_AppDelegate.insertdatecal=lbl_date.text;
	
	
	if(isMaster){		
		NSString *str=str_Calendar;
		NSString *str1=@"";
		txtview_footer.text=@"";
		
		[Ary_Todo removeAllObjects];
		[Ary_Affirmation removeAllObjects];
		[Ary_goal removeAllObjects];
		[gratitude_arr removeAllObjects];	
		[Fill_ary removeAllObjects];
		[fill_affi_ary removeAllObjects];
		[fill_goal_ary removeAllObjects];
		[fill_gra_ary removeAllObjects];

		for (str1 in Selecteddate_Ary ){
							
			if([str isEqualToString:str1]){
			
					NSMutableDictionary *dic=[obj_databasemethod RandomDataSerching_FromMasterTableForJournalPage:str];
	
								NSLog(@"main Dictionary - %@",dic);
								[Ary_Todo removeAllObjects];
								[Ary_Affirmation removeAllObjects];
								[Ary_goal removeAllObjects];
								[gratitude_arr removeAllObjects];
								[Fill_ary removeAllObjects];
								[fill_affi_ary removeAllObjects];
								[fill_goal_ary removeAllObjects];
								[fill_gra_ary removeAllObjects];
								Ary_Todo=[dic objectForKey:@"todolist"];
								Ary_Affirmation=[dic objectForKey:@"affirmation"];
								Ary_goal=[dic objectForKey:@"goal"];
								gratitude_arr=[dic objectForKey:@"gratitude"];
				
				NSString *str_t  = @"All the breaks you need in life wait within your imagination. Imagination is the workshop of your mind, capable of turning mind energy into accomplishment and wealth... Napoleon Hill";

				//NSString *str_t = [dic objectForKey:@"que"];
				CGSize actualSize = [str_t sizeWithFont:[UIFont fontWithName:@"Georgia" size:14.0]
											constrainedToSize:CGSizeMake(500, 9999) lineBreakMode:UILineBreakModeWordWrap];	
				CGSize textLabelSize = {actualSize.width, actualSize.height};
				lbl_quotation.font=[UIFont fontWithName:@"Georgia"size:14.0];
				if(textLabelSize.height >47){	
					NSLog(@"font size decrrese");
				lbl_quotation.font=[UIFont fontWithName:@"Georgia"size:12.0];
				}
				
								//lbl_quotation.text=[dic objectForKey:@"que"];
				lbl_quotation.text = @"All the breaks you need in life wait within your imagination. Imagination is the workshop of your mind, capable of turning mind energy into accomplishment and wealth... Napoleon Hill";
								txtview_footer.text=[dic objectForKey:@"info"];
					
					int Nooftodo=[Ary_Todo count];
					Fill_ary=[obj_databasemethod fillarray:Nooftodo];
					int  No=[Ary_Affirmation count];
					
					fill_affi_ary=[obj_databasemethod fillarray_affirmation:No];
					int Noofgoal=[Ary_goal count];
					
					fill_goal_ary=[obj_databasemethod fillarray_goal:Noofgoal];
					int noG = [gratitude_arr count];
					fill_gra_ary =[obj_databasemethod fillarray_gratitude:noG];
								lbl_date.text=[NSString stringWithFormat:@"%@",str_Calendar];
								[dic release];
			
				}
						
		}
			
		[Ary_Todo removeAllObjects];
		[Ary_date removeAllObjects];
		
		
		NSMutableDictionary *dic_Todo=[[NSMutableDictionary alloc]init];
		obj_AppDelegate.istoday=TRUE;
		dic_Todo=[obj_databasemethod RandomDataSerching_FromToDotask:obj_AppDelegate.insertdatecal];
		Ary_Todo=[dic_Todo objectForKey:@"todotask"];
		Ary_date=[dic_Todo objectForKey:@"remainder"];	
		
		[dic_Todo release];
		int Nooftodo=[Ary_Todo count];
		Fill_ary=[obj_databasemethod fillarray:Nooftodo];
		NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]init];
		obj_AppDelegate.isStatusAffr=TRUE;
		dictionary=[obj_databasemethod  RandomDataSerching_FromAffirmationTable];	
		Ary_Affirmation=[dictionary objectForKey:@"affirmation"];
		
		[dictionary release];
		
		int  No=[Ary_Affirmation count];
		
		fill_affi_ary=[obj_databasemethod fillarray_affirmation:No];
		
		
		NSMutableDictionary *dic_goal=[[NSMutableDictionary alloc]init];
		obj_AppDelegate.isStatus=TRUE;
		dic_goal=[obj_databasemethod  RandomDataSerching_FromGoal];
		Ary_goal=[dic_goal objectForKey:@"goal"];
		
		int Noofgoal=[Ary_goal count];
		
		fill_goal_ary=[obj_databasemethod fillarray_goal:Noofgoal];
		
		//[dic_goal release];
		
		
		obj_AppDelegate.isStatusGrati=TRUE;
		
		NSMutableDictionary *a_dic= [obj_databasemethod RandomDataSerching_FromGratitudeTable] ;
		
		gratitude_arr = [a_dic valueForKey:@"gratitude"];
		int noG = [gratitude_arr count];
		fill_gra_ary =[obj_databasemethod fillarray_gratitude:noG];			
		//}	
		
		isMaster=FALSE;
	}
	else
	{
		NSMutableDictionary *dic_Todo=[[NSMutableDictionary alloc]init];
		obj_AppDelegate.istoday=TRUE;
			dic_Todo=[obj_databasemethod RandomDataSerching_FromToDotask:obj_AppDelegate.insertdatecal];
		Ary_Todo=[dic_Todo objectForKey:@"todotask"];
		Ary_date=[dic_Todo objectForKey:@"remainder"];			
		[dic_Todo release];	
		int Nooftodo=[Ary_Todo count];
		[gratitude_arr removeAllObjects];		
		Fill_ary=[obj_databasemethod fillarray:Nooftodo];			
		NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]init];
		obj_AppDelegate.isStatusAffr=TRUE;
		dictionary=[obj_databasemethod  RandomDataSerching_FromAffirmationTable];	
		Ary_Affirmation=[dictionary objectForKey:@"affirmation"];		
		[dictionary release];		
		int  No=[Ary_Affirmation count];		
		fill_affi_ary=[obj_databasemethod fillarray_affirmation:No];		
		
		NSMutableDictionary *dic_goal=[[NSMutableDictionary alloc]init];
		obj_AppDelegate.isStatus=TRUE;
		dic_goal=[obj_databasemethod  RandomDataSerching_FromGoal];
		Ary_goal=[dic_goal objectForKey:@"goal"];			
		int Noofgoal=[Ary_goal count];			
		fill_goal_ary=[obj_databasemethod fillarray_goal:Noofgoal];
		
		//[dic_goal release];	
		obj_AppDelegate.isStatusGrati=TRUE;
		NSMutableDictionary *a_dic=[[NSMutableDictionary alloc]init];
		a_dic= [obj_databasemethod RandomDataSerching_FromGratitudeTable] ;	
		gratitude_arr = [a_dic valueForKey:@"gratitude"];
		int noG = [gratitude_arr count];
		fill_gra_ary =[obj_databasemethod fillarray_gratitude:noG];	       
	}
	[randomno_ARR1 removeAllObjects];
	[randomno_ARR2 removeAllObjects];
	[randomno_ARR3 removeAllObjects];
	
	
	
	if([Ary_goal count]>2){			
		NSInteger num;
		NSInteger num1;
		for (int i =0; i<2; i++) {
			num= (arc4random() % ([Ary_goal count]-1));
			NSString *s =[NSString stringWithFormat:@"%d",num];
			if([randomno_ARR2 count] ==0){
				[randomno_ARR2 addObject:s];
					NSLog(@"no1  %d",num);
			}
			else {
				
				NSString *str =[randomno_ARR2 objectAtIndex:[randomno_ARR2 count]-1];
				if([s isEqualToString:str]){
						num1= (arc4random() % ([Ary_goal count]-1));
						s =[NSString stringWithFormat:@"%d",num1];
						NSLog(@"no1 & no2 %d %d",num,num1);
						while (num==num1) {
							num1= (arc4random() % ([gratitude_arr count]-1));
							s =[NSString stringWithFormat:@"%d",num1];
						}						
					}
					[randomno_ARR2 addObject:s];							
			}
			
		}
		NSLog(@"random goal arr %@",randomno_ARR2);
		
	}
	else {
		for (int i =0; i<[Ary_goal count]; i++) {			
			[randomno_ARR2 addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}

	if([Ary_Affirmation count]>3){		
		NSInteger num;
		NSInteger num1;
		for (int i =0; i<3; i++) {
			num= (arc4random() % ([Ary_Affirmation count]-1));			
			NSString *s =[NSString stringWithFormat:@"%d",num];
			if([randomno_ARR1 count] ==0){
				NSLog(@"no1  %d",num);
				[randomno_ARR1 addObject:s];
			}
			else if([randomno_ARR1 count] ==1){
				NSString *str =[randomno_ARR1 objectAtIndex:0];
				if([s isEqualToString:str]){	
						num1= (arc4random() % ([Ary_Affirmation count]-1));
						s =[NSString stringWithFormat:@"%d",num1];
						while (num==num1) {
							num1= (arc4random() % ([gratitude_arr count]-1));
							s =[NSString stringWithFormat:@"%d",num1];
						}
					}
					[randomno_ARR1 addObject:s];										
			}
			else {
				NSString *str =[randomno_ARR1 objectAtIndex:0];
				NSString *str1 =[randomno_ARR1 objectAtIndex:1];
				if([s isEqualToString:str]||[s isEqualToString:str1]){	
					num1= (arc4random() % ([Ary_Affirmation count]-1));
					s =[NSString stringWithFormat:@"%d",num1];
					while ([s isEqualToString:str]||[s isEqualToString:str1]) {
						num1= (arc4random() % ([gratitude_arr count]-1));
						s =[NSString stringWithFormat:@"%d",num1];
					}
				}
				[randomno_ARR1 addObject:s];										
			}
			
		}		
	}
	else {
		for (int i =0; i<[Ary_Affirmation count]; i++) {			
			[randomno_ARR1 addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}





	if([gratitude_arr count]>2){
		
		NSInteger num;
		NSInteger num1;

		for (int i =0; i<2; i++) {
			num= (arc4random() % ([gratitude_arr count]-1));
		
			NSString *s =[NSString stringWithFormat:@"%d",num];
			if([randomno_ARR3 count] ==0){
				[randomno_ARR3 addObject:s];
					NSLog(@"no1  %d",num);
			}
			else {
				for(NSString *str in randomno_ARR3){
					if([s isEqualToString:str]){
						num1= (arc4random() % ([gratitude_arr count]-1));
						s =[NSString stringWithFormat:@"%d",num1];
						NSLog(@"no1 & no2 %d %d",num,num1);
						while (num==num1) {
							num1= (arc4random() % ([gratitude_arr count]-1));
							s =[NSString stringWithFormat:@"%d",num1];
						}						
					}	
					[randomno_ARR3 addObject:s];	
					break;
					
					}				
				}
			}
			
		NSLog(@"random gra arr %@",randomno_ARR3);
		
			//[randomno_ARR3 addObject:[NSString stringWithFormat:@"%d",num]];
		
	}
	else {
		for (int i =0; i<[gratitude_arr count]; i++) {			
			[randomno_ARR3 addObject:[NSString stringWithFormat:@"%d",i]];
		}
	}
	
	if(([Ary_Todo count]>1)&&([Ary_goal count]>1)&&([Ary_Affirmation count]>2)&&([gratitude_arr count]))
	{
		self.navigationItem.rightBarButtonItem.enabled=TRUE;
	}
	
	else 
	{
		
		
		self.navigationItem.rightBarButtonItem.enabled=FALSE;
		
	}
	
	[tbl_journal reloadData];
			
}
//------------TEXT FEILD --------------

-(IBAction)btn_date_clicked:(id)sender
{
	calender *obj_calender=[[calender alloc]initWithNibName:@"calender"bundle:nil];
	[obj_calender setParentObj:self];

	
	[self.navigationController pushViewController:obj_calender animated:NO];
	
	[obj_calender setParentObj:self];
}
-(IBAction)btn_EditClicked:(id)sender
{
	Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
//	[self.navigationController pushViewController:obj_home animated:NO];
	//[self.view addSubview:obj_home.view];
//	[self.view removeFromSuperview];
	[self presentModalViewController:obj_home animated:NO];
		
}
-(IBAction)btn_Home_clicked:(id)sender
{
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSLog(@"in section");
	if(section==1){
		if([Ary_Affirmation count]<3){
			return [Ary_Affirmation count]+1;
		}		
		else{			
			return	4;	
		}
		//return [Ary_Affirmation count]+1;
	}
	
	else if(section==0){		
		return [Ary_Todo count]+1;
		
	}	
	else if(section==3){
		if([gratitude_arr count]<2){
			NSLog(@" if grati cell display");			
			return  [gratitude_arr count]+1;			
		}		
		else{
			return  3;
			//NSLog(@" else grati cell display");			
		}
		//return  [gratitude_arr count]+1;
	}
	else if(section==2){
		if([Ary_goal count]<2){
			return [Ary_goal count]+1;			
		}
		else {
			return 3;
		}	
		//return [Ary_goal count]+1;
	
	}

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 4;
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	//--- DidselectRowAtindexpath Method Have Been Call---------------	
	[self tableView:tbl_journal didSelectRowAtIndexPath:indexPath];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0,0, tableView.bounds.size.width, 30)] autorelease];
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width - 10, 25)] autorelease];
    label.text = sectionTitle;

	[label setFont:[UIFont fontWithName:@"Georgia-Bold" size:16]];	
	
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
	// [headerView setBackgroundColor:[UIColor whiteColor]];
    //        [headerView setBackgroundColor:[UIColor clearColor]];
    return headerView;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
{
	if(section==0)
	return @"To do";
	else if(section==1)
	{
			return @"Affirmations";
	}
	else if(section==2)
	{
		return @"Goals";
	}

	else if(section==3)
	{
		return @"Gratitude";
	}
	
	return nil;
	
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
	
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	cell.textLabel.backgroundColor = [UIColor clearColor];
	
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
	static NSString *CellIdentifier = @"Cell";	 
	
  UITableViewCell *Cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
	//if (Cell == nil){		
        Cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    //}
	

	[Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	switch (indexPath.section){
		
		case 3:	{				
				if(indexPath.row == 0){				
					UIImageView *imgviewCell=[[UIImageView alloc]initWithFrame:CGRectMake(265, 04, 30, 30)];
					imgviewCell.image=[UIImage imageNamed:@"Discloserbtn.png"];
					[Cell.contentView addSubview:imgviewCell];
					[Cell setAccessoryView:imgviewCell];
					Cell.textLabel.text=@"click to add";
					Cell.textLabel.frame=CGRectMake(Cell.textLabel.frame.origin.x+100,Cell.textLabel.frame.origin.y+5 , 250, 40);
					Cell.textLabel.font=[UIFont fontWithName:@"Georgia" size:14.0];
					Cell.textLabel.textColor=[UIColor lightGrayColor];
					Cell.detailTextLabel.text=@"";					
				}
				else{	
				int  i =[[randomno_ARR3 objectAtIndex:indexPath.row-1]intValue];
				CGSize stringsize=[[gratitude_arr objectAtIndex:i]sizeWithFont:[UIFont fontWithName:@"Georgia" size:16.0]constrainedToSize:CGSizeMake(320, 500)lineBreakMode:UILineBreakModeWordWrap];
				Cell.textLabel.frame=CGRectMake(Cell.textLabel.frame.origin.x,Cell.textLabel.frame.origin.y , stringsize.width+10, stringsize.height+10);
				Cell.textLabel.text=[gratitude_arr objectAtIndex:i];
				Cell.textLabel.font=[UIFont fontWithName:@"Georgia"size:15.0];
				Cell.textLabel.textColor=[UIColor blackColor];
				Cell.textLabel.numberOfLines=(ceilf(stringsize.height/15));
				Cell.accessoryType=UITableViewCellAccessoryNone;
				//Cell.detailTextLabel.text=[Ary_date objectAtIndex:i];
				Cell.detailTextLabel.font=[UIFont fontWithName:@"Georgia" size:13];				
			}			
			
			break;
			
		}
		
		
		case 0:
		{
			
			
			//if([Ary_Todo count] < 2 )
//			{
				if(indexPath.row == 0){				
										
					UIImageView *imgviewCell=[[UIImageView alloc]initWithFrame:CGRectMake(265, 04, 30, 30)];
					imgviewCell.image=[UIImage imageNamed:@"Discloserbtn.png"];
					[Cell.contentView addSubview:imgviewCell];
					[Cell setAccessoryView:imgviewCell];
					Cell.textLabel.text=@"click to add";
					Cell.textLabel.frame=CGRectMake(Cell.textLabel.frame.origin.x+100,Cell.textLabel.frame.origin.y+5 , 250, 40);
					Cell.textLabel.font=[UIFont fontWithName:@"Georgia" size:14.0];
					Cell.textLabel.textColor=[UIColor lightGrayColor];
					Cell.detailTextLabel.text=@"";
					
																										
				}
				else {					
					
					CGSize stringsize=[[Ary_Todo objectAtIndex:indexPath.row -1]sizeWithFont:[UIFont fontWithName:@"Georgia" size:16.0]constrainedToSize:CGSizeMake(320, 500)lineBreakMode:UILineBreakModeWordWrap];
					Cell.textLabel.frame=CGRectMake(Cell.textLabel.frame.origin.x,Cell.textLabel.frame.origin.y , stringsize.width+10, stringsize.height+10);
					Cell.textLabel.text=[Ary_Todo objectAtIndex:indexPath.row -1];
					Cell.textLabel.font=[UIFont fontWithName:@"Georgia"size:15.0];
					Cell.textLabel.textColor=[UIColor blackColor];
					Cell.textLabel.numberOfLines=(ceilf(stringsize.height/15));
					Cell.accessoryType=UITableViewCellAccessoryNone;
					Cell.detailTextLabel.text=[Ary_date objectAtIndex:indexPath.row -1];
					Cell.detailTextLabel.font=[UIFont fontWithName:@"Georgia" size:13];
					Cell.detailTextLabel.textColor=[UIColor lightGrayColor];
					
			}

			
			break;
		}
			
		case 1:{
			
				if(indexPath.row==0)
				{
					
					Cell.textLabel.text=@"click to add";
										Cell.textLabel.frame=CGRectMake(Cell.textLabel.frame.origin.x+100,Cell.textLabel.frame.origin.y+5 , 250, 40);
										Cell.textLabel.font=[UIFont fontWithName:@"Georgia" size:14.0];
										Cell.textLabel.textColor=[UIColor lightGrayColor];
										Cell.detailTextLabel.text=@"";
										
					[Cell.textLabel setTextAlignment:UITextAlignmentCenter];
					
					
					//
//					textf2=[[UITextField alloc] initWithFrame:CGRectMake(10, 10, 250, 35)];
//					textf2.font=[UIFont fontWithName:@"Arial"size:14.0];
//					textf2.returnKeyType = UIReturnKeyDone;
//					textf2.placeholder=@"click to add";
//					textf2.delegate=self;
//					textf2.textAlignment=UITextAlignmentLeft;
					
					[Cell.contentView addSubview:textf2];
					//Cell.accessoryType =UITableViewCellAccessoryDetailDisclosureButton;
					
					UIImageView *imgviewCell=[[UIImageView alloc]initWithFrame:CGRectMake(265, 04, 30, 30)];
					imgviewCell.image=[UIImage imageNamed:@"Discloserbtn.png"];
					//[Cell.contentView addSubview:imgviewCell];
					
					[Cell setAccessoryView:imgviewCell];
												
				//}
//				if(indexPath.row==1)
//				{
//				
//					int i =[[fill_affi_ary objectAtIndex:indexPath.row-1]intValue];
//					CGSize stringsize=[[Ary_Affirmation objectAtIndex:i]sizeWithFont:[UIFont boldSystemFontOfSize:16.0]constrainedToSize:CGSizeMake(320, 500)lineBreakMode:UILineBreakModeWordWrap];
//					Cell.textLabel.frame=CGRectMake(Cell.textLabel.frame.origin.x,Cell.textLabel.frame.origin.y , stringsize.width+5, stringsize.height+5);
//					Cell.textLabel.text=[Ary_Affirmation objectAtIndex:i];
//					Cell.textLabel.font=[UIFont fontWithName:@"Arial"size:14.0];
//					Cell.accessoryType=UITableViewCellAccessoryNone;
//					Cell.textLabel.numberOfLines=(ceilf(stringsize.height/15));
//					Cell.textLabel.textColor=[UIColor blackColor];
//					Cell.detailTextLabel.text=@"";
//				}
//				
//				if(indexPath.row==2)
//				{
//					
//					int i =[[fill_affi_ary objectAtIndex:indexPath.row-1]intValue];
//					CGSize stringsize=[[Ary_Affirmation objectAtIndex:i]sizeWithFont:[UIFont boldSystemFontOfSize:16.0]constrainedToSize:CGSizeMake(320, 500)lineBreakMode:UILineBreakModeWordWrap];
//					Cell.textLabel.frame=CGRectMake(Cell.textLabel.frame.origin.x,Cell.textLabel.frame.origin.y , stringsize.width+5, stringsize.height+5);
//					Cell.textLabel.text=[Ary_Affirmation objectAtIndex:i];
//					Cell.textLabel.font=[UIFont fontWithName:@"Arial"size:14.0];
//					Cell.accessoryType=UITableViewCellAccessoryNone;
//					Cell.textLabel.numberOfLines=(ceilf(stringsize.height/15));
//					Cell.textLabel.textColor=[UIColor blackColor];
//					Cell.detailTextLabel.text=@"";
//				}
			}
			else 
			{
				
				//NSLog(@" object %d \n, indexpath %@ \n",num1,indexPath);
				int  i =[[randomno_ARR1 objectAtIndex:indexPath.row-1]intValue];
				CGSize stringsize=[[Ary_Affirmation objectAtIndex:i]sizeWithFont:[UIFont fontWithName:@"Georgia" size:16.0]constrainedToSize:CGSizeMake(320, 500)lineBreakMode:UILineBreakModeWordWrap];
				Cell.textLabel.text=[Ary_Affirmation objectAtIndex:i];
				Cell.textLabel.frame=CGRectMake(Cell.textLabel.frame.origin.x,Cell.textLabel.frame.origin.y , stringsize.width+10, stringsize.height+10);

				Cell.textLabel.font=[UIFont fontWithName:@"Georgia"size:14.0];
				Cell.accessoryType=UITableViewCellAccessoryNone;
				Cell.textLabel.numberOfLines=(ceilf(stringsize.height/15));
				Cell.textLabel.textColor=[UIColor blackColor];
				Cell.detailTextLabel.text=@"";
				
			}

			break;
		}
			
		case 2:
		{
			//if([Ary_goal count]<2)
//			{
				if(indexPath.row==0){					
					
					UIImageView *imgviewCell=[[UIImageView alloc]initWithFrame:CGRectMake(265, 04, 30, 30)];
					imgviewCell.image=[UIImage imageNamed:@"Discloserbtn.png"];
				//	[Cell.contentView addSubview:imgviewCell];
					[Cell setAccessoryView:imgviewCell];
					
					Cell.textLabel.text=@"click to add";
					Cell.textLabel.textColor=[UIColor lightGrayColor];
					Cell.textLabel.font=[UIFont fontWithName:@"Georgia"size:14.0];
					Cell.detailTextLabel.text=@"";
				}
						
			else
			{
				
				int  i =[[randomno_ARR2 objectAtIndex:indexPath.row-1]intValue];
				CGSize stringsize=[[Ary_goal objectAtIndex:i]sizeWithFont:[UIFont fontWithName:@"Georgia" size:16.0]constrainedToSize:CGSizeMake(320, 500)lineBreakMode:UILineBreakModeWordWrap];
				Cell.textLabel.text=[Ary_goal objectAtIndex:i];
				Cell.textLabel.frame=CGRectMake(Cell.textLabel.frame.origin.x,Cell.textLabel.frame.origin.y , stringsize.width+10, stringsize.height+10);

				Cell.textLabel.font=[UIFont fontWithName:@"Georgia"size:14.0];
				Cell.textLabel.textColor=[UIColor blackColor];
				Cell.textLabel.numberOfLines=(ceilf(stringsize.height/15.0));
				Cell.accessoryType=UITableViewCellAccessoryNone;
				Cell.detailTextLabel.text=@"";
				
			}
				break;	
		}
			
			
			
			
			

	}
	
			return Cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{

	
	switch (indexPath.section) 
	{
		case 0:
		{
			
			//if([Ary_Todo count]<2)
//			{
				if(indexPath.row==0)
				{
					
					if(obj_todo){
						obj_todo =nil;
						[obj_todo release];
					
					}
					obj_todo=[[todolist alloc]initWithNibName:@"todolist" bundle:nil ];
					[self.navigationController pushViewController:obj_todo animated:YES];
					
				}
				
			//}
				break;
			
		}
		case 1:
		{
			//if([Ary_Affirmation  count]<3)
//			{
				if(indexPath.row==0)
				{
					Affirmation *obj_aff=[[Affirmation alloc]initWithNibName:@"Affirmation" bundle:nil];
					
					[self.navigationController pushViewController:obj_aff animated:YES];
				}
			//}
			
			break;
		}
		
		case 2:	{
			if(indexPath.row==0){
					Goal *obj_goal=[[Goal alloc]initWithNibName:@"Goal" bundle:nil];
					obj_goal.isPush=TRUE;
					
					[self.navigationController pushViewController:obj_goal animated:YES];
					
				}
		
			break; 
			
		}
		case 3:{			
				if(indexPath.row==0){
					Gratitude *obj_gratitude=[[Gratitude alloc]initWithNibName:@"Gratitude" bundle:nil];
					obj_gratitude.isPush=TRUE;
					[self.navigationController pushViewController:obj_gratitude animated:YES];					
				}
		break;	
			
		}	
	}

	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	switch (indexPath.section)
	{
		
		case 3:
		{				
			if(indexPath.row==0)
			{
				return 40;
				
			}
			else 
			{
				int  i =[[randomno_ARR3 objectAtIndex:indexPath.row-1]intValue];
				RandomTodo	=[[gratitude_arr objectAtIndex:indexPath.row-1] intValue];
				CGSize stringSize = [[gratitude_arr objectAtIndex:i] sizeWithFont:[UIFont fontWithName:@"Georgia" size:16.0] constrainedToSize:CGSizeMake(320, 500) lineBreakMode:UILineBreakModeWordWrap];
				return MAX(stringSize.height+25,40);
			}
			
			
			break;
		}
		
		case 0:
		{
				
			//	if([Fill_ary count]<2)
//				{
					
						if(indexPath.row==0)
						{
							return 40;
							
						}
						//if(indexPath.row==1)
//						{
//							
//							RandomTodo	=[[Fill_ary objectAtIndex:indexPath.row-1] intValue];
//							CGSize stringSize = [[Ary_Todo objectAtIndex:RandomTodo] sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:CGSizeMake(320, 500) lineBreakMode:UILineBreakModeWordWrap];
//							return MAX(stringSize.height+25,40);
//							
//						}
//				}
				else 
				{
					
					RandomTodo	=[[Ary_Todo objectAtIndex:indexPath.row-1] intValue];
					CGSize stringSize = [[Ary_Todo objectAtIndex:indexPath.row-1] sizeWithFont:[UIFont fontWithName:@"Georgia" size:16.0] constrainedToSize:CGSizeMake(320, 500) lineBreakMode:UILineBreakModeWordWrap];
					return MAX(stringSize.height+25,40);
				}
			
				break;
		}
		case 1:
		{
				//if([fill_affi_ary count]<3)
//				{
					if(indexPath.row==0)
					{
						return 40;
					}
					//if(indexPath.row==1)
//					{
//						RandomAffir=[[fill_affi_ary objectAtIndex:indexPath.row-1]intValue];
//						CGSize stringSize = [[Ary_Affirmation objectAtIndex:RandomAffir] sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:CGSizeMake(320, 500) lineBreakMode:UILineBreakModeWordWrap];		
//						return MAX(stringSize.height+10,40);	
//						
//					}
//					if(indexPath.row==2)
//					{
//						RandomAffir=[[fill_affi_ary objectAtIndex:indexPath.row-1]intValue];
//						CGSize stringSize = [[Ary_Affirmation objectAtIndex:RandomAffir] sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:CGSizeMake(320, 500) lineBreakMode:UILineBreakModeWordWrap];		
//						return MAX(stringSize.height+10,40);	
//						
//					}
//				}
				else 
				{
					int  i =[[randomno_ARR1 objectAtIndex:indexPath.row-1]intValue];
					RandomAffir=[[Ary_Affirmation objectAtIndex:indexPath.row-1]intValue];
					CGSize stringSize = [[Ary_Affirmation objectAtIndex:i] sizeWithFont:[UIFont fontWithName:@"Georgia" size:16.0] constrainedToSize:CGSizeMake(320, 500) lineBreakMode:UILineBreakModeWordWrap];		
					return MAX(stringSize.height+10,40);		
				}
				break;
	
		}
			case 2:
			{
			
				//if([fill_goal_ary count]<2)
//				{
					if(indexPath.row==0)
					{
						return 40;
					}
					//if(indexPath.row==1)
//					{
//						RandomGoal=[[fill_goal_ary objectAtIndex:indexPath.row-1]intValue];
//						CGSize stringSize = [[Ary_goal objectAtIndex:RandomGoal] sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:CGSizeMake(320, 500) lineBreakMode:UILineBreakModeWordWrap];		
//						return MAX(stringSize.height+10,40);	
//						
//					}
//				}
				else 
				{
					int  i =[[randomno_ARR2 objectAtIndex:indexPath.row-1]intValue];
					RandomGoal=[[Ary_goal objectAtIndex:indexPath.row-1]intValue];
					CGSize stringSize = [[Ary_goal objectAtIndex:i] sizeWithFont:[UIFont fontWithName:@"Georgia" size:16.0] constrainedToSize:CGSizeMake(320, 500) lineBreakMode:UILineBreakModeWordWrap];		
					return MAX(stringSize.height+10,40);		
				}
				
				
					break;
			}

	}
	

	return 0;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if([textField isEqual:textf2])
	{
		tbl_journal.frame=CGRectMake(0, -60, 320, 460);

	}
	else if([textField isEqual:textf3])
	{
		tbl_journal.frame=CGRectMake(0, -80, 320, 460);

	}
	else if([textField isEqual:textf4])
	{
		tbl_journal.frame=CGRectMake(0, -125, 320, 460);
		
	}
	
	return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	NSDate *today = [NSDate date];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"dd-MMM-yyyy"];
	NSString *dateString = [dateFormat stringFromDate:today];
	
	if([textField isEqual:textf1])
	{
		if(![textf1.text isEqualToString:@""])
		{
			[obj_databasemethod insertdata_todotask:textf1.text remeinderdate:dateString];
		}
		else 
		{
			UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Alert !!!" message:@"Please Enter the Record" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
			[alert1 show];
			[alert1 release];
			
		}
		
	}
	else if([textField isEqual:textf2])
	{
		
		if(![textf2.text isEqualToString:@""])
		{
			[obj_databasemethod  insertdata_Affirmation:textf2.text Date:dateString];
		}
		else 
		{
			UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Alert !!!" message:@"Please Enter the Record" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
			[alert1 show];
			[alert1 release];
			
		}
		
		tbl_journal.frame=CGRectMake(0, 46, 320, 460);

	}
	
	else if([textField isEqual:textf3])
	{
		if(![textf3.text isEqualToString:@""])
		{
			[obj_databasemethod insertdata_Goal:textf3.text Date:dateString];

		}
		else 
		{
			UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Alert !!!" message:@"Please Enter the Record" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
			[alert1 show];
			[alert1 release];
			
		}
		
		tbl_journal.frame=CGRectMake(0, 46, 320, 460);	
	}
	else 
	{
		if(![textf4.text isEqualToString:@""])
		{
			[obj_databasemethod insertdata:textf4.text Date:dateString];

			
		}
		else 
		{
			UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Alert !!!" message:@"Please Enter the Record" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
			[alert1 show];
			[alert1 release];
			
		}
		
		tbl_journal.frame=CGRectMake(0, 46, 320, 460);	
		
	}


	
	[textField resignFirstResponder];
	[self viewWillAppear:YES];
	return YES;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
	
		
	//CGRect textFieldRect =[self.view.window convertRect:textView.bounds fromView:textView];
//	CGRect viewRect =[self.view.window convertRect:self.view.bounds fromView:self.view];
//	
//	CGFloat midline = textFieldRect.origin.y +0.5 * textFieldRect.size.height;
//	CGFloat numerator =midline - viewRect.origin.y- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
//	CGFloat denominator =(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)* viewRect.size.height;
//	CGFloat heightFraction = numerator / denominator;
//	
//	animatedDistance = floor(162.0 * heightFraction);
//	
//	CGRect viewFrame = self.view.frame;
//	
//	viewFrame.origin.y -= animatedDistance;
//	
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationBeginsFromCurrentState:YES];
//	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
//	
//	[self.view setFrame:viewFrame];
//	
//	[UIView commitAnimations];
//	
//	
	

	tbl_journal.frame=CGRectMake(0, -202, 320, 460);
	
	txtview_footer.frame=CGRectMake(07, 11, 300,110);
	txtview_footer.layer.cornerRadius=5.0;
	footerview.frame=CGRectMake(05, 02, 300,130);
	[footerview addSubview:txtview_footer];

	[self.tbl_journal setTableFooterView:footerview];
	
	

		[tbl_journal reloadData];

	return YES;
	
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
		
	CGSize stringsize=[txtview_footer.text sizeWithFont:[UIFont fontWithName:@"Georgia" size:17.0]constrainedToSize:CGSizeMake(300,380)lineBreakMode:UILineBreakModeWordWrap];
	
	

	//int arang=125-h;
	if(stringsize.height<txtview_footer.frame.size.height)
	{
		txtview_footer.frame=CGRectMake(07, 11, 300,110);
		txtview_footer.layer.cornerRadius=5.0;
		footerview.frame=CGRectMake(05, 02, 300,130);
		[footerview addSubview:txtview_footer];
		[self.tbl_journal setTableFooterView:footerview];	
	}

	
	if ( [text isEqualToString: @"\n"] ) 
	{
		
		[textView resignFirstResponder];

		tbl_journal.frame=CGRectMake(0, 44, 320, 460);
		tbl_journal.opaque=YES;
		tbl_journal.scrollEnabled=YES;
		tbl_journal.minimumZoomScale=YES;
		[tbl_journal reloadData];
		
		
		return YES;
	}
	[tbl_journal reloadData];
		
	return YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView;
{
		
	
	CGSize stringsize=[txtview_footer.text sizeWithFont:[UIFont fontWithName:@"Georgia" size:17.0]constrainedToSize:CGSizeMake(300,380)lineBreakMode:UILineBreakModeWordWrap];
	
	CGFloat hite=MAX(stringsize.width,300);
	
	if(stringsize.height<txtview_footer.frame.size.height)
	{
		txtview_footer.frame=CGRectMake(07, 11, 300,110);
		txtview_footer.layer.cornerRadius=5.0;
		footerview.frame=CGRectMake(05, 02, 300,130);
		[footerview addSubview:txtview_footer];
		[self.tbl_journal setTableFooterView:footerview];	
	}
	else 
	{
		footerview.frame=CGRectMake(txtview_footer.frame.origin.x,txtview_footer.frame.origin.y , stringsize.width, stringsize.height+25);
		txtview_footer.frame=CGRectMake(txtview_footer.frame.origin.x,txtview_footer.frame.origin.y+1 , hite, stringsize.height );
		tbl_journal.contentSize=CGSizeMake(320, 420+txtview_footer.frame.size.height);

		tbl_journal.frame=CGRectMake(0, 44, 320, 460);
		
		flage=FALSE;
		
		[tbl_journal reloadData];
		
	}

	
	}


- (void)didReceiveMemoryWarning {
	    [super didReceiveMemoryWarning];
	
	}

- (void)viewDidUnload 
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	//[Ary_goal release];
	//[Ary_Todo release];
	//[Ary_Affirmation release];
	//[Ary_Quoates release];
	[Fill_ary release];
	[fill_goal_ary release];
	[fill_affi_ary release];
	[txtview_footer release];
	[footerview release];
	[headerview release];
	//[tbl_journal release];
	
	
}

@end
