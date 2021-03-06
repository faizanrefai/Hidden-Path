//
//  Facebook.m
//  TABBAR
//
//  Created by openxcell technolabs on 6/23/11.
//  Copyright 2011 jn. All rights reserved.
//

#import "Facebook.h"
#import "Homepage.h"


@implementation Facebook
@synthesize show_nvg;

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
	
	self.title=@"Facebook";
	//if(!show_nvg)
//	{
//		nvg_bar.hidden=YES;
//		//wbview_facebook=[[UIWebView alloc]initWithFrame:CGRectMake(05, 25, 450, 280)];
//		[self.view addSubview:wbview_facebook];
//	}
	
	indicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(125, 160, 200, 200)];
	indicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
	[indicator sizeToFit];
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(btn_homepage_clicked:)];
	
	[wbview_facebook addSubview:indicator];
	wbview_facebook.delegate=self;
	[indicator startAnimating];
	
	NSString *urlpath=[NSString stringWithFormat:@"http://www.facebook.com/pages/Hidden-Path-Book-and-Journal/114571498565661"];
	NSURL *url=[NSURL URLWithString:urlpath];
	NSURLRequest *obj_request=[NSURLRequest requestWithURL:url];
	[wbview_facebook loadRequest:obj_request];
		 
	wbview_facebook.scalesPageToFit=YES;
			
	
							   
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	[indicator stopAnimating];
}
-(IBAction)btn_homepage_clicked:(id)sender
{
	//Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
//	[self.navigationController pushViewController:obj_home animated:YES];		
//	[self.view addSubview:obj_home.view];
//	[self.view removeFromSuperview];
	Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
	[self.navigationController presentModalViewController:obj_home animated:NO];

		
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
