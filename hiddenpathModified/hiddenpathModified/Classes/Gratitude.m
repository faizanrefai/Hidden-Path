//
//  Gratitude.m
//  TABBAR
//
//  Created by openxcell technolabs on 6/23/11.
//  Copyright 2011 jn. All rights reserved.
//

#import "Gratitude.h"

#import "Homepage.h"
#import <QuartzCore/QuartzCore.h>


@implementation Gratitude
@synthesize Ary_title,isPush,show_nvg,nvgBar;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad 
{
    [super viewDidLoad];
	obj_AppDelegate=(TABBARAppDelegate *)[[UIApplication sharedApplication]delegate];
	obj_databasemethod=[[DatabaseMethod alloc]init];
	tbl_gratitude.backgroundColor=[UIColor clearColor];
	self.title=@"Gratitude";
	
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	
	
	
	Ary_title=[[NSMutableArray  alloc]init];
	Ary_date33=[[NSMutableArray  alloc]init];
	statusAry=[[NSMutableArray  alloc]init];
	
//	self.navigationItem.rightBarButtonItem = self.editButtonItem;
//	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonSystemItemFastForward  target:self action:@selector(btn_EditClicked_home:)];

	if(show_nvg)
	{
		nvgBar.hidden=YES;
		
	}
	else {
		[self viewWillAppear:YES];
	}
	
	
}

-(IBAction)Barbtn_Edit_clicked:(id)sender
{
	if(self.editing)
	{
		[super setEditing:NO animated:NO];
		[tbl_gratitude setEditing:NO animated:NO];
		[tbl_gratitude reloadData];
		[barbtn_edit setTitle:@"Edit"];
		[barbtn_edit setStyle:UIBarButtonItemStylePlain];
	}
	
	else
	{
		
		[super setEditing:NO animated:NO];
		[tbl_gratitude setEditing:YES animated:YES];
		[tbl_gratitude reloadData];
		[barbtn_edit setTitle:@"Done"];
		[barbtn_edit setStyle:UIBarButtonItemStyleDone];
		
		self.editing = TRUE; 
		
		
		
	}
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated 
{
    
	[super setEditing:editing animated:animated];
    [tbl_gratitude setEditing:editing animated:YES];
    
	if (editing)
	{
		
        self.navigationItem.leftBarButtonItem.enabled = NO;
		textf1.userInteractionEnabled=FALSE;
		
    } 
	else 
	{
		
        self.navigationItem.leftBarButtonItem.enabled = YES;
		textf1.userInteractionEnabled=TRUE;
	}
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.row==0)
	{
		return UITableViewCellEditingStyleNone;
	}
	
	if (self.editing && indexPath.row == ([Ary_title count]))
    {
		return UITableViewCellEditingStyleDelete;
	}
	
	else if(indexPath.row<[Ary_title count])
	{
		return UITableViewCellEditingStyleDelete;
	}
	
	
//	return UITableViewCellEditingStyleInsert;
	
	
}


-(void)viewWillAppear:(BOOL)animated
{
	
	
	NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]init];
	
	dictionary=[obj_databasemethod RandomDataSerching_FromGratitudeTable];
	Ary_title=[dictionary objectForKey:@"gratitude"];
	Ary_date33=[dictionary objectForKey:@"date"];
	statusAry=[dictionary objectForKey:@"status"];
	
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	if([Ary_title count]>0)
	{
		self.navigationItem.rightBarButtonItem = self.editButtonItem;
		//[super setEditing:NO animated:YES];	
	}
	
	if(!isPush)
	{
		self.navigationItem.rightBarButtonItem.enabled=YES;
		//home_btn=[[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonSystemItemFastForward  target:self action:@selector(btn_EditClicked_home:)];
		//self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonSystemItemFastForward  target:self action:@selector(btn_EditClicked_home:)];
	}
	else {
		self.navigationItem.leftBarButtonItem=nil;	
		self.navigationItem.rightBarButtonItem.enabled=YES;
	}


	[tbl_gratitude reloadData];
}
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)btn_EditClicked_home:(id)sender
{
	Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
	//[self.navigationController pushViewController:obj_home animated:NO];	
	[self presentModalViewController:obj_home animated:NO];
	

}


-(IBAction)btn_homepage_clicked:(id)sender
{
	Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
	[self.navigationController pushViewController:obj_home animated:YES];		
	[self.view addSubview:obj_home.view];
	[self.view removeFromSuperview];
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
	return 1;
	
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [Ary_title count]+1;
	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if(section==0)
		return @" Gratitude ";
	return nil;
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	[textf1 becomeFirstResponder];
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	
	static NSString *CellIdentifier = @"Cell";
	
	Cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (Cell == nil) 
//	{
//        
	Cell = [[[UITableViewCell alloc] 
				 initWithStyle:UITableViewCellStyleSubtitle 
				 reuseIdentifier:CellIdentifier] autorelease];
	lbl_cell=[[UILabel alloc]init];
	Main_lbl2=[[UILabel alloc]init];
	Main_lbl2.layer.cornerRadius=3.05;
	
	lbl_cell.backgroundColor=[UIColor clearColor];
	Main_lbl2.backgroundColor=[UIColor clearColor];
	
	
	//btn_set=[UIButton buttonWithType:UIButtonTypeCustom];
//	[btn_set setImage:[UIImage imageNamed:@"Alerm.png"]forState:UIControlStateNormal];
//	btn_set.tag=indexPath.row-1;
//
//	[btn_set addTarget:self action:@selector(btn_setAlerClicked:)forControlEvents:UIControlEventTouchUpInside];
//	
//	
   // }    
	
	[Cell  setSelectionStyle:UITableViewCellSelectionStyleNone];

	
	if(indexPath.row==0)
	{			
		//Cell.accessoryType =UITableViewCellAccessoryDetailDisclosureButton;
		
		imgviewCell=[[UIImageView alloc]initWithFrame:CGRectMake(265, 04, 30, 30)];
		imgviewCell.image=[UIImage imageNamed:@"Discloserbtn.png"];
				
		
		
		textf1=[[UITextField alloc] initWithFrame:CGRectMake(10, 10, 250, 35)];
		textf1.font=[UIFont fontWithName:@"Georgia" size:15];
		textf1.returnKeyType = UIReturnKeyDone;
		textf1.placeholder=@"click to add";
		textf1.delegate=self;
		textf1.textAlignment=UITextAlignmentLeft;
		[Cell.contentView addSubview:textf1];
		[Cell setAccessoryView:imgviewCell];
	}
	
	else	
	{
		 stringsize=[[Ary_title objectAtIndex:indexPath.row-1]sizeWithFont:[UIFont fontWithName:@"Georgia" size:15.0]constrainedToSize:CGSizeMake(250,500)lineBreakMode:UILineBreakModeWordWrap];
		lbl_cell.text=[Ary_title objectAtIndex:indexPath.row-1];
		lbl_cell.font=[UIFont fontWithName:@"Georgia"size:14];
		lbl_cell.backgroundColor=[UIColor clearColor];
		lbl_cell.frame=CGRectMake(10, 03, 250, stringsize.height-3);
		lbl_cell.numberOfLines=99;
		[Cell.contentView addSubview:lbl_cell];
		Cell.accessoryType=UITableViewCellAccessoryNone;	
		
		
		CGRect frm = lbl_cell.frame;
		frm.origin.y = frm.size.height+5;
		frm.size.height = 15;
		Main_lbl2.frame = frm;
		Main_lbl2.text=[Ary_date33 objectAtIndex:indexPath.row-1];
		
		Main_lbl2.backgroundColor = [UIColor clearColor];
		Main_lbl2.font=[UIFont fontWithName:@"Georgia"size:12.0];
		Main_lbl2.textColor = [UIColor blueColor];
		
		frm =btn_set.frame;
		btn_set.frame= frm;
		
		
	//	CGFloat mid=lbl_cell.frame.size.height/2;
	
	//	[btn_set setFrame:CGRectMake(02, mid, 30, 30)];
		
	//	[Cell.contentView addSubview:Main_lbl2];
		[Cell.contentView addSubview:lbl_cell];
		//[Cell.contentView addSubview:btn_set];
		
		
		
		
		if([[statusAry objectAtIndex:indexPath.row-1]isEqualToString:@"Yes"])
		{
			Cell.accessoryType=UITableViewCellAccessoryCheckmark;
		}
		
		else 
		{
			
			Cell.accessoryType=UITableViewCellAccessoryNone;
			
			
		}
		
	}
	
	
	
    return Cell;
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


-(IBAction)btn_setAlerClicked:(id)sender
{
	[self btn_remainder_clicked:[sender tag]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if(indexPath.row > 0)
	{
		NSString *str_update=[Ary_title objectAtIndex:indexPath.row-1];
		
		NSString *str_bool=[statusAry objectAtIndex:indexPath.row-1];
		
		[obj_databasemethod updatecellofGratitude:str_update update:str_bool];
		
		NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]init];
		dictionary=[obj_databasemethod RandomDataSerching_FromGratitudeTable];
		
		Ary_title=[dictionary objectForKey:@"gratitude"];
		statusAry=[dictionary objectForKey:@"status"];
		[tbl_gratitude reloadData];
		
	}
	
	
	
		
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{	
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.detailTextLabel.backgroundColor = [UIColor clearColor];
	
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
		if(indexPath.row==0)
		{
			self.navigationItem.rightBarButtonItem.enabled=NO;
		}
		NSString *str_ary_dele=[Ary_title objectAtIndex:indexPath.row-1];
		NSString *bool_delete=[statusAry objectAtIndex:indexPath.row-1];
		
		[Ary_title removeObjectAtIndex:indexPath.row-1];
		[Ary_date33 removeObjectAtIndex:indexPath.row-1];
		
		[obj_databasemethod  DeleteDataFromGratitude:str_ary_dele deleteYesNO:bool_delete];

		

		// Delete the row from the data source
		//[tbl_gratitude deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	
		if([Ary_title count]>0)
		{
			self.navigationItem.rightBarButtonItem = self.editButtonItem;
			
		}
		else
		{
			self.navigationItem.rightBarButtonItem=nil;	
			tbl_gratitude.editing=NO;
			self.navigationItem.leftBarButtonItem.enabled = YES;
			
		}
		
	}
	
	[tbl_gratitude reloadData];
	
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if(indexPath.row==0)
	{
		return 40;
	}
		
	else 
	{
		 stringsize=[[Ary_title objectAtIndex:indexPath.row-1]sizeWithFont:[UIFont fontWithName:@"Georgia" size:15.0]constrainedToSize:CGSizeMake(250, 500)lineBreakMode:UILineBreakModeWordWrap];
		return MAX(stringsize.height+5,40);

	}
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	NSDate *today=[NSDate date];
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	
	[df setDateFormat:@"MMM/dd/yyyy hh:mma"];
	NSString *todaystring =[[df stringFromDate:today]retain];
	
	Cell.textLabel.text=textf1.text;
	
	if((Cell.textLabel.text=@"")&&([textf1.text isEqualToString:@""]))
	{
		alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Enter the Text is there"delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 10.0);
		[alert setTransform:myTransform];
		[alert show];
		[alert release];
	}
	else 
	{
		[obj_databasemethod insertdata:textf1.text Date:todaystring];
		
		[self viewWillAppear:YES];
				
	}
	
	[textf1 resignFirstResponder];
	
		
	
	return YES;
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

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSLog(@"%@",[Ary_title objectAtIndex:current_index]);
	
	NSString *str=[Ary_title objectAtIndex:current_index];
	
	if(buttonIndex==0)
	{
		
		
		if (pickerflag==FALSE) {
			NSDateFormatter *df=[[NSDateFormatter alloc]init];
			[df setDateFormat:@"MMM/dd/yyyy hh:mma"];
			goaldate=[df stringFromDate:dt_picker.date];
		}
		
		
		[obj_databasemethod UpdateGratitude_AlermValue:str Date:goaldate];
		[self viewWillAppear:YES];
		[self scheduleNotification:str];
		[tbl_gratitude reloadData];
		
	}
}

- (void)scheduleNotification:(NSString *)str
{
    
    UILabel *lbl=[[UILabel alloc]init];
    lbl.text=@"Match will be Start now  ";
    
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    Class cls = NSClassFromString(@"UILocalNotification");
    if (cls != nil) {
        
        UILocalNotification *notif = [[cls alloc] init];
        notif.fireDate = [dt_picker date];
        notif.timeZone = [NSTimeZone defaultTimeZone];
        
        notif.alertBody =str;
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

-(IBAction)btn_pickerview_selected:(id)sender
{
	pickerflag = TRUE;
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	
	[df setDateFormat:@"MMM/dd/yyyy hh:mma"];
	goaldate = [[df stringFromDate:dt_picker.date] retain];
	
	NSLog(@"goaldate = %@",goaldate);
}

//-------- Data inserting Processs ---------------------


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}
- (void)dealloc 
{
    [super dealloc];
	[ary_id release];
	[Ary_title release];
}


@end

