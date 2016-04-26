//
//  todofromjournal.m
//  HiddenPath
//
//  Created by openxcell technolabs on 9/30/11.
//  Copyright 2011 jn. All rights reserved.
//

#import "todofromjournal.h"

@implementation todofromjournal


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
    [super viewDidLoad];
	bagcounter=0;
	tbl_todo.backgroundColor=[UIColor clearColor];
	obj_databasemethod=[[DatabaseMethod alloc]init];
	obj_AppDelegate=(TABBARAppDelegate *)[[UIApplication sharedApplication]delegate];

	alermDic = [[NSMutableDictionary alloc] init];
	
	self.navigationItem.title=@"To do";
	
	Ary_date=[[NSMutableArray alloc]init];
	Ary_title=[[NSMutableArray alloc]init];
	statusAry=[[NSMutableArray alloc]init];

	
	//self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButttonckicked:)];

}

-(void)viewWillAppear:(BOOL)animated
{
	
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]init];
	
	dictionary=[obj_databasemethod  RandomDataTodoFromJournal_FromToDotask:obj_AppDelegate.insertdatecal];
	
	Ary_title=[dictionary objectForKey:@"todotask"];
	Ary_date=[dictionary objectForKey:@"remainder"];
	statusAry = [dictionary objectForKey:@"status"];
	
	if ([Ary_title count]>0) {
		for (int h=0; h<[Ary_title count]; h++) {
			NSString *Rem;
			Rem = [obj_databasemethod GetRemindar:[Ary_title objectAtIndex:h]];
			[alermDic setObject:Rem forKey:[Ary_title objectAtIndex:h]];
		}
	}
	
	NSLog(@"%@",alermDic);
	
	[tbl_todo reloadData];


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

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	[super setEditing:editing animated:YES];
	
	[tbl_todo setEditing:editing animated:YES];
	
	
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tbl_todo dequeueReusableCellWithIdentifier:CellIdentifier ];
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
		
		
		NSDate* firstDate = dt;
        NSDate* secondDate = [df dateFromString:[NSString stringWithFormat:@"%@",[alermDic objectForKey:lbl_cellone.text]]];
        
		NSLog(@"%@",[alermDic objectForKey:lbl_cellone.text]);
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
		
		
		
		if (timeDifference1 <0) {
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
		//
		if([[statusAry objectAtIndex:indexPath.row-1]isEqualToString:@"Yes"])
		{
			cell.accessoryType=UITableViewCellAccessoryCheckmark;
		}
		
		else 
		{
			
			cell.accessoryType=UITableViewCellAccessoryNone;
			
			
		}
		
		
		
	}
	
	
		return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
	
	[tbl_todo reloadData];
	
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
	
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	cell.textLabel.backgroundColor = [UIColor clearColor];
	
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
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


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"To do List";
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
		
		if(indexPath.row==0)
		{
			self.navigationItem.rightBarButtonItem.enabled=NO;
			self.navigationItem.rightBarButtonItem=nil;
		}
		NSString *str_ary_dele=[Ary_title objectAtIndex:indexPath.row-1];
		
		[obj_databasemethod  DeleteDataFromTodoList:str_ary_dele];
		
		[Ary_title removeObjectAtIndex:indexPath.row-1];
		[Ary_date removeObjectAtIndex:indexPath.row-1];
		
		
		if([Ary_title count]>0)
		{
			self.navigationItem.rightBarButtonItem = self.editButtonItem;
			
		}
		else
		{
			self.navigationItem.rightBarButtonItem=nil;	
			self.navigationItem.leftBarButtonItem.enabled = YES;
			tbl_todo.editing=NO;
			
			
		}
		
		
	}
	
	
	[tbl_todo reloadData];
}

-(IBAction)btn_setAlerClicked:(id)sender
{
	[self btn_remainder_clicked:[sender tag]];
}

-(IBAction)btn_remainder_clicked:(int)val
{
	
	current_index = val;
	UIActionSheet *Act_sheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"OK" otherButtonTitles:nil,nil];
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
		[tbl_todo reloadData];
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
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
		
		NSString *caldate=obj_AppDelegate.insertdatecal;
		
		
		if(obj_AppDelegate.isTodo)			
		{
			[obj_databasemethod insertdata_todotask:textf1.text remeinderdate:caldate];
			
		}
		
		else
		{
			
			[obj_databasemethod insertdata_todotask:textf1.text remeinderdate:todaystring];
		}
		
		[self viewWillAppear:YES];
	}
	
	
	
	
	[textField resignFirstResponder];
	
	return YES;
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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


- (void)dealloc {
    [super dealloc];
}


@end
