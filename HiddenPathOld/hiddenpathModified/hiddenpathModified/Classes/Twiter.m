//
//  Twiter.m
//  TABBAR
//
//  Created by openxcell technolabs on 6/23/11.
//  Copyright 2011 jn. All rights reserved.
//

#import "Twiter.h"
#import "Homepage.h"


@implementation Twiter
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
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title=@"Twitter";
	
	if(!show_nvg)
	{
		nvg_bar.hidden=YES;
		//web_twiter=[[UIWebView alloc]initWithFrame:CGRectMake(05, 25, 450, 280)];
		[self.view addSubview:web_twiter];
	}
	
	
	
	indicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(120, 160, 200, 200)];
	indicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
	[indicator sizeToFit];
	
	[web_twiter addSubview:indicator];
	[indicator startAnimating];
	web_twiter.delegate=self;
	
	NSString *urlAddress=[NSString stringWithFormat:@"http://www.twitter.com"];
	NSURL *url=[NSURL URLWithString:urlAddress];
	NSURLRequest *obj_request=[NSURLRequest requestWithURL:url];
	[web_twiter loadRequest:obj_request];
			   
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	[indicator stopAnimating];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


-(IBAction)btn_homepage_clicked:(id)sender
{
	Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
	[self.navigationController pushViewController:obj_home animated:YES];		
	[self.view addSubview:obj_home.view];
	[self.view removeFromSuperview];
	
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
