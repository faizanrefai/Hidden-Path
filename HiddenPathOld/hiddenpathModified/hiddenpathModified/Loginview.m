//
//  Loginview.m
//  TABBAR
//
//  Created by openxcell technolabs on 8/4/11.
//  Copyright 2011 jn. All rights reserved.
//

#import "Loginview.h"
#import "DatabaseMethod.h"
#import "Hiddenpath.h"
#import "Homepage.h"
#import "JSONParser.h"
#import "AlertHandler.h"
#import <QuartzCore/QuartzCore.h>


@implementation Loginview
@synthesize rememberMeBtn;
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
	obj_AppDelegate=(TABBARAppDelegate *)[[UIApplication sharedApplication]delegate];

	obj_databasemethod=[[DatabaseMethod alloc]init];
	
	txt_password.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	user_name.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	
	btn_Registration.layer.cornerRadius=12.0;
    btn_forgot.layer.cornerRadius=12.0;
    btn_forgot.layer.masksToBounds=YES;
    btn_login.layer.cornerRadius=12.0;
	
    scroll.contentSize=CGSizeMake(320, 500);

    tbl_login=[[UITableView alloc] initWithFrame:CGRectMake(150, 196, 120, 25) style:UITableViewStylePlain];
    tbl_login.delegate=self;
    tbl_login.dataSource=self;
    tbl_login.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
    [self.view addSubview:tbl_login];
    
    Ary_Data=[[NSMutableArray alloc] init];
    Ary_filter=[[NSMutableArray alloc]init];
    tbl_login.hidden=true;
    
	if (obj_AppDelegate.isRememberLogin) {
		user_name.text = obj_AppDelegate.loginIdStr;
		rememberMeBtn.selected = TRUE;
	}
	
	//forscrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 46, 320, 460)];
//	forscrollview.delegate=self;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (obj_AppDelegate.isRememberLogin) {
		user_name.text = obj_AppDelegate.loginIdStr;
	}
    
    Ary_Data=[obj_databasemethod Serching_FromLogin];
    
    
    tbl_login.frame=CGRectMake(150, 196, 120, 25);
	[tbl_login reloadData];
}

-(IBAction)RememberMe
{
	if (rememberMeBtn.selected == NO) {
		rememberMeBtn.selected = YES;
		obj_AppDelegate.loginIdStr = user_name.text;
		obj_AppDelegate.isRememberLogin = TRUE;
		//[rememberMeBtn setImage:[UIImage imageNamed:@"selectedPoint.png"] forState:UIControlStateNormal];
	}
	else {
		rememberMeBtn.selected = NO;
		obj_AppDelegate.isRememberLogin = FALSE;
		obj_AppDelegate.loginIdStr = @"";
		//[rememberMeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
	}
	 
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

///---------------------============ custome Tableview ===============----------


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [Ary_filter count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *Cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    //   if (Cell == nil) 
	//{
    Cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    //}
	
    
	[Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    Cell.textLabel.text=[Ary_filter objectAtIndex:indexPath.row];
    Cell.textLabel.font=[UIFont fontWithName:@"Georgia" size:14.0];
	
    return  Cell;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 25;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;      
{// Default is 1 if not implemented
    
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    user_name.text=[Ary_filter objectAtIndex:indexPath.row];
    
    tbl_login.hidden=YES;
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	
    if([textField isEqual:user_name])
    {
        NSString *substring = [NSString stringWithString:textField.text];
        substring = [substring stringByReplacingCharactersInRange:range withString:string];
        [self searchAutocompleteEntriesWithSubstring:substring];
    }
	return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    if([textField isEqual:user_name])
    {
        tbl_login.hidden=NO;
    }
    

    return YES;
}

- (void) finishedSearching 
{
	[user_name resignFirstResponder];
	tbl_login.hidden = YES;
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
	
	// Put anything that starts with this substring into the autoCompleteArray
	// The items in this array is what will show up in the table view
	
	[Ary_filter removeAllObjects];
    
	for(NSString *curString in Ary_Data) {
		NSRange substringRangeLowerCase = [curString rangeOfString:[substring lowercaseString]];
		NSRange substringRangeUpperCase = [curString rangeOfString:[substring uppercaseString]];
        
		if (substringRangeLowerCase.length != 0 || substringRangeUpperCase.length != 0) 
        {
			[Ary_filter addObject:curString];
		}
        
    }
	int l=[Ary_filter count];
    tbl_login.frame=CGRectMake(150, 196, 120, 25*l);
	tbl_login.hidden = NO;
	[tbl_login reloadData];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	tbl_login.hidden=YES;
	
	if([textField isEqual:txt_mo])
	{
		
		if([self validateEmail:[txt_mo text]] ==1)
		{
//			UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"You Enter Correct Email id." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//			[alert2 show];
//			[alert2 release];
						
		}
		else
		{
			UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You Entered Incorect Email id." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
			[alert2 show];
			[alert2 release];
		}	
		
		
	}
	return YES;
}

-(IBAction)forGopassword:(id)sender;
{
		
	ForgotView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	UIImageView *bg_imgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	//ForgotView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"path.png"]];
	bg_imgView.image =[UIImage imageNamed:@"path.png"];
	[ForgotView addSubview:bg_imgView];
	[self.view addSubview:ForgotView];
	[bg_imgView release];
	
	UILabel *mainlbl=[[UILabel alloc]initWithFrame:CGRectMake(00, 0, 320, 45)];
	mainlbl.backgroundColor=[UIColor blackColor];
	mainlbl.textColor=[UIColor whiteColor];
	mainlbl.font=[UIFont fontWithName:@"Georgia-Bold" size:17.0];	
	mainlbl.shadowColor=[UIColor whiteColor];
	mainlbl.textAlignment=UITextAlignmentCenter;
	mainlbl.alpha=0.70;
	
	mainlbl.text=@"Get Password !!!";
	[ForgotView addSubview:mainlbl];
	
	UILabel *lbl_mo=[[UILabel alloc] initWithFrame:CGRectMake(50, 150, 120, 28)];
	lbl_mo.text=@"Email Id ";
	lbl_mo.backgroundColor=[UIColor clearColor];
	lbl_mo.highlightedTextColor=[UIColor clearColor];
	lbl_mo.textColor=[UIColor darkTextColor];
	lbl_mo.font=[UIFont fontWithName:@"Georgia-Bold" size:17.0];
	//lbl_mo.font=[UIFont boldSystemFontOfSize:17.0];
	lbl_mo.shadowColor=[UIColor whiteColor];
	
	txt_mo=[[UITextField alloc] initWithFrame:CGRectMake(145, 150, 135, 28)];
	txt_mo.delegate=self;
	txt_mo.borderStyle=UITextBorderStyleBezel;
	txt_mo.font=[UIFont fontWithName:@"Georgia" size:15.0];
	txt_mo.keyboardType=UIKeyboardTypeEmailAddress;
	txt_mo.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	txt_mo.placeholder=@"Enter Email Id";
	
	[ForgotView addSubview:txt_mo];
	[ForgotView addSubview:lbl_mo];
	
	UILabel *lbl_usrname=[[UILabel alloc]initWithFrame:CGRectMake(50, 110, 115, 28)];
	lbl_usrname.text=@"UserName";
	lbl_usrname.backgroundColor=[UIColor clearColor];
	lbl_usrname.textColor=[UIColor darkTextColor];
	lbl_usrname.font=[UIFont fontWithName:@"Georgia-Bold" size:17.0];
	lbl_usrname.shadowColor=[UIColor whiteColor];
	
	
	txt_usr=[[UITextField alloc] initWithFrame:CGRectMake(145, 110, 135, 28)];
	txt_usr.delegate=self;
	txt_usr.borderStyle=UITextBorderStyleBezel;
	txt_usr.font=[UIFont fontWithName:@"Georgia" size:13.0];
	txt_usr.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];

	txt_usr.placeholder=@"Enter Username ";
	
	//[ForgotView addSubview:txt_usr];	
	//[ForgotView addSubview:lbl_usrname];
	
	UIButton *btn_Accept=[UIButton buttonWithType:UIButtonTypeCustom];
	[btn_Accept setTitle:@"Submit" forState:UIControlStateNormal];
	btn_Accept.backgroundColor=[UIColor darkTextColor];
	btn_Accept.alpha=0.84;
	btn_Accept.layer.cornerRadius=12.0;
	[btn_Accept setFrame:CGRectMake(65, 200, 84, 35)];
	[btn_Accept setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[btn_Accept setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[btn_Accept addTarget:self action:@selector(btn_AcceptedClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn_Accept setFont:[UIFont fontWithName:@"Georgia-Bold" size:16.0]];
	
	UIButton *btn_Cancel=[UIButton buttonWithType:UIButtonTypeCustom];
	[btn_Cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [btn_Cancel setFont:[UIFont fontWithName:@"Georgia-Bold" size:16.0]];
	btn_Cancel.layer.cornerRadius=12.0;
	btn_Cancel.backgroundColor=[UIColor darkTextColor];
	[btn_Cancel setFrame:CGRectMake(175, 200, 84, 35)];
    
	//[btn_Cancel setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[btn_Cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btn_Cancel.alpha=0.84;
	[btn_Cancel addTarget:self action:@selector(btn_CanceltedClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	[ForgotView addSubview:btn_Cancel];
	[ForgotView addSubview:btn_Accept];
		
	
	obj_AppDelegate.isforgot=TRUE;
	
	//select  password from Login where username ='unm' and mobile='45456'
}
-(IBAction)btn_CanceltedClicked:(id)sender
{
	[ForgotView removeFromSuperview];
}
-(IBAction)btn_AcceptedClicked:(id)sender
{	
	[txt_mo resignFirstResponder];
	[txt_usr resignFirstResponder];
	NSString *spassword =@"";
	spassword=[obj_databasemethod ForgotPasswordAndUsername:txt_usr.text mobile:txt_mo.text];

	if(![spassword isEqualToString:@""])
	{
		[AlertHandler showAlertForProcess];
		NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://openxcellaus.info/hiddenpath/email_password.php?email=%@&password=%@",txt_mo.text,spassword]]];
		JSONParser *parser = [[JSONParser alloc] initWithRequestForThread:request sel:@selector(searchResult:) andHandler:self];
		
		//[parser release];
		
	}
	else {
		
			
		alertinvalid=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid email address" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
			[alertinvalid show];
			[alertinvalid release];
	}


}
-(void)searchResult:(NSDictionary*)dictionary{
	[AlertHandler hideAlert];
	alertvalid=[[UIAlertView alloc]initWithTitle:@"Info" message:[ NSString stringWithFormat:@"Your Password sent to %@",txt_mo.text] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertvalid show];
	[alertvalid release];
	

}

- (BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	//	return 0;
    return [emailTest evaluateWithObject:candidate];
}

-(IBAction)btn_login_clicked:(id)sender
{
	
    
    if([self validateEmail:[user_name text]] ==1)
    {
       // UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"You Enter Correct Email id." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
       // [alert2 show];
     //   [alert2 release];
        
        if (obj_AppDelegate.isRememberLogin) {
			obj_AppDelegate.loginIdStr = user_name.text;
		}
        
        
        BOOL iscurrect=[obj_databasemethod UserNameAndPasswordSerching_FromLogin:user_name.text passwordString:txt_password.text];
        
        if(iscurrect)
		{
            
            //	alert=[[UIAlertView alloc]initWithTitle:@"Alert !" message:@" You have successful Login"delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			
            txt_password.text=@"";
            user_name.text=@"";
            //[alert show];
            //[alert release];
            Homepage *obj_homepage=[[Homepage alloc]initWithNibName:@"Homepage" bundle:nil];
            [self.view removeFromSuperview];
            //[self dismissModalViewControllerAnimated:YES];
            if(!obj_AppDelegate.islogout)
            {
                [obj_AppDelegate.window addSubview:obj_homepage.view];
            }
		}
		else 
		{
			alert=[[UIAlertView alloc]initWithTitle:@"Error !" message:@"Incorrect username / password"delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			
            [alert show];
            [alert release];
            
            
            user_name.placeholder=@"Enter Username";
            txt_password.placeholder=@"Enter Password";
            
            
		}

        
    }
    else
    {
       
        if(![user_name.text isEqualToString:@""])
        {
            UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You Entered Incorect Email id." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert2 show];
        [alert2 release];
        }
        else
        {
            alert=[[UIAlertView alloc]initWithTitle:@"Error !" message:@"Enter the Correct Username And Password"delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			
            [alert show];
            [alert release];
            
            
            
        }
            
    }	
    
    [txt_password resignFirstResponder];
	[user_name resignFirstResponder];
	
	
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	txt_password.text=@"";
	user_name.text=@"";
	if(alertvalid ==alertView)
	[ForgotView removeFromSuperview];

	
}
-(IBAction)Reset_clicked:(id)sender
{
	txt_password.text=@"";
	user_name.text=@"";
	[txt_password resignFirstResponder];
	[user_name resignFirstResponder];
}

-(IBAction)btn_Registration_clicked:(id)sender
{
	[txt_password resignFirstResponder];
	[user_name resignFirstResponder];
	Hiddenpath *obj_hidden=[[Hiddenpath alloc]initWithNibName:@"Hiddenpath" bundle:nil];
	[self.view addSubview:obj_hidden.view];

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
