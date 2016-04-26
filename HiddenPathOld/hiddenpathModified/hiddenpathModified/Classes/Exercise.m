//
//  Exercise.m
//  TABBAR
//
//  Created by openxcell technolabs on 8/25/11.
//  Copyright 2011 jn. All rights reserved.
//sfsfsd

#import "Exercise.h"
#import "Homepage.h"
#import "DatabaseMethod.h"


@implementation Exercise
@synthesize show_nvg;

#pragma mark -
#pragma mark View lifecycle
//asdjkakdhjk

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//[pickeview setFrame:CGRectMake(0, 44, 320, 435)];
	
	self.navigationItem.title = @"Select exercise";
	
//	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Exercise" style:UIBarButtonItemStylePlain target:self action:@selector(btn_picker_clicked:)];
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(btn_homepage_clicked:)];
	
	ary_month=[[NSMutableArray alloc]init];
	obj_databasemethod=[[DatabaseMethod alloc]init];
	tbl_exercise.backgroundColor=[UIColor clearColor];
	
	[ary_month addObject:@"Month 1-Law of Attraction"];
	[ary_month addObject:@"Month 2-Goals"];
	[ary_month addObject:@"Month 3-Healthy Mind"];
	[ary_month addObject:@"Month 4-Healthy Body"];
	[ary_month addObject:@"Month 5-Healthy Soul"];
	[ary_month addObject:@"Month 6-Wealth"];
	[ary_month addObject:@"Month 7-Forgiveness"];
	[ary_month addObject:@"Month 8-We Are All Connected"];
	[ary_month addObject:@"Month 9-Contrast"];
	[ary_month addObject:@"Month 10-Gratitude"];
	[ary_month addObject:@"Month 11-Gift of Giving"];
	[ary_month addObject:@"Month 12-Our End Is Your Beginning"];
	tbl_exercise.backgroundColor=[UIColor clearColor];
	
	tbl_exercise.hidden=FALSE;
}


    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	
	
	//self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Exercise" style:UIBarButtonItemStylePlain target:self action:@selector(btn_picker_clicked:)];
//		
//}

-(IBAction)btn_homepage_clicked:(id)sender
{
	
	Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
	//[self.navigationController pushViewController:obj_home animated:YES];	
	[self presentModalViewController:obj_home animated:NO];
	
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

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//	CGSize actualSize = [[Ary_ExeDesc objectAtIndex:indexPath.row] sizeWithFont:[UIFont fontWithName:@"Georgia" size:20]
//															  constrainedToSize:CGSizeMake(300, 9999) lineBreakMode:UILineBreakModeWordWrap];	
//	// Use the actual width and height needed for our text to create a container
//	CGSize textLabelSize = {actualSize.width, actualSize.height};
//	return textLabelSize.height+5;
//	
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [ary_month count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.textLabel.text=[ary_month objectAtIndex:indexPath.row];
	CGSize actualSize = [[ary_month objectAtIndex:indexPath.row] sizeWithFont:[UIFont fontWithName:@"Georgia" size:10]
						 constrainedToSize:CGSizeMake(300, 9999) lineBreakMode:UILineBreakModeWordWrap];	
	// Use the actual width and height needed for our text to create a container
	CGSize textLabelSize = {actualSize.width, actualSize.height};
	cell.textLabel.frame = CGRectMake(0,0,300,textLabelSize.height+5);
	cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
	cell.textLabel.numberOfLines = 0;
	cell.font = [UIFont fontWithName:@"Georgia-Bold" size:16];
	cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
   // [cell setFont:[UIFont fontWithName:@"Georgia" size:16]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	
			
	//	NSString *str=[NSString stringWithFormat:@"Exercise of %@",titleStr];
		
	return titleStr;
		
}	

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	
	return 40;
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if(obj){
		obj =nil;
		[obj release];
	}
	obj = [[ListOfExcercise alloc] initWithNibName:@"ListOfExcercise" bundle:nil];
	obj.Month1 =indexPath.row+1;
	titleStr = [ary_month objectAtIndex:indexPath.row];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:obj animated:YES];
    
    
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

