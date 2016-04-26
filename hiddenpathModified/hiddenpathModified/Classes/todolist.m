//
//  todolist.m
//  TABBAR
//
//  Created by openxcell technolabs on 6/20/11.
//  Copyright 2011 jn. All rights reserved.
//

#import "todolist.h"
#import "Homepage.h"
#import "String.h"
#import <QuartzCore/QuartzCore.h>
@implementation todolist
@synthesize tbl_todolist,Ary_title,txtview_footer,Ary_date,flag,rowheight,nvg_bar,show_nvgbar;
@synthesize isPush,dtbtnselec,alermDic;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	bagcounter=0;
	
	[super viewDidLoad];
	show_detailcell=FALSE;
		
		
	//self.navigationController.navigationBar.hidden = FALSE;
	
	self.title=@"To do List";
	obj_AppDelegate=(TABBARAppDelegate *)[[UIApplication sharedApplication]delegate];
	obj_databasemethod=[[DatabaseMethod alloc]init];
	flag=FALSE;
	Ary_date=[[NSMutableArray alloc]init];
	Ary_title=[[NSMutableArray alloc]init];
	ary_id=[[NSMutableArray alloc]init];
	statusAry=[[NSMutableArray alloc]init];

	alermDic = [[NSMutableDictionary alloc] init];
	
	if (obj_AppDelegate.fromHome) {
		NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]init];
		
		dictionary=[obj_databasemethod  RandomDataSerching_FromToDotask:obj_AppDelegate.insertdatecal];
		
		Ary_title=[dictionary objectForKey:@"todotask"];
		Ary_date=[dictionary objectForKey:@"remainder"];
		statusAry = [dictionary objectForKey:@"status"];
		NSLog(@"Remainder Counter is :- %d",[Ary_date count]);
		self.navigationItem.rightBarButtonItem = self.editButtonItem;
		[super setEditing:NO animated:YES];
		
		if([Ary_title count]>0)
		{
			self.navigationItem.rightBarButtonItem = self.editButtonItem;
			
			[super setEditing:NO animated:YES];
			
		}
		else
		{
			self.navigationItem.rightBarButtonItem=nil;	
			//self.navigationItem.rightBarButtonItem.enabled=YES;
			
		}
		
		if(!isPush)
		{
			self.navigationItem.rightBarButtonItem.enabled=YES;
			[super setEditing:NO animated:YES];
			//home_btn=[[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonSystemItemFastForward  target:self action:@selector(btn_EditClicked_home:)];
			//self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonSystemItemFastForward  target:self action:@selector(btn_EditClicked_home:)];
		}
		else 
		{
			
			self.navigationItem.leftBarButtonItem=nil;	
			self.navigationItem.rightBarButtonItem.enabled=YES;
		}
		
		if ([Ary_title count]>0) {
				for (int h=0; h<[Ary_title count]; h++) {
					NSString *Rem;
					Rem = [obj_databasemethod GetRemindar:[Ary_title objectAtIndex:h]];
					[alermDic setObject:Rem forKey:[Ary_title objectAtIndex:h]];
				}
			}
			
			NSLog(@"%@",alermDic);
		
		[tbl_todolist reloadData];
		
	}
	
	//self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButttonckicked:)];
	
	tbl_todolist.backgroundColor=[UIColor clearColor];
//	[NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(RemainderDate:) userInfo:nil repeats:YES];

	
	if(show_nvgbar)
	{
		nvg_bar.hidden=YES;
		
	}
	else {
		[self viewWillAppear:YES];
	}

	
}

-(IBAction)Barbtn_Edit_clicked:(id)sender{
	if(self.editing){
		
		[super setEditing:NO animated:NO];
		[tbl_todolist setEditing:NO animated:NO];
		[tbl_todolist reloadData];
		[barbtn_edit setTitle:@"Edit"];
		[barbtn_edit setStyle:UIBarButtonItemStylePlain];
	}
	
	else {
		
		[super setEditing:YES animated:YES];
		[tbl_todolist setEditing:YES animated:YES];
		[tbl_todolist reloadData];
		[barbtn_edit setTitle:@"Done"];
		[barbtn_edit setStyle:UIBarButtonItemStyleDone];
		
		self.editing = TRUE; 	
		
	}
}



-(void)viewWillAppear:(BOOL)animated {
	
	NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]init];
	
	dictionary=[obj_databasemethod  RandomDataSerching_FromToDotask:obj_AppDelegate.insertdatecal];
	
	Ary_title=[dictionary objectForKey:@"todotask"];
	Ary_date=[dictionary objectForKey:@"remainder"];
	statusAry = [dictionary objectForKey:@"status"];
	NSLog(@"Remainder Counter is :- %d",[Ary_date count]);
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	if([Ary_title count]>0)	{
		self.navigationItem.rightBarButtonItem = self.editButtonItem;
		
		[super setEditing:NO animated:YES];
		
	}
	else {
		self.navigationItem.rightBarButtonItem=nil;	
		//self.navigationItem.rightBarButtonItem.enabled=YES;
		
	}
	
	if(!isPush)	{
		self.navigationItem.rightBarButtonItem.enabled=YES;
		[super setEditing:NO animated:YES];
		//home_btn=[[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonSystemItemFastForward  target:self action:@selector(btn_EditClicked_home:)];
		//self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonSystemItemFastForward  target:self action:@selector(btn_EditClicked_home:)];
	}
	else {
		
		self.navigationItem.leftBarButtonItem=nil;	
		self.navigationItem.rightBarButtonItem.enabled=YES;
	}
	
	if ([Ary_title count]>0) {
		for (int h=0; h<[Ary_title count]; h++) {
			NSString *Rem;
			Rem = [obj_databasemethod GetRemindar:[Ary_title objectAtIndex:h]];
			[alermDic setObject:Rem forKey:[Ary_title objectAtIndex:h]];
		}
	}
	
	NSLog(@"%@",alermDic);
	
	[tbl_todolist reloadData];
}


- (void)scheduleNotification:(NSString *)str2
{
   // 
//    UILabel *lbl=[[UILabel alloc]init];
//    lbl.text=@"Match will be Start now  ";
    
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    Class cls = NSClassFromString(@"UILocalNotification");
    if (cls != nil) {
        
        UILocalNotification *notif = [[cls alloc] init];
        notif.fireDate = [dt_picker date];
        notif.timeZone = [NSTimeZone defaultTimeZone];
        
        notif.alertBody = str2;
        notif.alertAction = @"Show me";
        notif.soundName = UILocalNotificationDefaultSoundName;
        notif.applicationIconBadgeNumber = bagcounter++;
        
        NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"TodoTask is"
                                                             forKey:@"matchDateandTime"];
        notif.userInfo = userDict;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        [notif release];
        
    }
}





-(IBAction)RemainderDate:(id)sender
{
	today=[[NSDate alloc]init];
	today=[NSDate date];
	NSLog(@"date %@",today);
	
		
		NSDateFormatter *df=[[NSDateFormatter alloc]init];		
		[df setDateFormat:@"MMM/dd/yyyy hh:mma"];
		NSString *R_date=[df stringFromDate:today];
	
		
		
		
	for(int k =0; k<[Ary_date count];k++)
	{
		NSString *temp=[Ary_date objectAtIndex:k];
		NSLog(@"temp is %@",temp);
		NSLog(@"R_date is :- %@",R_date);

		
		if([temp isEqualToString:R_date])
		{
			
			
			UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"Hidden Path Alert" message:[Ary_title objectAtIndex:k]delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
			[Alert show];
			[Alert release];
			
		}
	}
	
	
}


-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	[super setEditing:editing animated:YES];
	
	[tbl_todolist setEditing:editing animated:YES];
	

	if (self.editing) 
	{
		self.navigationItem.leftBarButtonItem.enabled = NO;
	//	imgviewCell.hidden=YES;
		textf1.userInteractionEnabled=FALSE;
	} 
	else 
	{
	     self.navigationItem.leftBarButtonItem.enabled = YES;
	//	imgviewCell.hidden=NO;
		textf1.userInteractionEnabled=TRUE;
	}
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
	[tbl_todolist scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
	if ( [text isEqualToString: @"\n"] ) 
	{
		[textView resignFirstResponder];
		return NO;
	}
	return YES;
}
-(IBAction)btn_EditClicked:(id)sender
{//
//	AddTodolist *obj_addtolist=[[AddTodolist alloc]initWithNibName:@"AddTodolist" bundle:nil];
//	[self.navigationController pushViewController:obj_addtolist animated:YES];
//		
//	[obj_addtolist setParentObj:self];
}
///--------->>>>>>>>>>>>>CELL------->>>>>>>>>>>>>>>>>>>>>>>>

-(IBAction)btn_EditClicked_home:(id)sender
{
	//Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
	obj_AppDelegate.fromHome = FALSE;
	[self.view removeFromSuperview];
	
	//[self presentModalViewController:obj_home animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if([Ary_title count]==0)
	{
		return 1;
		
	}
	else 
	{
		return[Ary_title count]+1;
		
	}

		
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
	//if (indexPath.row<[Ary_title count]) 
	if(indexPath.row==0)
	{
		return 40;
		
	}
	else 
	{
		
		stringsize = [[Ary_title objectAtIndex:indexPath.row-1] sizeWithFont:[UIFont fontWithName:@"Georgia" size:15.0] constrainedToSize:CGSizeMake(250, 500) lineBreakMode:UILineBreakModeWordWrap];
		str=[[Ary_date objectAtIndex:indexPath.row-1]sizeWithFont:[UIFont fontWithName:@"Georgia"size:15.0]constrainedToSize:CGSizeMake(250, 500) lineBreakMode:UILineBreakModeWordWrap];
		NSString *remainde=[Ary_date objectAtIndex:indexPath.row-1];
		if([remainde isEqualToString:@""] || [remainde isEqualToString:NULL])
		{
			return MAX(stringsize.height+5,40);
		}
		else
		{
			return MAX(stringsize.height+30,40);
		}
		
		
	}
} 
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	[self tableView:tbl_todolist didSelectRowAtIndexPath:indexPath];
	
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tbl_todolist dequeueReusableCellWithIdentifier:CellIdentifier ];
    //if (cell == nil) 
//	{
        cell = [[UITableViewCell alloc] 
				 initWithStyle:UITableViewCellStyleSubtitle
				reuseIdentifier:nil];
		
		[cell autorelease];
	lbl_cellone=[[UILabel alloc]init];
	lbl_celldate=[[UILabel alloc]init];
	main_lbl=[[UILabel alloc]init];
	
	
	btn_set=[UIButton buttonWithType:UIButtonTypeCustom];
	[btn_set setImage:[UIImage imageNamed:@"clock_alarm.png"]forState:UIControlStateNormal];
	btn_set.tag=indexPath.row-1;
	[btn_set addTarget:self action:@selector(btn_setAlerClicked:)forControlEvents:UIControlEventTouchUpInside];
	
	
	
   // }    	  	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
		
	if(indexPath.row==0)
	{
		
		imgviewCell=[[UIImageView alloc]initWithFrame:CGRectMake(265, 04, 30, 30)];
		imgviewCell.image=[UIImage imageNamed:@"Discloserbtn.png"];
		[cell setAccessoryView:imgviewCell];
		
		
		textf1=[[UITextField alloc] initWithFrame:CGRectMake(10, 10, 250, 35)];
		textf1.font=[UIFont fontWithName:@"Georgia"size:14.0];
		textf1.returnKeyType = UIReturnKeyDone;
		textf1.placeholder=@"click to add";
		textf1.delegate=self;
		textf1.textAlignment=UITextAlignmentLeft;
		
		[cell.contentView addSubview:textf1];	
		[cell setAccessoryView:imgviewCell];
		
				
	}
	
	else	
	{
		
		stringsize=[[Ary_title objectAtIndex:indexPath.row-1]sizeWithFont:[UIFont fontWithName:@"Georgia"size:15.0]constrainedToSize:CGSizeMake(250,500)lineBreakMode:UILineBreakModeWordWrap];
		
		lbl_cellone.frame=CGRectMake(35, 02, 250, stringsize.height-3);
		lbl_cellone.text=[Ary_title objectAtIndex:indexPath.row-1];
		lbl_cellone.textColor=[UIColor blackColor];
		lbl_cellone.font=[UIFont fontWithName:@"Georgia"size:15.0];
		lbl_cellone.backgroundColor=[UIColor clearColor];
		lbl_cellone.numberOfLines=99;
		
		CGRect frm = lbl_cellone.frame;
		frm.origin.y = frm.size.height+5;
		frm.size.height = 20;
		lbl_celldate.frame = frm;
		lbl_celldate.text=[Ary_date objectAtIndex:indexPath.row-1];
		lbl_celldate.backgroundColor = [UIColor clearColor];
		lbl_celldate.font=[UIFont fontWithName:@"Georgia"size:12.0];
		lbl_celldate.textColor = [UIColor blueColor];
		
		frm =btn_set.frame;
		btn_set.frame= frm;
		CGFloat mid=lbl_cellone.frame.size.height/2;
		[btn_set setFrame:CGRectMake(02, mid, 30, 30)];
		
		NSDate *dt = [NSDate date];
		
		NSLog(@"%@",dt);
		
		NSDateFormatter *df=[[NSDateFormatter alloc]init];
		
		[df setDateFormat:@"MMM/dd/yyyy hh:mma"];
		//NSString *TodayDt = [[df stringFromDate:dt] retain];
		
		NSLog(@"%@",[alermDic objectForKey:lbl_cellone.text]);
		
		NSDate* firstDate = dt;
        NSDate* secondDate = [df dateFromString:[alermDic objectForKey:lbl_cellone.text]];
        
		NSLog(@"%@",firstDate);
		NSLog(@"%@",secondDate);
		
        NSTimeInterval timeDifference1 = [secondDate timeIntervalSinceDate:firstDate];
		NSLog(@"%d",timeDifference1);
		
		
		
			
		UILabel *alarmTime = [[UILabel alloc] initWithFrame:CGRectMake(130, 25, 150, 15)];
		
		alarmTime.backgroundColor = [UIColor clearColor];
		alarmTime.text = [alermDic objectForKey:lbl_cellone.text];
		alarmTime.textColor = [UIColor blackColor];
		alarmTime.font=[UIFont fontWithName:@"Georgia"size:12.0];			
			
			
					
		
		//if (![[alermDic objectForKey:lbl_cellone.text] isEqualToString:@""]) {
			
		//}
		if (timeDifference1 < 0) {
			alarmTime.textColor = [UIColor redColor];
			lbl_cellone.textColor = [UIColor redColor];
			lbl_celldate.textColor = [UIColor redColor];
		}
		if([alarmTime.text isEqualToString:@"No Remainder"]){
			alarmTime.hidden =TRUE;
		}
		
		[cell.contentView addSubview:alarmTime];
		[cell.contentView addSubview:lbl_cellone];
		[cell.contentView addSubview:lbl_celldate];
		[cell.contentView addSubview:btn_set];

		
        if([[statusAry objectAtIndex:indexPath.row-1]isEqualToString:@"Yes"])
		{
			cell.accessoryType=UITableViewCellAccessoryCheckmark;
		}
		
		else 
		{
			cell.accessoryType=UITableViewCellAccessoryNone;
			
		}
		
		
		
	}
	
	
				
	/*	
		if([[Ary_date objectAtIndex:indexPath.row-1] isEqualToString:@""]||[Ary_date objectAtIndex:indexPath.row-1]==NULL)
		{
			 stringsize=[[Ary_title objectAtIndex:indexPath.row-1]sizeWithFont:[UIFont fontWithName:@"Arial"size:15.0]constrainedToSize:CGSizeMake(320, 500)lineBreakMode:UILineBreakModeWordWrap];
			[lbl_cellone setFrame:CGRectMake(05, 02, 280, stringsize.height)];
			lbl_cellone.text=[Ary_title objectAtIndex:indexPath.row-1];
			lbl_cellone.font=[UIFont fontWithName:@"Arial" size:15.0];
			lbl_cellone.backgroundColor=[UIColor clearColor];
			lbl_cellone.numberOfLines=99;
			[cell.contentView addSubview:lbl_cellone];
			
		}
		else 
		{
			stringsize=[[Ary_title objectAtIndex:indexPath.row-1]sizeWithFont:[UIFont fontWithName:@"Arial"size:15.0]constrainedToSize:CGSizeMake(280, 500)lineBreakMode:UILineBreakModeWordWrap];
			NSLog(@"cell String Values is ;-%f",stringsize.height);
			[main_lbl setFrame:CGRectMake(05, 0, 280, stringsize.height)];
			main_lbl.text=[Ary_title objectAtIndex:indexPath.row-1];
			main_lbl.font=[UIFont fontWithName:@"Arial" size:15.0];
			main_lbl.backgroundColor=[UIColor clearColor];
			main_lbl.numberOfLines=99;
			[cell.contentView addSubview:main_lbl];

			
			CGFloat heite=stringsize.height;
			[lbl_cell setFrame:CGRectMake(05,heite+2, 200, 15)];
			lbl_cell.text=[Ary_date objectAtIndex:indexPath.row-1];
			lbl_cell.backgroundColor=[UIColor clearColor];
			lbl_cell.textColor=[UIColor blueColor];
			lbl_cell.font=[UIFont fontWithName:@"Arial"size:13];
			[cell.contentView addSubview:lbl_cell];
					
		}

				
	}
		
	 */

			return cell;
						   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	
		//if(indexPath.row==0&&[statusAry count]==0)
//		//	{
//		//	}
//		//	else if([[statusAry objectAtIndex:indexPath.row-1]isEqualToString:@"Yes"])
//		//	{
//		//		[statusAry replaceObjectAtIndex:indexPath.row-1 withObject:@"No"];
//		//	}
//		//	else {
//		//		[statusAry replaceObjectAtIndex:indexPath.row-1 withObject:@"Yes"];
//		//	}
		
		[textf1 becomeFirstResponder];
		
		if(indexPath.row > 0)
		{
			NSString *str_update=[Ary_title objectAtIndex:indexPath.row-1];
			
			NSString *str_bool=[statusAry objectAtIndex:indexPath.row-1];
			
			[obj_databasemethod updateToDocell:str_update update:str_bool];
			
			NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]init];
			dictionary=[obj_databasemethod RandomDataSerching_FromToDotask:obj_AppDelegate.insertdatecal];
			
			Ary_title=[dictionary objectForKey:@"todotask"];
			statusAry=[dictionary objectForKey:@"status"];
			
		}
		
	[tbl_todolist reloadData];

	
	//flag=TRUE;
	
	//if(indexPath.row==0)	
//	{
//	DetailTodolist *obj_detailtodolist=[[DetailTodolist alloc]initWithNibName:@"DetailTodolist" bundle:nil];
//	[self.navigationController pushViewController:obj_detailtodolist animated:YES];
//	[obj_detailtodolist setParentObj:self];
//	}
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);
{
	return @"Delete";
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
	
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	cell.textLabel.backgroundColor = [UIColor clearColor];
	
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
		if (editingStyle == UITableViewCellEditingStyleDelete) 
		{

			if(indexPath.row==0)
			{
				self.navigationItem.rightBarButtonItem.enabled=NO;
				self.navigationItem.rightBarButtonItem=nil;
			}
			i=indexPath.row-1;
			NSString *str_ary_dele=[Ary_title objectAtIndex:indexPath.row-1];
			
			[obj_databasemethod  DeleteDataFromTodoList:str_ary_dele];

			[Ary_title removeObjectAtIndex:indexPath.row-1];
			[Ary_date removeObjectAtIndex:indexPath.row-1];
			

			if([Ary_title count]>0)
			{
				self.navigationItem.rightBarButtonItem = self.editButtonItem;
				[super setEditing:NO animated:YES];
				
			}
			else
			{
				self.navigationItem.rightBarButtonItem=nil;	
				self.navigationItem.leftBarButtonItem.enabled = YES;
				tbl_todolist.editing=NO;
				
				
			}
			
		
		}

		
	[tbl_todolist reloadData];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
{
		
	if(indexPath.row==0)
	{
		return UITableViewCellEditingStyleNone;
	}
	
	if (self.editing && indexPath.row == ([Ary_title count]))
    {
				
		return UITableViewCellEditingStyleDelete;
	}
		

	else
	{
				
		return UITableViewCellEditingStyleDelete;

	}
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

		return @"To Do Lists";
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0,0, tableView.bounds.size.width, 30)] autorelease];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width - 10, 25)] autorelease];
    label.text = sectionTitle;
	[label setFont:[UIFont fontWithName:@"Georgia-Bold" size:20]];
	
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
	
    
	
	// [headerView setBackgroundColor:[UIColor whiteColor]];
    //        [headerView setBackgroundColor:[UIColor clearColor]];
    return headerView;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	NSDate *today1=[NSDate date];
	
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	
	[df setDateFormat:@"dd MMM, yyyy"];
	NSString *todaystring =[[df stringFromDate:today1]retain];
	
	
	
	
	if([textf1.text isEqualToString:@""])
	{
	UIAlertView 	*alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Enter the Text is  there"delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 10.0);
		[alert setTransform:myTransform];
		[alert show];
		[alert release];
	}
	
	else 
	{
		
		//NSString *caldate=obj_AppDelegate.insertdatecal;
		
		if(obj_AppDelegate.tabBarController.selectedViewController)
		{
			NSLog(@"Hi Girish Chauhan");
		}

		
		//if(obj_AppDelegate.isTodo)			
//		{
//			[obj_databasemethod insertdata_todotask:textf1.text remeinderdate:caldate];
//			
//		}
//		
//		else
//		{
//			
			[obj_databasemethod insertdata_todotask:textf1.text remeinderdate:todaystring];
		
        
        //}
		
		[self viewWillAppear:YES];
	}
	
	[textf1 resignFirstResponder];
	
	
	return YES;
}
//------------------- Reminder Set in Progress --------------------------------------------------------------
-(IBAction)btn_setAlerClicked:(id)sender
{
	[self btn_remainder_clicked:[sender tag]];
}

-(IBAction)btn_remainder_clicked:(int)val
{
	
	current_index = val;
	UIActionSheet *Act_sheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Ok" otherButtonTitles:nil,nil];
	Act_sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	[Act_sheet setBounds:CGRectMake(0, 40, 320, 175)];
	dt_picker = [[UIDatePicker alloc]init];
	[dt_picker addTarget:self action:@selector(btn_pickerview_selected:)forControlEvents:UIControlEventValueChanged];
	dt_picker.datePickerMode = UIDatePickerModeDateAndTime;
	
	[Act_sheet addSubview:dt_picker];
	
	[Act_sheet showInView:self.view];
	
	[Act_sheet release];	
	
	
}

-(IBAction)btn_pickerview_selected:(id)sender
{
	pickerflag = TRUE;
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	
	[df setDateFormat:@"MMM/dd/yyyy hh:mma"];
	tododate = [[df stringFromDate:dt_picker.date] retain];
	
	NSDateFormatter *df1=[[NSDateFormatter alloc]init];			
	[df1 setDateFormat:@"dd MMM, yyyy"];
	todaystringUpdate =[[df1 stringFromDate:dt_picker.date]retain];
	
	
	NSLog(@"goaldate = %@",tododate);
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex==0)
	{
		
		if (!pickerflag) 
		{
			NSDateFormatter *df=[[NSDateFormatter alloc]init];
			[df setDateFormat:@"MMM/dd/yyyy hh:mma"];
			tododate=[df stringFromDate:dt_picker.date];
			
			NSDateFormatter *df1=[[NSDateFormatter alloc]init];			
			[df1 setDateFormat:@"dd MMM, yyyy"];
			todaystringUpdate =[[df1 stringFromDate:dt_picker.date]retain];
			
		}
		NSLog(@"%@",[Ary_title objectAtIndex:current_index]);
		
		NSString *str1=[Ary_title objectAtIndex:current_index];
		
		[alermDic setObject:tododate forKey:str1];
		
		[obj_databasemethod updateTodo_AlermValue:str1 Date:tododate updateToday_date:todaystringUpdate];
		[self viewWillAppear:YES];
		[self scheduleNotification:str1];
		[tbl_todolist reloadData];
	}
	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc 
{
	[textf1 release];
	[tbl_todolist release];
	[Ary_title  release];
	[Ary_date release];
	[lbl_celldate release];
    [super dealloc];
}
@end
