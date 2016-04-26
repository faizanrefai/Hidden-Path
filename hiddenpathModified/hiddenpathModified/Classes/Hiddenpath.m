//
//  Hiddenpath.m
//  TABBAR
//
//  Created by openxcell technolabs on 7/1/11.
//  Copyright 2011 jn. All rights reserved.
//

#import "Hiddenpath.h"
#import "Homepage.h"
#import <QuartzCore/QuartzCore.h>
#import "DatabaseMethod.h"


@implementation Hiddenpath
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
	
	self.navigationItem.title=@"Register";
	obj_AppDelegate=(TABBARAppDelegate *)[[UIApplication sharedApplication]delegate];
	obj_databasemethod=[[DatabaseMethod alloc]init];
	textview.layer.cornerRadius=5.0;
	textview.backgroundColor=[UIColor clearColor];
	textview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	txt_mobile.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	txt_password.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	txt_username.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];
	txt_email.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBK.png"]];

	MainScrollview.contentSize=CGSizeMake(320, 500);


	btn_cancel.layer.cornerRadius=12.0;
	btn_Registration.layer.cornerRadius=12.0;

}
-(IBAction)btn_homepage_clicked:(id)sender
{
	[self.view removeFromSuperview];
	
}
-(IBAction)btn_cancel_clicked:(id)sender
{
	txt_password.text=@"";
	txt_username.text=@"";
	textview.text=@"";
	txt_mobile.text=@"";
	lbl_counter.hidden=YES;
	[txt_password resignFirstResponder];
	[txt_username resignFirstResponder];
	[txt_mobile resignFirstResponder];
	
	[self.view removeFromSuperview];
}

-(IBAction)btn_Registration_clicked:(id)sender
{
	
    
    

	
	
	NSMutableArray *usename_Ary=[obj_databasemethod RandomDataSerching_FromLogin];

	if([txt_password.text isEqualToString:@""] &&[txt_username.text isEqualToString:@""])
	{
		alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Enter username and Password" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
		[alert show];
		[alert release];
		
	}
	else if([txt_password.text isEqualToString:@""])
		{
			alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Enter the Password" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
			[alert show];
			[alert release];
			
			
			
		}
	else if([txt_username.text isEqualToString:@""]) 
		{
			alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Enter the Username" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
			[alert show];
			[alert release];
			
			
		}
	else
	{
		BOOL isavailable=FALSE;
		
		for(NSString *str in usename_Ary)
		{
			if([str isEqualToString:txt_username.text])
			{
				//isavailable=TRUE;
				isavailable=FALSE;
			}
			
		}
		if(isavailable)
		{
			alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"This User Alerady Registration" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
			[alert show];
			[alert release];
		
		}
		else{
			
			if([self validateEmail:[txt_username  text]] ==1){
				NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
				[dict setObject:txt_password.text forKey:@"password"];
				[dict setObject:textview.text forKey:@"Address"];
				[dict setObject:txt_username.text forKey:@"username"];
				[dict setObject:txt_mobile.text forKey:@"mobile"];
				[dict setObject:txt_email.text forKey:@"email"];
				
                // Start Web service Calling
                
                [AlertHandler showAlertForProcess];
                
                NSString *registrationWS = [NSString stringWithFormat:@"http://openxcellaus.info/hiddenpath/user_action.php?action=registration&vEmail=%@&vPassword=%@",txt_username.text,txt_password.text];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:registrationWS]];
           JSONParser*     parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsingResponse:) andHandler:self];
                
                [obj_databasemethod insertdata_IntoLoginTable:dict];

				
			}
			else{
				UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"You Enter Incorrect Email id." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
				[alert2 show];
				[alert2 release];
			}	
			
		

		}
		
		
	}

	[usename_Ary release];
} 



-(void)parsingResponse:(NSDictionary*)dictio{

    [AlertHandler hideAlert];

    
    NSLog(@"%@",dictio);
    
    
    
    if ([[dictio valueForKey:@"msg"]isEqualToString:@"Email exists"]) {
      
        alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"This User Alerady Registered" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [alert show];
        [alert release];
  
    }else{
    
        [[NSUserDefaults standardUserDefaults]setValue:[dictio valueForKey:@"iUserId"] forKey:@"userID"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        

        
    alert=[[UIAlertView alloc]initWithTitle:@"Thank you" message:@"Your registration was successfully completed." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
    [alert show];
    [alert release];
    [self.view removeFromSuperview];
    }

}

//-(BOOL)isEmailValid:(NSString *)email {
//    
//    BOOL isValid = YES;
//    
//    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    
//    GTMRegex *regex = [GTMRegex regexWithPattern:emailRegEx];
//    
//    if(([regex matchesString:email]) == YES){
//        
//        NSLog(@"Registration Form: You have entered valid email address %@", email); 
//        
//    }
//    
//    else {
//        
//        NSLog(@"Registration Form: You have entered INVALID email address %@", email); 
//        
//        isValid = NO;
//        
//    }
//    
//    return isValid;
//    
//}

 //-------- TEXT FIELD IN PROGRESS ----------------------------
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[MainScrollview setContentOffset:CGPointMake(0, 0) animated:YES];

	[txt_mobile resignFirstResponder];
	[textview resignFirstResponder];
	[txt_username resignFirstResponder];
	[txt_password resignFirstResponder];
}
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	//	return 0;
    return [emailTest evaluateWithObject:candidate];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if([textField isEqual:txt_email])
	{
		
		if([self validateEmail:[txt_email text]] ==1)
		{
			UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"You Enter Correct Email id." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
			[alert2 show];
			[alert2 release];
			
		}
		else
		{
			UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"You Enter Incoorect Email id." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
			[alert2 show];
			[alert2 release];
		}	
		
		
	}
	if([textField isEqual:txt_password])
	{
		lbl_counter.hidden=FALSE;
	}
	
	[MainScrollview setContentOffset:CGPointMake(0, 0) animated:YES];
	
	[textField resignFirstResponder];
	
	return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	
	
	 if([textField isEqual:txt_password])
	{
		[MainScrollview setContentOffset:CGPointMake(0, 0) animated:YES];
		lbl_counter.hidden=YES;
	}
	else if([textField isEqual:txt_email])
	{
		[MainScrollview setContentOffset:CGPointMake(0, 0) animated:YES];

	}
	
	lbl_counter.hidden=FALSE;
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	// return NO to not change text
	
	
	if([textField isEqual:txt_password])
	{
		lbl_counter=[[UILabel alloc]initWithFrame:CGRectMake(143, 155, 120, 13)];
		lbl_counter.font=[UIFont fontWithName:@"Arial"size:12];
		lbl_counter.layer.cornerRadius=5.0;
		lbl_counter.backgroundColor=[UIColor clearColor];
		//int k=[NSString stringWithFormat:@"%d",[txt_password.text length]];
		int k =[txt_password.text length];
		
		if(k!=0)
		{
			if([textField isEqual:txt_password])
			{
				
				if(k<6)
				{
					lbl_counter.text=@"Week Password";
					lbl_counter.backgroundColor=[UIColor redColor];
					lbl_counter.textAlignment=UITextAlignmentCenter;
					[MainScrollview  addSubview:lbl_counter];
				}
				else if(k>=6 && k<9) 
				{
					lbl_counter.text=@"Medium Password";
					lbl_counter.backgroundColor=[UIColor yellowColor];
					lbl_counter.textAlignment=UITextAlignmentCenter;
					[MainScrollview addSubview:lbl_counter];
				}
				
				else if(k>=9)
				{
					lbl_counter.text=@"Strong Password";
					lbl_counter.backgroundColor=[UIColor greenColor];
					lbl_counter.textAlignment=UITextAlignmentCenter;
					[MainScrollview addSubview:lbl_counter];
				}
			}
		}
	}
	
	return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	//[MainScrollview setContentOffset:CGPointMake(0, 100) animated:YES];
	return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if ( [text isEqualToString: @"\n"] ) 
	{
		[MainScrollview setContentOffset:CGPointMake(0, 0) animated:YES];
		[textView resignFirstResponder];
	}
		
	return YES;
	
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
