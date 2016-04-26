//
//  ListOfExcercise.m
//  HiddenPath
//
//  Created by Openxcelltech on 4/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Exercise.h"
#import "Homepage.h"
#import "DatabaseMethod.h"
#import "ListOfExcercise.h"


@implementation ListOfExcercise

@synthesize Month1,titleStr;

#pragma mark -
#pragma mark View lifecycle
//asdjkakdhjk

- (void)viewDidLoad {
    [super viewDidLoad];
	
		self.navigationItem.title = @"List of exercise";
	obj_databasemethod=[[DatabaseMethod alloc]init];
	[self DatafromExercise];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Excersice" style:UIBarButtonItemStylePlain target:self action:@selector(backClicked:)];

	
	datatable.backgroundView =nil;
	datatable.backgroundColor =[UIColor clearColor];
}


-(IBAction)backClicked:(id)sender{

	[self.navigationController popViewControllerAnimated:YES];
}
-(void)DatafromExercise{
	
	NSMutableDictionary *dict_Exe=[obj_databasemethod RandomDataSerching_FromExercise:Month1];	
	Ary_Exercise=[[dict_Exe objectForKey:@"exercise"] retain];
	titleStr=[dict_Exe objectForKey:@"title"];
	Ary_ExeDesc=[dict_Exe objectForKey:@"description"];
	[datatable reloadData];
	
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
	
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	cell.textLabel.backgroundColor = [UIColor clearColor];
	
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	CGSize actualSize = [[Ary_ExeDesc objectAtIndex:indexPath.row] sizeWithFont:[UIFont fontWithName:@"Georgia" size:17]
															  constrainedToSize:CGSizeMake(300, 9999) lineBreakMode:UILineBreakModeWordWrap];	
	// Use the actual width and height needed for our text to create a container
	CGSize textLabelSize = {actualSize.width, actualSize.height};
	return textLabelSize.height+5;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [Ary_Exercise count];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0,0, tableView.bounds.size.width, 30)] autorelease];
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width - 10, 25)] autorelease];
    label.text = [titleStr retain];
	[label setFont:[UIFont fontWithName:@"Georgia-Bold" size:20]];
	
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
	return headerView;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.textLabel.text=[Ary_ExeDesc objectAtIndex:indexPath.row];
	CGSize actualSize = [[Ary_ExeDesc objectAtIndex:indexPath.row] sizeWithFont:[UIFont fontWithName:@"Georgia" size:16]
															  constrainedToSize:CGSizeMake(300, 9999) lineBreakMode:UILineBreakModeWordWrap];	
	// Use the actual width and height needed for our text to create a container
	CGSize textLabelSize = {actualSize.width, actualSize.height};
	cell.textLabel.frame = CGRectMake(0,0,300,textLabelSize.height+5);
	cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
	cell.textLabel.numberOfLines = 0;
    [cell setFont:[UIFont fontWithName:@"Georgia" size:16]];
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//	
//	
//	//	NSString *str=[NSString stringWithFormat:@"Exercise of %@",titleStr];
//	
//	return titleStr;
//	
//}	

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	
	return 40;
}



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


- (void)dealloc {
    [super dealloc];
}


@end

