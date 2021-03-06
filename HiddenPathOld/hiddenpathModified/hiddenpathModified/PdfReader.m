//
//  PdfReader.m
//  TABBAR
//
//  Created by openxcell technolabs on 6/22/11.
//  Copyright 2011 jn. All rights reserved.
//

#import "PdfReader.h"
#import "Homepage.h"


@implementation PdfReader
@synthesize Pdf_webview;
@synthesize show_nvgbar;



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
	self.navigationItem.title=@"Hiddenpath Book";
	
	//if(!show_nvgbar)
//	{
//		nvgBar.hidden=YES;
//		//Pdf_webview=[[UIWebView alloc]initWithFrame:CGRectMake(05, 10, 460, 290)];
//		[self.view addSubview:Pdf_webview];
//	}
//	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonSystemItemFastForward  target:self action:@selector(btn_Home_clicked:)];
//	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(Save)];

	//self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(btn_EditClicked:)];
	
	NSString *filepath=[[NSBundle mainBundle]pathForResource:@"HiddenPathBook" ofType:@"pdf"];
						
	NSURL *urlpdf=[NSURL fileURLWithPath:filepath];
	NSURLRequest *obj_request=[NSURLRequest requestWithURL:urlpdf];
	[Pdf_webview loadRequest:obj_request];
}

-(void) viewWillAppear:(BOOL)animated
{
	//if(!isPush)
//	{
//		//home_btn=[[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonSystemItemFastForward  target:self action:@selector(btn_EditClicked_home:)];
//		self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonSystemItemFastForward  target:self action:@selector(btn_Home_clicked:)];
//	}
//	else 
//	{
//		
//		self.navigationItem.leftBarButtonItem=nil;	
//		self.navigationItem.rightBarButtonItem.enabled=YES;
//	}
	
}


-(IBAction)btn_Home_clicked:(id)sender
{
	Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
	[self.navigationController presentModalViewController:obj_home animated:NO];
	
	//Homepage *obj_home=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
//	[self.navigationController pushViewController:obj_home animated:YES];		
//	[self.view addSubview:obj_home.view];
//	[self.view removeFromSuperview];
//	
//	[PdfReader release];	
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
