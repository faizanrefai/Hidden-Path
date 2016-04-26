    //
//  second.m
//  TABBAR
//
//  Created by openxcell technolabs on 6/18/11.
//  Copyright 2011 jn. All rights reserved.
//

#import "second.h"
#import "PdfReader.h"
#import "Facebook.h"
#import "Twiter.h"
#import "Homepage.h"
#import "Hiddenpath.h"
#import "Affirmation.h"
#import "Exercise.h"
#import "todolist.h"
#import "Gratitude.h"
#import "Goal.h"

@implementation second

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	Ary_Exercise=[[NSMutableArray alloc]init];
	Ary_ExeDesc=[[NSMutableArray alloc]init];
	
	self.title=@"More";
	tbl_More.backgroundColor=[UIColor clearColor];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonSystemItemFastForward  target:self action:@selector(btn_EditClicked_home:)];
	Ary_data=[[NSArray alloc]initWithObjects:@"Twitter",@"To Do List",@"Affirmations",@"Goals",@"Gratitude",nil];
}

-(void)viewWillAppear:(BOOL)animated
{
	NSMutableDictionary *dict_Exe=[obj_databasemethod RandomDataSerching_FromExercise:Month1];
	
	//[Ary_Exercise addObject:[dict_Exe valueForKey:@"exercise"]];
	Ary_Exercise=[dict_Exe objectForKey:@"exercise"];
	//Ary_Exercise=[obj_databasemethod RandomDataSerching_FromExercise:1];
	titleStr=[dict_Exe objectForKey:@"title"];
	Ary_ExeDesc=[dict_Exe objectForKey:@"description"];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return 5; 
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
	//	UIImageView *imgviewCell=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 280, 100)];
	
	//	[imgviewCell setImage:[UIImage imageNamed:@"backgoundhiddenpath.png"]];
	
	
	
	//UIImageView *imgviewCell=[[UIImageView alloc]initWithFrame:CGRectMake(01, 0, 280, 40)];
	//
	//	
	//	[imgviewCell setImage:[UIImage imageNamed:@"button-green1.png"]];
	//	
	//	
	//	[cell.backgroundView addSubview:imgviewCell];
	
//	cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellBK.png"]];
	
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.detailTextLabel.backgroundColor = [UIColor clearColor];
	
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	//cell.font=[UIFont systemFontOfSize:15];
	    
	cell.textLabel.font=[UIFont fontWithName:@"Georgia-Bold" size:16];

	cell.textLabel.text=[Ary_data objectAtIndex:indexPath.row];	
	
	cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;

	//UIImageView *imgviewCell=[[UIImageView alloc]initWithFrame:CGRectMake(270, 15, 13, 13)];
//	imgviewCell.image=[UIImage imageNamed:@"Arrow_Cell.png"];
//	[cell.contentView addSubview:imgviewCell];
	
	
	

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if(indexPath.row==3)
	{
		Goal *obj_goal=[[Goal alloc]initWithNibName:@"Goal" bundle:nil];
		obj_goal.show_nvg=TRUE;
		[self.navigationController pushViewController:obj_goal animated:YES];
		
		
	
	}
	
else if(indexPath.row==1)
	{
		todolist *obj_todo=[[todolist alloc]initWithNibName:@"todolist" bundle:nil];
		obj_todo.show_nvgbar=TRUE;
		[self.navigationController pushViewController:obj_todo animated:YES];
		
	}
else if(indexPath.row==0)
	{
		Twiter  *obj_twiter=[[Twiter alloc]initWithNibName:@"Twiter" bundle:nil];
		[self.navigationController pushViewController:obj_twiter animated:YES];

	}

else if(indexPath.row==2)
	{
		Affirmation *obj_aff=[[Affirmation alloc]initWithNibName:@"Affirmation" bundle:nil];
		obj_aff.show_nvgbar=TRUE;
		[self.navigationController pushViewController:obj_aff animated:YES];
		
	}
	
	else if(indexPath.row==4)
	{
	
		
		Gratitude *obj_grat=[[Gratitude alloc]initWithNibName:@"Gratitude" bundle:nil];
			
		obj_grat.show_nvg=TRUE;
		[self.navigationController pushViewController:obj_grat animated:YES];
				
	}

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	
	
		return @"More";
		
		
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


-(IBAction)btn_EditClicked_home:(id)sender
{
	Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
	//[self.navigationController pushViewController:obj_home animated:NO];
	[self presentModalViewController:obj_home animated:NO];
	
	
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


- (void)dealloc {
    [super dealloc];
}


@end
