//
//  calender.m
//  TABBAR
//
//  Created by openxcell technolabs on 6/29/11.
//  Copyright 2011 jn. All rights reserved.
//

#import "calender.h"
#import "FirstViewController.h"


@implementation calender

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
	
	flag=FALSE;
		
	
	obj_AppDelegate=(TABBARAppDelegate *)[[UIApplication sharedApplication]delegate];
	obj_databasemethod=[[DatabaseMethod alloc]init];
	[SelectedDate_Ary removeAllObjects];
	SelectedDate_Ary=[obj_databasemethod  RandomDataSerching_FromMasterTable];
	obj_firstview.Selecteddate_Ary=[SelectedDate_Ary copy];
	
	calendarView = [[[KLCalendarView alloc] initWithFrame:CGRectMake(05.0f, 50.0f,  310.0f, 355.0f) delegate:self] autorelease];
	SelectedDate_Ary=[[NSMutableArray alloc]init];

		
	[self.view addSubview:calendarView];
	}
-(void)viewWillAppear:(BOOL)animated
{
	
	
	
}
/*----- Calendar Delegates -----> */

- (void)calendarView:(KLCalendarView *)calendarView tappedTile:(KLTile *)aTile
{
	
	NSString *str=[NSString stringWithFormat:@"%@",[aTile date]];
	
	NSLog(@"%@",str);
	NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
	[inFormat setDateFormat:@"yyyy-MM-dd"];
	
	NSDate *parsed = [inFormat dateFromString:str];
	NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
	[dateFormat1 setDateFormat:@"dd MMM, yyyy"];
	NSString *dateString = [dateFormat1 stringFromDate:parsed];
	NSLog(@"%@",dateString)	;
	obj_firstview.str_Calendar=dateString;
	obj_AppDelegate.insertdatecal=dateString;
	aTile.backgroundColor=[UIColor yellowColor];
	
	obj_firstview.isMaster=TRUE;
	obj_AppDelegate.isTodo=TRUE;
	
	//[aTile flash];
	
	[self performSelector:@selector(Go_back)withObject:nil afterDelay:0.3f];
}
-(void)Go_back
{
	[self.navigationController popViewControllerAnimated:YES];

}
-(void)setParentObj:(FirstViewController *)obj
{
	obj_firstview =[[FirstViewController alloc]init];
	obj_firstview=obj;
}
- (KLTile *)calendarView:(KLCalendarView *)calendarView createTileForDate:(KLDate *)date
{
	
	
	CheckmarkTile *tile1 = [[CheckmarkTile alloc] init];

	for(int i=0;i<[SelectedDate_Ary count];i++)
	{	
		
		NSString *temp=[SelectedDate_Ary objectAtIndex:i];
		NSLog(@"temp is %@",temp);
		
		NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
		[dateFormat2 setDateFormat:@"dd MMM, yyyy"];
		NSDate *parsed1 = [dateFormat2 dateFromString:temp];
		
		NSDateFormatter *dateFormat3 = [[NSDateFormatter alloc] init];
		[dateFormat3 setDateFormat:@"yyyy-MM-dd"];
		NSString *dateString = [dateFormat3 stringFromDate:parsed1];
		NSLog(@"%@",dateString)	;
		
		
	//	NSString *dateString = [dateFormat1 stringFromDate:parsed];
		
		//[SelectedDate_Ary objectAtIndex:i]		
		if([[NSString stringWithFormat:@"%@",date]isEqualToString:dateString])
		{
			tile1.checkmarked=YES;
			return tile1;
			
		}
			else 
		{
		
			tile1.checkmarked=NO;	
		}

	
	}
	
	
	return tile1;
	
}

- (void)didChangeMonths
{
	
    UIView *clip = calendarView.superview;
    if (!clip)
        return;
    
    CGRect f = clip.frame;
    NSInteger weeks = [calendarView selectedMonthNumberOfWeeks];
    CGFloat adjustment = 0.f;
    
    switch (weeks) {
        case 4:
            adjustment = (92/321)*360+30;
            break;
        case 5:
            adjustment = (46/321)*360;
            break;
        case 6:
            adjustment = 0.f;
            break;
        default:
            break;
    }
    f.size.height = 360 - adjustment;
    clip.frame = f;
	
	tile = nil;
}


//
//-(void)setBackgroundtappedTile:(KLTile *)aTile
//{
//	
//	aTile.backgroundColor=[UIColor blueColor];
//	//]flag=TRUE;
//
//}
//
//-(void)restorebackground:(KLTile *)aTile
//{
//	aTile.backgroundColor=[UIColor clearColor];
//}




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


- (void)dealloc 
{
    [super dealloc];
	[SelectedDate_Ary release];
}


@end
