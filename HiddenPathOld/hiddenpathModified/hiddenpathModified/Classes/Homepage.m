//
//  Homepage.m
//  TABBAR
//
//  Created by openxcell technolabs on 6/20/11.
//  Copyright 2011 jn. All rights reserved.
//

#import "Homepage.h"
#import "PdfReader.h"
#import "Facebook.h"
#import "Twiter.h"
#import "TABBARAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "Hiddenpath.h"
#import "Loginview.h"
#import "Exercise.h"
#import "Affirmation.h"
#import "todolist.h"
#import "Goal.h"
#import "Gratitude.h"

@implementation Homepage
@synthesize nvgContrl,nvg_Barstyle;
@synthesize background;


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
- (void)viewDidLoad {
    [super viewDidLoad];
         

	obj_delegate=(TABBARAppDelegate *)[[UIApplication sharedApplication]delegate];
	obj_delegate.tabBarController.tabBar.hidden=YES;
	obj_databasemethod=[[DatabaseMethod alloc]init];
		
//	btn_imagin.transform=CGAffineTransformMakeRotation(-120);
//	btn_imagin.transform=CGAffineTransformRotate(CGAffineTransformIdentity,-120);
//	btn_imagin.transform=CGAffineTransformMakeScale(2.0, 2.1);
	
	
	btn_Logout.layer.cornerRadius=12.0;
	

}
-(IBAction)btn_Loginpage_clicked:(id)sender
{
	[self btn_Logout_clicked:sender];
}

-(IBAction)btn_Logout_clicked:(id)sender;
{
	txt_password.text=@"";
	txt_username.text=@"";
	
	
	Loginview *obj_loginpage=[[Loginview alloc]initWithNibName:@"Loginview" bundle:nil];
	
//	[obj_delegate.window addSubview:obj_loginpage.view];
	
	[self.view addSubview:obj_loginpage.view];
	obj_delegate.islogout=TRUE;
	//[self presentModalViewController:obj_loginpage animated:YES];
	
	//[self.view bringSubviewToFront:obj_loginpage.view];
	
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	lbl_counter.hidden=YES;
	//if([textField isEqual:txt_password])
//	{
//		txt_password.text=@"";
//	}
//	if([textField isEqual:txt_username])
//	{
//	txt_username.text=@"";	
//	}

	
	return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
		
   	[textField resignFirstResponder];
	return YES;
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    lbl_counter=[[UILabel alloc]initWithFrame:CGRectMake(25, 260, 100, 25)];
//	lbl_counter.text = [NSString stringWithFormat:@"Characters: %d / 200",[txt_password.text length]];
//	[loginview addSubview:lbl_counter];
//    return YES;
//}
//================ Login ===================== 

-(IBAction)btn_EditClicked:(id)sender
{
}
//------Gratitude btn is bellow ----------------
-(IBAction)btn_clicked:(id)sender
{
	Gratitude *obj_grat=[[Gratitude alloc]initWithNibName:@"Gratitude" bundle:nil];
	obj_grat.show_nvg=FALSE;
	[self.view addSubview:obj_grat.view];
}
 
-(IBAction)btn_Goal_clicked:(id)sender{	
	Goal *obj_goal=[[Goal alloc]initWithNibName:@"Goal" bundle:nil];
	obj_goal.show_nvg=FALSE;
	[self.view addSubview:obj_goal.view];
	
}
-(IBAction)btn_todolist_clicked:(id)sender
{
	todolist *obj_todo=[[todolist alloc]initWithNibName:@"todolist" bundle:nil];
	obj_delegate.fromHome = FALSE;
	[self.view addSubview:obj_todo.view];	 
	
}
-(IBAction)btn_Journal_clicked:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
	obj_delegate.tabBarController.selectedIndex=0;
	obj_delegate.tabBarController.tabBar.hidden=NO;
	[self.view removeFromSuperview];
	 
}

-(IBAction)btn_pdffile_clicked:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
	obj_delegate.tabBarController.selectedIndex=1;
	obj_delegate.tabBarController.tabBar.hidden=NO;
	[self.view removeFromSuperview];
	
	
	
}

-(IBAction)btn_more_clicked:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
	obj_delegate.tabBarController.selectedIndex=4;
	obj_delegate.tabBarController.tabBar.hidden=NO;
	[self.view removeFromSuperview];
	
}
-(IBAction)btn_facebook_clicked:(id)sender
{
	
	[self dismissModalViewControllerAnimated:YES];
	obj_delegate.tabBarController.selectedIndex=3;
	obj_delegate.tabBarController.tabBar.hidden=NO;
	[self.view removeFromSuperview];
	
}
-(IBAction)btn_twitter_clicked:(id)sender
{
	Twiter *obj_twitter=[[Twiter alloc]initWithNibName:@"Twiter" bundle:nil];
	obj_twitter.show_nvg=TRUE;
	[self.view addSubview:obj_twitter.view];
}


-(IBAction)btn_exercise_clicked:(id)sender
{
	
	[self dismissModalViewControllerAnimated:YES];
	obj_delegate.tabBarController.selectedIndex=2;
	obj_delegate.tabBarController.tabBar.hidden=NO;
	[self.view removeFromSuperview];
	
		
}
-(IBAction)btn_aff_clicked:(id)sender
{
	Affirmation *obj_exe=[[Affirmation alloc]initWithNibName:@"Affirmation" bundle:nil];
	obj_exe.show_nvgbar=TRUE;
	[self.view addSubview:obj_exe.view];
	
	
}
// Override to allow orientations other than the default portrait orientation.
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    // Return YES for supported orientations.
//  //
//	return ( (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
//	}

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
	[loginview release];

}


@end
