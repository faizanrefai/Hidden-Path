//
//  Goal.m
//  TABBAR
//
//  Created by openxcell technolabs on 6/22/11.
//  Copyright 2011 jn. All rights reserved.
//

#import "Goal.h"
#import"TABBARAppDelegate.h"
#import <sqlite3.h>
#import "Homepage.h"
#import "DatabaseMethod.h"
#import <QuartzCore/QuartzCore.h>


@implementation Goal
@synthesize Ary_GoalData,chekedindexpath,isPush,str_textfielddata,show_nvg,nvg_bar;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title=@"Goals";
	
	

	self.navigationItem.rightBarButtonItem = self.editButtonItem;
		obj_AppDelegate=(TABBARAppDelegate *)[[UIApplication sharedApplication]delegate];
	obj_databaseMethod=[[DatabaseMethod alloc]init];
	tbl_Goal.backgroundColor=[UIColor clearColor];
	//self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonSystemItemFastForward  target:self action:@selector(btn_EditClicked_home:)];

	pickerflag = FALSE;	
    golsDictionary = [[NSMutableDictionary alloc]init];
	Ary_GoalData=[[NSMutableArray  alloc]init];	
	golIdArry=[[NSMutableArray  alloc]init];	
	Ary_Data=[[NSMutableArray  alloc]init];	
	statusAry=[[NSMutableArray  alloc]init];	
	NSDate *today=[NSDate date];	
	[dt_picker setDate:today];
	if(show_nvg)
	{
		nvg_bar.hidden=YES;
		
	}
	else {
		//[self viewWillAppear:YES];
	}
	
	
	
}

-(IBAction)Barbtn_Edit_clicked:(id)sender
{
	if(self.editing)
	{
		[super setEditing:NO animated:YES];
		[tbl_Goal setEditing:NO animated:YES];
		[tbl_Goal reloadData];
		[barbtn_edit setTitle:@"Edit"];
		[barbtn_edit setStyle:UIBarButtonItemStylePlain];
	}
	
	else
	{
		
		[super setEditing:YES animated:YES];
		[tbl_Goal setEditing:YES animated:YES];
		[tbl_Goal reloadData];
		[barbtn_edit setTitle:@"Done"];
		[barbtn_edit setStyle:UIBarButtonItemStyleDone];
		
		self.editing = TRUE; 
		
		
		
	}
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
	[super setEditing:editing animated:animated];
    [tbl_Goal setEditing:editing animated:YES];

	
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

- (void)navigationController:(UINavigationController *)navigationController 
	  willShowViewController:(UIViewController *)viewController animated:(BOOL)animated 
{
    [viewController viewWillAppear:animated];
}

- (void)navigationController:(UINavigationController *)navigationController 
	   didShowViewController:(UIViewController *)viewController animated:(BOOL)animated 
{
    [viewController viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
	pickerflag = FALSE;
	
    
    
    [AlertHandler showAlertForProcess];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://openxcellaus.info/hiddenpath/goal_action.php?action=show_goal&iUserId=%d",[[[NSUserDefaults standardUserDefaults]valueForKey:@"userID"]intValue]];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
  
    JSONParser*  parser1 = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(getGoalParsing1:) andHandler:self];

    NSLog(@"%@",parser1);
	
}



-(void)getGoalParsing1:(NSDictionary *)dictionary{

	//NSMutableDictionary * dictionary=[obj_databaseMethod  RandomDataSerching_FromGoal];
	[AlertHandler hideAlert];
    
    NSLog(@"Goal : %@",[dictionary valueForKey:@"goals"]);
    
    golsDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary ];
    
    [Ary_GoalData removeAllObjects];
    [Ary_Data removeAllObjects];
    [statusAry removeAllObjects];
    [golIdArry removeAllObjects];
    

    for (int ini=0;[[dictionary valueForKey:@"goals"] count]>ini; ini++) {
       	[Ary_GoalData addObject:[[[dictionary valueForKey:@"goals"] objectAtIndex:ini] objectForKey:@"vGoalTxt"]];
        [Ary_Data addObject:[[[dictionary valueForKey:@"goals"] objectAtIndex:ini] objectForKey:@"dDate"]];
        [statusAry  addObject: [[[dictionary valueForKey:@"goals"] objectAtIndex:ini] objectForKey:@"vStatus"]];
        [golIdArry  addObject: [[[dictionary valueForKey:@"goals"] objectAtIndex:ini] objectForKey:@"iGoalId"]];
 
    }
    
	
	[tbl_Goal reloadData];
	
	
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	
	//if([Ary_title count]>0)
    //	{
    //		self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //		
    //		[super setEditing:NO animated:YES];
    //		barbtn_edit.enabled=TRUE;
    //		
    //		
    //	}
    //	else 
    //	{
    //		self.navigationItem.rightBarButtonItem=nil;
    //		barbtn_edit.enabled=FALSE;
    //		
    //	}
    //	
	
	
	if([Ary_GoalData count]>0)
	{
		self.navigationItem.rightBarButtonItem = self.editButtonItem;
		
		[super setEditing:NO animated:YES];
		
	}
	else
	{
		self.navigationItem.rightBarButtonItem=nil;	
        
		
	}
	
	if(!isPush)
	{
		
		self.navigationItem.rightBarButtonItem.enabled=YES;
	}
	else 
	{
		
		self.navigationItem.leftBarButtonItem=nil;	
		self.navigationItem.rightBarButtonItem.enabled=YES;
	}


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
	goaldate = [[df stringFromDate:dt_picker.date] retain];
	
	
	NSLog(@"goaldate = %@",goaldate);
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

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
//{
//	 UIView *Vw = [[UIView alloc]initWithFrame:CGRectMake(6, 14, 308, 40) ];
//	UIImageView *imaview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tblheader.png"]];
//	imaview.frame = CGRectMake(6, 14, 308, 40);
//	[Vw addSubview:imaview];
//	return Vw;
//	
//}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex==0)
	{
			
			
			if (pickerflag==FALSE) 
			{
				NSDateFormatter *df=[[NSDateFormatter alloc]init];
				[df setDateFormat:@"MMM/dd/yyyy hh:mma"];
				goaldate=[df stringFromDate:dt_picker.date];
			}
		NSLog(@"%@",[Ary_GoalData objectAtIndex:current_index]);
		
		NSString *str=[Ary_GoalData objectAtIndex:current_index];			
		[obj_databaseMethod updateGoal_AlermValue:str Date:goaldate];
			[self viewWillAppear:YES];
		[self scheduleNotification:str];
			[tbl_Goal reloadData];
		
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
        
        notif.alertBody = str;
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

-(IBAction)btn_homepage_clicked:(id)sender
{
	Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
	[self.navigationController pushViewController:obj_home animated:YES];		
	[self.view addSubview:obj_home.view];
	[self.view removeFromSuperview];
}


-(IBAction)btn_EditClicked_home:(id)sender
{
	Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
	//[self.navigationController pushViewController:obj_home animated:YES];	
	[self presentModalViewController:obj_home animated:NO];
	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [Ary_GoalData count]+1;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	[textf1 becomeFirstResponder];
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
   
	static NSString *CellIdentifier = @"Cell";
    
	    
	Cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (Cell == nil) 
	//{
    
    Cell = [[[UITableViewCell alloc] 
             initWithStyle:UITableViewCellStyleSubtitle 
             reuseIdentifier:CellIdentifier] autorelease];
       
		Main_lbl=[[UILabel alloc]init];
		Main_lbl.layer.cornerRadius=3.05;
    Main_lbl.adjustsFontSizeToFitWidth=YES;
    
//	btn_set=[UIButton buttonWithType:UIButtonTypeCustom];
//	[btn_set setImage:[UIImage imageNamed:@"Alerm.png"]forState:UIControlStateNormal];
//	//	[btn_set setTitle:@"Alerm"forState:UIControlStateNormal];
//	btn_set.tag=indexPath.row-1;
//	[btn_set addTarget:self action:@selector(btn_setAlerClicked:)forControlEvents:UIControlEventTouchUpInside];
//	
//	btn_set.hidden=TRUE;
//		
		
	
//	Main_lbl2=[[UILabel alloc]init];
//	Main_lbl2.layer.cornerRadius=3.05;
//	Main_lbl2.hidden=TRUE;
	   
	//}
	[Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	
	if(indexPath.row==0)
	{			
		//Cell.accessoryType =UITableViewCellAccessoryDetailDisclosureButton;
		imgviewCell=[[UIImageView alloc]initWithFrame:CGRectMake(265, 04, 30, 30)];
		imgviewCell.image=[UIImage imageNamed:@"Discloserbtn.png"];
		[Cell setAccessoryView:imgviewCell];
		
		
		textf1=[[UITextField alloc] initWithFrame:CGRectMake(10, 10, 250, 35)];
		textf1.font=[UIFont fontWithName:@"Georgia"size:14.0];
		textf1.returnKeyType = UIReturnKeyDone;
		textf1.placeholder=@"click to add";
		textf1.delegate=self;
		textf1.textAlignment=UITextAlignmentLeft;

		[Cell.contentView addSubview:textf1];
	}
	
	else	
	{
		 
		stringsize=[[Ary_GoalData objectAtIndex:indexPath.row-1]sizeWithFont:[UIFont fontWithName:@"Georgia" size:17.0]constrainedToSize:CGSizeMake(250,500)lineBreakMode:UILineBreakModeWordWrap];
		
		Main_lbl.frame=CGRectMake(10, 2, 250, stringsize.height-3);
		Main_lbl.text=[Ary_GoalData objectAtIndex:indexPath.row-1];
		Main_lbl.font=[UIFont fontWithName:@"Georgia"size:15.0];
		Main_lbl.backgroundColor=[UIColor clearColor];
		Main_lbl.numberOfLines=100;
		
		CGRect frm = Main_lbl.frame;
		frm.origin.y = frm.size.height+5;
		frm.size.height = 20;

        
		[Cell.contentView addSubview:Main_lbl];

        
		if([[statusAry objectAtIndex:indexPath.row-1]isEqualToString:@"Y"])
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
-(IBAction)btn_setAlerClicked:(id)sender
{
	[self btn_remainder_clicked:[sender tag]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
	
	[textf1 becomeFirstResponder];
	
	if(indexPath.row > 0)
	{
		//NSString *str_update=[Ary_GoalData objectAtIndex:indexPath.row-1];
		
		//NSString *str_bool=[statusAry objectAtIndex:indexPath.row-1];
		
		//[obj_databaseMethod updatecell:str_update update:str_bool];
        
        [textf1 resignFirstResponder];
        
        [AlertHandler showAlertForProcess];
        
       
        NSString *urlstring = [NSString stringWithFormat:@"http://openxcellaus.info/hiddenpath/goal_action.php?action=update_goal&iGoalId=%d&iUserId=%d",[[golIdArry objectAtIndex:indexPath.row-1]intValue],[[[NSUserDefaults standardUserDefaults]valueForKey:@"userID"]intValue]];
        
        NSURL *url = [NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
		JSONParser* parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(updateGoalRes:) andHandler:self];
        
		NSLog(@"%@",parser);

				
	}

    //[tbl_Goal reloadData];
}

-(void)updateGoalRes:(NSDictionary*)dic{
   
    NSLog(@"%@",dic);
    [AlertHandler hideAlert];

    golsDictionary = [NSMutableDictionary dictionaryWithDictionary:dic ];
    
    [Ary_GoalData removeAllObjects];
    [Ary_Data removeAllObjects];
    [statusAry removeAllObjects];
    [golIdArry removeAllObjects];
    

    
    for (int ini=0;[[dic valueForKey:@"goals"] count]>ini; ini++) {
       	[Ary_GoalData addObject:[[[dic valueForKey:@"goals"] objectAtIndex:ini] objectForKey:@"vGoalTxt"]];
        [Ary_Data addObject:[[[dic valueForKey:@"goals"] objectAtIndex:ini] objectForKey:@"dDate"]];
        [statusAry  addObject: [[[dic valueForKey:@"goals"] objectAtIndex:ini] objectForKey:@"vStatus"]];
        [golIdArry  addObject: [[[dic valueForKey:@"goals"] objectAtIndex:ini] objectForKey:@"iGoalId"]];
        
    }
     
	[tbl_Goal reloadData];

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
	
	
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	cell.textLabel.backgroundColor = [UIColor clearColor];

	
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	if(indexPath.row==0)
	{
		
		return UITableViewCellEditingStyleNone;
		
	}
	
	if (self.editing && indexPath.row == ([Ary_GoalData count]))
    {
		return UITableViewCellEditingStyleDelete;
	}
	
	else if(indexPath.row<[Ary_GoalData count])
	{
		return UITableViewCellEditingStyleDelete;
	}
	
	
	return UITableViewCellEditingStyleNone;

}
- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
		if(indexPath.row==0)
		{
			self.navigationItem.rightBarButtonItem.enabled=NO;
		}
	//	NSString *str_ary_dele=[Ary_GoalData objectAtIndex:indexPath.row-1];
	//	NSString *bool_delete=[statusAry objectAtIndex:indexPath.row-1];
				
			
		//[obj_databaseMethod DeleteDataFromDatabase:str_ary_dele deleteYesNO:bool_delete];
		
		[Ary_GoalData removeObjectAtIndex:indexPath.row-1];
		[statusAry removeObjectAtIndex:indexPath.row-1];
		[Ary_Data removeObjectAtIndex:indexPath.row-1];
				
		
        [AlertHandler showAlertForProcess];
        
        NSString *urlStr = [NSString stringWithFormat:@"http://openxcellaus.info/hiddenpath/goal_action.php?action=delete_goal&iGoalId=%d&iUserId=%d",[[golIdArry objectAtIndex:indexPath.row-1]intValue],[[[NSUserDefaults standardUserDefaults]valueForKey:@"userID"]intValue]];
        
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        
        JSONParser*  parser1 = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(getGoalParsing2:) andHandler:self];
        NSLog(@"parser1 %@",parser1);		
		
        [golIdArry removeObjectAtIndex:indexPath.row-1];

        
        if([Ary_GoalData count]>0)
		{
			self.navigationItem.rightBarButtonItem = self.editButtonItem;
			
		}
		else
		{
			self.navigationItem.rightBarButtonItem=nil;	
			tbl_Goal.editing=NO;
			self.navigationItem.leftBarButtonItem.enabled = YES;
			
		}
		
		
		
	}
	
	[tbl_Goal reloadData];
}

-(void)getGoalParsing2:(NSDictionary*)dic{

    [AlertHandler hideAlert];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.row==0)
	{
		return 40;
	}
	else 
	{
		CGSize stringSize = [[Ary_GoalData objectAtIndex:indexPath.row-1] sizeWithFont:[UIFont fontWithName:@"Georgia" size:16.0] constrainedToSize:CGSizeMake(250, 500) lineBreakMode:UILineBreakModeWordWrap];
		return MAX(stringSize.height+5,40);
		
	}
}
//- (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
//{
//	[tbl_Goal scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
//
//}
//

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	
		return @"Goals";
	
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


//---------- TextField ----------------------

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	//[self animateTextField: textField up: YES];
	//tbl_Goal.frame=CGRectMake(0,0, 320,320);
	
	return YES;
}	
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//	NSDate *today=[NSDate date];
//	
//	NSDateFormatter *df=[[NSDateFormatter alloc]init];
//	
//	[df setDateFormat:@"MMM/dd/yyyy hh:mma"];
//	NSString *todaystring =[[df stringFromDate:today]retain];
	
	
	Cell.textLabel.text=textf1.text;
	
	if((Cell.textLabel.text=@"")&&([textf1.text isEqualToString:@""]))
	{
		alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please enter the text to add the Goal."delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 10.0);
		[alert setTransform:myTransform];
		[alert show];
		[alert release];
	}
	
	else 
	{
	
        [AlertHandler showAlertForProcess];
        
        NSString *urlstring = [NSString stringWithFormat:@"http://openxcellaus.info/hiddenpath/goal_action.php?action=add_goal&iUserId=%d&vGoalTxt=%@",[[[NSUserDefaults standardUserDefaults]valueForKey:@"userID"]intValue],textf1.text];
        
        NSURL *url = [NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
		JSONParser* parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];

		NSLog(@"%@",parser);
        
        
	}

	[textf1 resignFirstResponder];
	
	
	return YES;
}



-(void)searchResult:(NSDictionary*)dicto{

    [AlertHandler hideAlert];
    NSLog(@"%@",dicto);    
    [self viewWillAppear:YES];

}
-(IBAction)btn_EditClicked:(id)sender
{
	//AddGoal *obj_addgoal=[[AddGoal alloc]initWithNibName:@"AddGoal" bundle:nil];
//	[self.navigationController pushViewController:obj_addgoal animated:YES];
//	[obj_addgoal setParentObj:self];
}

//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
//{    
//    
//    
//    NSMutableDictionary *item = [self.itemList objectAtIndex:indexPath.row];
//    BOOL checked = [[item objectForKey:@"checked"] boolValue];
//    [item setObject:[NSNumber numberWithBool:!checked] forKey:@"checked"];
//    UITableViewCell *cell = [item objectForKey:@"cell"];
//    UIButton *button = (UIButton *)cell.accessoryView;
//    UIImage *newImage = (checked) ? [UIImage imageNamed:@"unchecked.png"] : [UIImage imageNamed:@"checked.png"];
//    [button setBackgroundImage:newImage forState:UIControlStateNormal];
//    
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}s
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

//------>>>>>>>>>>>>>>>> Data base insert data--->>>>>>>>>>


#pragma mark -
#pragma mark Table view delegate




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
	[Ary_GoalData release];
	[statusAry release];
	[textf1 release];
	[Main_lbl release];
	
}


@end

