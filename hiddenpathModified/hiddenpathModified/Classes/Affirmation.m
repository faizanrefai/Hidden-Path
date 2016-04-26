//
//  Affirmation.m
//  TABBAR
//
//  Created by openxcell technolabs on 7/6/11.
//  Copyright 2011 jn. All rights reserved.
//

#import "Affirmation.h"
#import "Homepage.h"


@implementation Affirmation
@synthesize show_nvgbar;

#pragma mark -
#pragma mark View lifecycle



- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	tbl_Afffirmation.backgroundColor=[UIColor clearColor];
	self.navigationItem.title=@"Affirmation";
	Ary_title=[[NSMutableArray  alloc]init];
	
	Ary_Data22=[[NSMutableArray  alloc]init];
	afferIdArry=[[NSMutableArray  alloc]init];
	
	
	statusAry=[[NSMutableArray  alloc]init];
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	obj_databasemethod=[[DatabaseMethod alloc]init];
	obj_AppDelegate=(TABBARAppDelegate *)[[UIApplication sharedApplication]delegate];

	if(!show_nvgbar)
	{
		nvgBar.hidden=YES;
		
		
	}
	
}
- (void)viewWillAppear:(BOOL)animated 
{
	
	pickerflag=FALSE;
    [super viewWillAppear:animated];
     
    [AlertHandler showAlertForProcess];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://openxcellaus.info/hiddenpath/affirmation_action.php?action=show_affirmation&iUserId=%d",[[[NSUserDefaults standardUserDefaults]valueForKey:@"userID"]intValue]];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    JSONParser*  parser1 = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(getGoalParsing1:) andHandler:self];
    
    NSLog(@"%@",parser1);
  	
	
}

-(void)getGoalParsing1:(NSDictionary*)dictio{

	[AlertHandler hideAlert];
    arremationDic=[[NSMutableDictionary alloc]initWithDictionary:dictio];
        
    NSLog(@"%@",dictio);
    
    
    [Ary_title removeAllObjects];
    [Ary_Data22 removeAllObjects];
    [statusAry removeAllObjects];
    [afferIdArry removeAllObjects];
    
    
    for (int ini=0;[[dictio valueForKey:@"affirmations"] count]>ini; ini++) {
       	
        [Ary_title addObject:[[[dictio valueForKey:@"affirmations"] objectAtIndex:ini] objectForKey:@"vAffirmationTxt"]];
        [Ary_Data22 addObject:[[[dictio valueForKey:@"affirmations"] objectAtIndex:ini] objectForKey:@"dDate"]];
        [statusAry  addObject: [[[dictio valueForKey:@"affirmations"] objectAtIndex:ini] objectForKey:@"vStatus"]];
        [afferIdArry  addObject: [[[dictio valueForKey:@"affirmations"] objectAtIndex:ini] objectForKey:@"iAffirmationId"]];
        
    }
    

    
	

	
	if([Ary_title count]>0)
	{
		self.navigationItem.rightBarButtonItem = self.editButtonItem;
		
		[super setEditing:NO animated:YES];
		barbtn_edit.enabled=TRUE;
		
		
	}
	else 
	{
		self.navigationItem.rightBarButtonItem=nil;
		barbtn_edit.enabled=FALSE;
		
	}
	[tbl_Afffirmation reloadData];

    

}

-(IBAction)btn_homepage_clicked:(id)sender
{
	Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
	[self.navigationController pushViewController:obj_home animated:YES];		
	[self.view addSubview:obj_home.view];
	[self.view removeFromSuperview];
}
-(IBAction)Barbtn_Edit_clicked:(id)sender;
{
	if(self.editing)
	{
		;
		[super setEditing:NO animated:NO];
		[tbl_Afffirmation setEditing:NO animated:NO];
		[tbl_Afffirmation reloadData];
		[barbtn_edit setTitle:@"Edit"];
		[barbtn_edit setStyle:UIBarButtonItemStylePlain];
	}
		
	else
	{
		
		[super setEditing:NO animated:NO];
		[tbl_Afffirmation setEditing:YES animated:YES];
		[tbl_Afffirmation reloadData];
		[barbtn_edit setTitle:@"Done"];
		[barbtn_edit setStyle:UIBarButtonItemStyleDone];
		
		self.editing = TRUE; 
		
		

	}
}
-(IBAction)Barbtn_Done_clicked:(id)sender
{
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


#pragma mark -
#pragma mark Table view data source


- (void)setEditing:(BOOL)editing animated:(BOOL)animated 
{
    
	

	[super setEditing:editing animated:animated];
    [tbl_Afffirmation setEditing:editing animated:YES];
    
	if (editing)
	{
		
		self.navigationItem.leftBarButtonItem.enabled =YES;
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
	
	
	return UITableViewCellEditingStyleInsert;
	
	
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Return the number of rows in the section.
    return [Ary_title count]+1;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.row==0)
		
	[textf1 becomeFirstResponder];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.detailTextLabel.backgroundColor = [UIColor clearColor];
	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
    
	
	Cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (Cell == nil) 
//	{
        Cell = [[[UITableViewCell alloc] 
				 initWithStyle:UITableViewCellStyleDefault 
				 reuseIdentifier:CellIdentifier] autorelease];
		lbl_cell=[[UILabel alloc]init];
		//Main_lbl2=[[UILabel alloc]init];
	//btn_set=[UIButton buttonWithType:UIButtonTypeCustom];
//	[btn_set setImage:[UIImage imageNamed:@"Alerm.png"]forState:UIControlStateNormal];
//	btn_set.tag=indexPath.row-1;
//	[btn_set addTarget:self action:@selector(btn_setAlerClicked:)forControlEvents:UIControlEventTouchUpInside];
//	
	
	
	
	[Cell setSelectionStyle:UITableViewCellSelectionStyleNone];


   // }
	if(indexPath.row==0)
	{
		//Cell.accessoryType =UITableViewCellAccessoryDetailDisclosureButton;
		
		imgviewCell=[[UIImageView alloc]initWithFrame:CGRectMake(265, 04, 30, 30)];
		imgviewCell.image=[UIImage imageNamed:@"Discloserbtn.png"];
		//[Cell.contentView addSubview:imgviewCell];
		[Cell setAccessoryView:imgviewCell];
		
		
		textf1=[[UITextField alloc] initWithFrame:CGRectMake(10, 10, 260, 35)];
		textf1.font=[UIFont fontWithName:@"Georgia" size:14];
		textf1.returnKeyType = UIReturnKeyDone;
		textf1.placeholder=@"click to add";
		textf1.delegate=self;
		textf1.textAlignment=UITextAlignmentLeft;
		[Cell.contentView addSubview:textf1];
	}
		
	
	else
	{
		 stringsize=[[Ary_title objectAtIndex:indexPath.row-1]sizeWithFont:[UIFont fontWithName:@"Georgia" size:15.0]constrainedToSize:CGSizeMake(250,500)lineBreakMode:UILineBreakModeWordWrap];
		lbl_cell.text=[Ary_title objectAtIndex:indexPath.row-1];
		lbl_cell.font=[UIFont fontWithName:@"Georgia"size:15.0];
		lbl_cell.backgroundColor=[UIColor clearColor];
		lbl_cell.frame=CGRectMake(8, 02, 260, stringsize.height);
		lbl_cell.numberOfLines=99;
		[Cell.contentView addSubview:lbl_cell];
		
		
		CGRect frm = lbl_cell.frame;
		frm.origin.y = frm.size.height+5;
		frm.size.height = 20;
		Main_lbl2.frame = frm;
		Main_lbl2.text=[Ary_Data22 objectAtIndex:indexPath.row-1];
		
		Main_lbl2.backgroundColor = [UIColor clearColor];
		Main_lbl2.font=[UIFont fontWithName:@"Georgia"size:12.0];
		Main_lbl2.textColor = [UIColor blueColor];
		CGFloat mid=lbl_cell.frame.size.height/2;
		[btn_set setFrame:CGRectMake(02, mid, 30, 30)];
		
		//[Cell.contentView addSubview:Main_lbl2];
//		[Cell.contentView addSubview:btn_set];
//		
//		
		
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
		
		
		[obj_databasemethod DeleteDataFromAffirmation:str_ary_dele deleteYesNO:bool_delete];
		
			
		[Ary_title removeObjectAtIndex:indexPath.row-1];
		
		[Ary_Data22 removeObjectAtIndex:indexPath.row-1];
		[statusAry removeObjectAtIndex:indexPath.row-1];

        [AlertHandler showAlertForProcess];
        
        NSString *urlStr = [NSString stringWithFormat:@"http://openxcellaus.info/hiddenpath/affirmation_action.php?action=delete_affirmation&iAffirmationId=%d&iUserId=%d",[[afferIdArry objectAtIndex:indexPath.row-1]intValue],[[[NSUserDefaults standardUserDefaults]valueForKey:@"userID"]intValue]];
        
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        
        JSONParser*  parser1 = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(getGoalParsing2:) andHandler:self];
        NSLog(@"parser1 %@",parser1);		
		
        [afferIdArry removeObjectAtIndex:indexPath.row-1];
        

		// Delete the row from the data source
		//[tbl_Afffirmation deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	
	
		if([Ary_title count]>0)
		{
			self.navigationItem.rightBarButtonItem = self.editButtonItem;
			
		}
		else
		{
			self.navigationItem.rightBarButtonItem=nil;	
			tbl_Afffirmation.editing=NO;
			self.navigationItem.leftBarButtonItem.enabled=YES;
			
			[barbtn_edit setStyle:UIBarButtonItemStyleBordered];
			[barbtn_edit setTitle:@"Edit"];
			self.editing=FALSE;
			barbtn_edit.enabled=FALSE;
			
		}
		
		
	
	}
	
	[tbl_Afffirmation reloadData];
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
		stringsize=[[Ary_title objectAtIndex:indexPath.row-1]sizeWithFont:[UIFont fontWithName:@"Georgia" size:16.0]constrainedToSize:CGSizeMake(250, 500)lineBreakMode:UILineBreakModeWordWrap];
		return MAX(stringsize.height+5,40);
		
	}
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


-(IBAction)btn_EditClicked_home:(id)sender
{
	Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
	//[self.navigationController pushViewController:obj_home animated:NO];	
	[self presentModalViewController:obj_home animated:NO];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	NSDate *today=[NSDate date];
	
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	
	[df setDateFormat:@"MMM/dd/yyyy hh:mma"];
	NSString *todaystring =[[df stringFromDate:today]retain];
	
	Cell.textLabel.text=textf1.text;
	
	if((Cell.textLabel.text=@"")&&([textf1.text isEqualToString:@""]))
	{
		alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Enter the Text is  there"delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 10.0);
		[alert setTransform:myTransform];
		[alert show];
		[alert release];
	}
	else 
	{
		//[obj_databasemethod  insertdata_Affirmation:textf1.text Date:todaystring];
        
        [AlertHandler showAlertForProcess];
        
        NSString *urlstring = [NSString stringWithFormat:@"http://openxcellaus.info/hiddenpath/affirmation_action.php?action=add_affirmation&iUserId=%d&vAffirmationTxt=%@",[[[NSUserDefaults standardUserDefaults]valueForKey:@"userID"]intValue],textf1.text];
        
        NSURL *url = [NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
		JSONParser* parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
        
		NSLog(@"%@",parser);
        

        
	}
	
	[textf1 resignFirstResponder];
	return YES;
}

-(void)searchResult:(NSDictionary*)dic{
    
    [AlertHandler hideAlert];
    [self viewWillAppear:YES];
    
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
		return @"Affirmations";
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
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

-(IBAction)btn_remainder_clicked:(int)Val
{

	current_index=Val;
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
		
		[obj_databasemethod updateAffirmation_AlermValue:str Date:goaldate];
		[self viewWillAppear:YES];
		[self scheduleNotification:str];
				
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
        
        NSDictionary *userDict = [NSDictionary dictionaryWithObject:str
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[textf1 becomeFirstResponder];

	if(indexPath.row > 0)
	{
		//NSString *str_update=[Ary_title objectAtIndex:indexPath.row-1];
		
		//NSString *str_bool=[statusAry objectAtIndex:indexPath.row-1];
		
		//[obj_databasemethod updatecellofAffirmation:str_update update:str_bool];
        
        [textf1 resignFirstResponder];

        [AlertHandler showAlertForProcess];
        
        NSString *urlstring = [NSString stringWithFormat:@"http://openxcellaus.info/hiddenpath/affirmation_action.php?action=update_affirmation&iAffirmationId=%d&iUserId=%d",[[afferIdArry objectAtIndex:indexPath.row-1]intValue],[[[NSUserDefaults standardUserDefaults]valueForKey:@"userID"]intValue]];
        
        NSURL *url = [NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
		JSONParser* parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(updateGoalRes:) andHandler:self];
        
		NSLog(@"%@",parser);

	}
	
}

-(void)updateGoalRes:(NSDictionary*)dictio{
    
	[AlertHandler hideAlert];
    
    NSLog(@"%@",dictio);
    
    
    [Ary_title removeAllObjects];
    [Ary_Data22 removeAllObjects];
    [statusAry removeAllObjects];
    [afferIdArry removeAllObjects];
    
    
    for (int ini=0;[[dictio valueForKey:@"affirmations"] count]>ini; ini++) {
       	
        [Ary_title addObject:[[[dictio valueForKey:@"affirmations"] objectAtIndex:ini] objectForKey:@"vAffirmationTxt"]];
        [Ary_Data22 addObject:[[[dictio valueForKey:@"affirmations"] objectAtIndex:ini] objectForKey:@"dDate"]];
        [statusAry  addObject: [[[dictio valueForKey:@"affirmations"] objectAtIndex:ini] objectForKey:@"vStatus"]];
        [afferIdArry  addObject: [[[dictio valueForKey:@"affirmations"] objectAtIndex:ini] objectForKey:@"iAffirmationId"]];
        
    }
    
    [tbl_Afffirmation  reloadData];
    
}

#pragma mark -
#pragma mark Memory management

//- (void)didReceiveMemoryWarning 
//{
//    // Releases the view if it doesn't have a superview.
//    [super didReceiveMemoryWarning];
//    
//    // Relinquish ownership any cached data, images, etc. that aren't in use.
//}
//
//- (void)viewDidUnload {
//    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
//    // For example: self.myOutlet = nil;
//}


- (void)dealloc 
{
    [super dealloc];
	[Ary_title release];
	[textf1 release];
}


@end

