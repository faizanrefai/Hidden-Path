//
//  DatabaseMethod.m
//  TABBAR
//
//  Created by openxcell technolabs on 7/20/11.
//  Copyright 2011 jn. All rights reserved.
//

#import "DatabaseMethod.h"
#import "FirstViewController.h"


@implementation DatabaseMethod


- (id)initWithFrame:(CGRect)frame 
{
    
	obj_AppDelegate=(TABBARAppDelegate *)[[UIApplication sharedApplication]delegate];
	obj_firstview=[[FirstViewController alloc]init];
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}
//----------------------------------------------------------------------------------------------------
//------------------ Database Process of Loginvew  ---------------------------------------------------
//----------------------------------------------------------------------------------------------------
-(NSMutableArray *)Serching_FromLogin
{
    NSMutableArray *Ary_temp=[[NSMutableArray alloc] init];
    NSString *Username;

    path=[obj_AppDelegate  getdatabasepath];
	[obj_AppDelegate CheckedAndCreateDatabase];
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		//NSString  *sqlQuery = [NSString stringWithFormat:@"select username from Login"];
		//select password  from Login where username='admin';
        
        const char *sqlQuery = "select username from Login";

		
		sqlite3_stmt *statement1;
		statement1 = nil;
		
        if(sqlite3_prepare_v2(database,sqlQuery , -1, &statement1, NULL) == SQLITE_OK) 
		{
			
			while (sqlite3_step(statement1)==SQLITE_ROW) 
			{
				
				Username  = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement1, 0)];
				NSLog(@"username is -  %@",Username);
							
                
                [Ary_temp addObject:Username];
			}
        }		
		else
		{
			NSAssert1(0, @"Error while Searching  statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement1);
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	
	
	return Ary_temp;


    
}
-(BOOL)UserNameAndPasswordSerching_FromLogin:(NSString *)username passwordString:(NSString *)password;
{
	BOOL isSuccess=FALSE;
	
	path=[obj_AppDelegate  getdatabasepath];
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		NSString  *sql1 = [NSString stringWithFormat:@"select * from Login where username='%@'",username];
		//select password  from Login where username='admin';
		
		sqlite3_stmt *statement;
		statement = nil;
		
        if(sqlite3_prepare_v2(database, [sql1 UTF8String], -1, &statement, NULL) == SQLITE_OK) 
		{
			
			
			while (sqlite3_step(statement)==SQLITE_ROW) 
			{
				
				str_username   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
				NSLog(@"username is -  %@",str_username);
				str_password = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
				NSLog(@"password is - %@",str_password);
				
				if([password isEqualToString:str_password])
				{
					isSuccess=TRUE;
				}
				
			}
        }		
		else
		{
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	return isSuccess;
	
	
}

-(NSString *)ForgotPasswordAndUsername:(NSString *)user mobile:(NSString *)mob
{
	NSString *strpassword =@"" ;
	path=[obj_AppDelegate  getdatabasepath];
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		NSString  *sql1 = [NSString stringWithFormat:@"select  password from Login where username='%@' and email='%@'",mob,@"email"];
		
		//select password  from Login where username='admin';
		
		sqlite3_stmt *statement;
		statement = nil;
		
        if(sqlite3_prepare_v2(database, [sql1 UTF8String], -1, &statement, NULL) == SQLITE_OK) 
		{
			
			
			while (sqlite3_step(statement)==SQLITE_ROW) 
			{
				
				//str_username   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
				strpassword = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
				
				
			}
        }		
		else
		{
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	if(![strpassword isEqualToString:@""])
	return strpassword;
	else 
	 {
		return @"";
	}

	
	
}
//----------------------------------------------------------------------------------------------------
//------------------ Database Process of Calender view  in Mastertable -------------------------------
//----------------------------------------------------------------------------------------------------

-(NSMutableDictionary  *)RandomDataSerching_FromMasterTableForJournalPage:(NSString *)date
{
	NSMutableDictionary *Dic_Ary=[[NSMutableDictionary alloc]init];
	NSMutableArray *arr_todo=[[NSMutableArray alloc]init];
	NSMutableArray *arr_goal=[[NSMutableArray alloc]init];
	NSMutableArray *arr_grati=[[NSMutableArray alloc]init];
	NSMutableArray *arr_affirmation=[[NSMutableArray alloc]init];
	NSString *str_date=@"";
	NSString *info=@"";
	NSString *Que=@"";
	
	NSString *t1,*t2,*g1,*g2,*a1,*a2,*a3,*gr1,*gr2;

	
	
	path=[obj_AppDelegate getdatabasepath];
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		//const char *sql1 = "select * from MasterTable where ";
		NSString  *sql1 = [NSString stringWithFormat:@"select * from MasterTable where selecteddate='%@'",date];

		sqlite3_stmt *statement;
		statement = nil;
		
        if(sqlite3_prepare_v2(database, [sql1 UTF8String], -1, &statement, NULL) == SQLITE_OK) 
		{
			
			
			while (sqlite3_step(statement)==SQLITE_ROW) 
			{
				
				str_date= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
				NSLog(@"str_date --- %@",str_date);
				
				gr1= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
				gr2= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
				NSLog(@"gr1 --- %@",gr1);
				NSLog(@"gr2 --- %@",gr2);

				a3= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
				a1= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
				a2= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
				
				NSLog(@"a1 --- %@",a1);
				NSLog(@"a2 --- %@",a2);
				NSLog(@"a3 --- %@",a3);
				
				g1= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
				g2= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
				NSLog(@"g1 --- %@",g1);
				NSLog(@"g2 --- %@",g2);
				

				t1= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 11)];
				t2= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 12)];
				NSLog(@"t1 --- %@",t1);
				NSLog(@"t2 --- %@",t2);

				
				
				
				Que= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
				info= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
				NSLog(@"Que --- %@",Que);
				NSLog(@"info --- %@",info);


				[arr_goal addObject:g1];
				[arr_goal addObject:g2];
				[arr_grati addObject:gr1];
				[arr_grati addObject:gr2];
				[arr_todo addObject:t1];
				[arr_todo addObject:t2];
				[arr_affirmation addObject:a1];
				[arr_affirmation addObject:a2];
				[arr_affirmation addObject:a3];
								
			}
			[Dic_Ary setObject:arr_goal forKey:@"goal"];
			[Dic_Ary setObject:arr_affirmation forKey:@"affirmation"];
			[Dic_Ary setObject:arr_grati forKey:@"gratitude"];
			[Dic_Ary setObject:arr_todo forKey:@"todolist"];
			[Dic_Ary setObject:info forKey:@"info"];
			[Dic_Ary setObject:Que forKey:@"que"];
			
        }		
		else
		{
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	
	
	sqlite3_close(database);
	
	return Dic_Ary;
	
	
}

-(NSMutableArray *)RandomDataSerching_FromMasterTable
{
	NSMutableArray *Selecteddate_Ary=[[NSMutableArray alloc]init];
	NSString *str_date;
	
	path=[obj_AppDelegate getdatabasepath];
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		const char *sql1 = "select selecteddate from MasterTable";
		
		sqlite3_stmt *statement;
		statement = nil;
		
        if(sqlite3_prepare_v2(database, sql1, -1, &statement, NULL) == SQLITE_OK) 
		{
			
			
			while (sqlite3_step(statement)==SQLITE_ROW) 
			{
				
				 str_date= [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
				NSLog(@"str_date-----******----- %@",str_date);
				[Selecteddate_Ary  addObject:str_date];
			
			}
        }		
		else
		{
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	
	
	sqlite3_close(database);
	
	return Selecteddate_Ary;
	
}

//----------------------------------------------------------------------------------------------------
//------------------ Database Process of Registration view -------------------------------------------
//----------------------------------------------------------------------------------------------------
-(void)insertdata_IntoLoginTable:(NSMutableDictionary *)Dict;
{
	
	
	NSDate *today=[NSDate date];
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	[df setDateFormat:@"yyyy-MM-dd"];
	NSString *datestring=[df stringFromDate:today];
	
	NSString *username=[Dict valueForKey:@"username"];
	NSString *password=[Dict valueForKey:@"password"];
//	NSString *Address=[Dict valueForKey:@"Address"];
//	NSString *mobile=[Dict valueForKey:@"mobile"];
//	NSString *email=[Dict valueForKey:@"email"];
	
	path=obj_AppDelegate.getdatabasepath;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		static sqlite3_stmt *statement;
		statement = nil;
		const char *s = "insert into Login(username,password,address,mobile,date,email) values(?,?,?,?,?,?)";
		
		if(sqlite3_prepare_v2(database, s, -1, &statement, NULL) == SQLITE_OK)
		{
			sqlite3_bind_text(statement, 2, [password UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 1, [username UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 3, [@"address" UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 4, [@"mobile" UTF8String], -1, SQLITE_TRANSIENT);

			sqlite3_bind_text(statement, 5, [datestring UTF8String], -1, SQLITE_TRANSIENT);

			sqlite3_bind_text(statement, 6, [@"email" UTF8String], -1, SQLITE_TRANSIENT);

			
		}
		else
		{
			NSAssert1(0, @"Error while creating insert statement. '%s'", sqlite3_errmsg(database));
		}
		
		if(sqlite3_step(statement) == SQLITE_DONE) 
		{
			sqlite3_finalize(statement);
			
			
		}
		else
		{
			NSAssert1(0, @"Error while inserting. '%s'", sqlite3_errmsg(database));
		}
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}		
	
	sqlite3_close(database);
}

-( NSMutableArray *)RandomDataSerching_FromLogin
{
	NSMutableArray *user_Ary=[[NSMutableArray alloc]init];
	
	path=obj_AppDelegate.getdatabasepath;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		NSString  *sql1 = [NSString stringWithFormat:@"select username from Login"];
		//select password  from Login where username='admin';
		
		sqlite3_stmt *statement;
		statement = nil;
		
        if(sqlite3_prepare_v2(database, [sql1 UTF8String], -1, &statement, NULL) == SQLITE_OK) 
		{
			
			
			while (sqlite3_step(statement)==SQLITE_ROW) 
			{
				
				str_username   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
				
				[user_Ary addObject:str_username];
				
			}
        }		
		else
		{
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	return user_Ary;
}


//----------------------------------------------------------------------------------------------------	
//------------------ Database Process of Journal View  -----------------------------------------------
//----------------------------------------------------------------------------------------------------


-(void)insertdata_MasterTable:(NSMutableArray *)Ary_Journal
{
	path=obj_AppDelegate.getdatabasepath;
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		static sqlite3_stmt *statement;
		statement = nil;
		const char *s = "insert into MasterTable(quatation,selecteddate,todotask1,todotask2,Affirmation1,Affirmation2,Affirmation3,goal1,goal2,Gratitude1,Gratitude2,information) values(?,?,?,?,?,?,?,?,?,?,?,?)";
		
		if(sqlite3_prepare_v2(database, s, -1, &statement, NULL) == SQLITE_OK)
		{
			sqlite3_bind_text(statement, 1, [[Ary_Journal objectAtIndex:0] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 2, [[Ary_Journal objectAtIndex:1] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 3, [[Ary_Journal objectAtIndex:2] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 4, [[Ary_Journal objectAtIndex:3] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 5, [[Ary_Journal objectAtIndex:4] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 6, [[Ary_Journal objectAtIndex:5] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 7, [[Ary_Journal objectAtIndex:6] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 8, [[Ary_Journal objectAtIndex:7] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 9, [[Ary_Journal objectAtIndex:8] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 10,[[Ary_Journal objectAtIndex:9] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 11, [[Ary_Journal objectAtIndex:10] UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 12,[[Ary_Journal objectAtIndex:11] UTF8String], -1, SQLITE_TRANSIENT);


			
		}
		else
		{
			NSAssert1(0, @"Error while creating insert statement. '%s'", sqlite3_errmsg(database));
		}
		
		if(sqlite3_step(statement) == SQLITE_DONE) 
		{
			sqlite3_finalize(statement);
			
			
		}
		else
		{
			NSAssert1(0, @"Error while inserting. '%s'", sqlite3_errmsg(database));
		}
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}		
	
	sqlite3_close(database);
}

//---------- Random searching  two Record From Affirmation Table ----------------------------

-(NSMutableArray *)fillarray_affirmation:(int)number
{
	NSMutableArray *arr=[[NSMutableArray alloc]init];
	for (int l=0; l<number; l++ )
	{
		int no=arc4random()%number;
		if (![arr containsObject:[NSString stringWithFormat:@"%d",no]]) {
			[arr addObject:[NSString stringWithFormat:@"%d",no]];
		}
		else 
		{
			l--;
		}
	}
	return arr;
}

//---------- Random searching  two Record From gratutude Table ----------------------------

-(NSMutableArray *)fillarray_gratitude:(int)number
{
	NSMutableArray *arr=[[NSMutableArray alloc]init];
	for (int l=0; l<number; l++ ) 
	{
		int no=arc4random()%number;
		if (![arr containsObject:[NSString stringWithFormat:@"%d",no]]) {
			[arr addObject:[NSString stringWithFormat:@"%d",no]];
		}
		else 
		{
			l--;
		}
	}
	return arr;
}


//-------------- Random Searching  Two Record From Goal Table ----------------------------------------

-(NSMutableArray *)fillarray_goal:(int)number
{
	NSMutableArray *arr=[[NSMutableArray alloc]init];
	for (int l=0; l<number; l++ )
	{
		int no=arc4random()%number;
		if (![arr containsObject:[NSString stringWithFormat:@"%d",no]]) {
			[arr addObject:[NSString stringWithFormat:@"%d",no]];
		}
		else 
		{
			l--;
		}
	}
	return arr;
}
//------------- Random Searching Two Record From Todo task Table--------------------------------------
-(NSMutableArray *)fillarray:(int)number
{
	
	NSMutableArray *arr=[[NSMutableArray alloc]init];
	for (int l=0; l<number; l++ )
	{
		int no=arc4random()%number;
		if (![arr containsObject:[NSString stringWithFormat:@"%d",no]]) {
			[arr addObject:[NSString stringWithFormat:@"%d",no]];
		}
		else 
		{
			l--;
		}
	}
	return arr;
}

-(NSMutableArray *) RandomDataSerching_FromQuoates
{
	
	NSMutableArray *Ary_Qutation=[[NSMutableArray alloc]init];
	NSString *str_quatation;
	path=obj_AppDelegate.getdatabasepath;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sql1 = "select *from Quoates";
		
		sqlite3_stmt *statement;
		statement = nil;
		
        if(sqlite3_prepare_v2(database, sql1, -1, &statement, NULL) == SQLITE_OK) 
		{
			
			
			while (sqlite3_step(statement)==SQLITE_ROW) 
			{
				
				str_quatation   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
				[Ary_Qutation addObject:str_quatation];
				
			}
        }		
		else
		{
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	
	sqlite3_close(database);
	
	return Ary_Qutation;
}
//----------------------------------------------------------------------------------------------------
//---------------- EXercise---------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------
-(NSMutableDictionary *)RandomDataSerching_FromExercise:(int)month
{
	
	NSString *tempString;
	NSString *str_title;
	NSString *str_disc;
	NSMutableArray *tempAry=[[NSMutableArray alloc]init];
	NSMutableArray *Ary_title=[[NSMutableArray alloc]init];
	NSMutableArray *Ary_discription=[[NSMutableArray alloc]init];
	NSMutableDictionary *Dic_Ary=[[NSMutableDictionary alloc]init];
	
	path=obj_AppDelegate.getdatabasepath;
	if(sqlite3_open([path UTF8String],&database)==SQLITE_OK)
		
	{
		   NSString  *sql1 = [NSString stringWithFormat:@"select * from exercise where month=%d",month];
	   
		   sqlite3_stmt *statement;
		   statement = nil;
	   
		if(sqlite3_prepare_v2(database, [sql1 UTF8String], -1, &statement, NULL) == SQLITE_OK) 
		   {
			   while (sqlite3_step(statement)==SQLITE_ROW) 
			   {
				   tempString=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
				   str_disc=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
				   str_title=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];

				   
				   [tempAry addObject:tempString];
				   [Ary_title addObject:str_title];
				   [Ary_discription addObject:str_disc];
				
			   }
			   
			   
		   }
		
		else
		{
			NSAssert1(0, @"Error while creating select  statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(database);
		
	   
	   }

	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	
	sqlite3_close(database);
	[Dic_Ary setObject:str_title forKey:@"title"];
	[Dic_Ary setObject:tempAry forKey:@"exercise"];
	[Dic_Ary setObject:Ary_discription forKey:@"description"];
	[Ary_title release];
	[tempAry release];
	[Ary_discription release];
	return Dic_Ary;
	
	
	
}

-(NSString *)RandomDataSerching_FromExerciseDetail:(NSString *)exercise
{
	NSString *str;
	path=obj_AppDelegate.getdatabasepath;
	if(sqlite3_open([path UTF8String], &database)==SQLITE_OK)
	{
		NSString  *sql1 = [NSString stringWithFormat:@"select description from exercise where exercisename='%@'",exercise];
		sqlite3_stmt *statement;
		statement =nil;
		if(sqlite3_prepare_v2(database, [sql1 UTF8String], -1, &statement, NULL)==SQLITE_OK)
		{
				while (sqlite3_step(statement)==SQLITE_ROW) 
				{
				
					str=[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];

				}
		}
		else
		{
			NSAssert1(0, @"Error while creating select  statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(database);
		
		
	}
	
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	return str;

}

//----------------------------------------------------------------------------------------------------
//------------------ Database Process of Goal Table --------------------------------------------------
//----------------------------------------------------------------------------------------------------


-(NSMutableDictionary *)RandomDataSerching_FromGoal
{
	NSMutableDictionary *dict_ary=[[NSMutableDictionary alloc]init];
	NSMutableArray *ary_goal=[[NSMutableArray alloc]init];
	NSMutableArray *ary_status=[[NSMutableArray alloc]init];
	NSMutableArray *ary_date=[[NSMutableArray alloc]init];
	
	
	NSDate *today1=[NSDate date];
	
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	
	[df setDateFormat:@"MMM/dd/yyyy"];
	NSString *todaystring =[[df stringFromDate:today1]retain];
	
	NSString *sql1=@"";
	
	path=obj_AppDelegate.getdatabasepath;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		if(obj_AppDelegate.isStatus)
		{
			// sql1 = "select * from Goal where status = 'No'";
			//sql1=[NSString stringWithFormat:@"select * from Goal where status = 'No' And today='%@'",todaystring];
			sql1=[NSString stringWithFormat:@"select * from Goal where status = 'No'"];

			obj_AppDelegate.isStatus=FALSE;
		}
		else 
		{
			sql1=[NSString stringWithFormat:@"select * from Goal order by id desc"];
		}

		
		
		sqlite3_stmt *statement;
		statement = nil;
		
        if(sqlite3_prepare_v2(database, [sql1 UTF8String], -1, &statement, NULL) == SQLITE_OK) 
		{
			
			
			while (sqlite3_step(statement)==SQLITE_ROW) 
			{
				
				str_status  = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
				
				
				str_task = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
				
				str_date11 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
				
				
				[ary_status addObject:str_status];		
				[ary_goal addObject:str_task];
				[ary_date addObject:str_date11];
			}
        }		
		else
		{
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	
	
	sqlite3_close(database);
	
	[dict_ary setObject:ary_goal forKey:@"goal"];
	[dict_ary setObject:ary_status forKey:@"status"];
	[dict_ary setObject:ary_date forKey:@"date"];
	[ary_goal release];
	[ary_status release];
	
	return dict_ary;
	
}

-(void)updateGoal_AlermValue:(NSString *)str_text  Date:(NSString *)date
{
	path=obj_AppDelegate.getdatabasepath;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sql1 = "update Goal set date=? where Goal_No=?";
		sqlite3_stmt *statement;
		statement = nil;
		
		if(sqlite3_prepare_v2(database, sql1, -1, &statement, NULL) == SQLITE_OK)
		{
			
					sqlite3_bind_text(statement, 1, [date UTF8String], -1, SQLITE_TRANSIENT);
				sqlite3_bind_text(statement, 2, [str_text UTF8String], -1, SQLITE_TRANSIENT);
		}
		else
		{
			NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
		}		
		
		if(sqlite3_step(statement) == SQLITE_DONE) 
		{
			sqlite3_finalize(statement);
			
			
		}
		else
		{
			NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
		}		
		
		sqlite3_close(database);
		
	}
	
	
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}	
	
	
	
	
	sqlite3_close(database);
	
	
}
-(void)insertdata_Goal:(NSString *)str_text Date:(NSString*)date
{
	
	
	NSDate *today1=[NSDate date];
	
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	
	[df setDateFormat:@"MMM/dd/yyyy"];
	NSString *todaystring =[[df stringFromDate:today1]retain];
	NSLog(@"date***********************%@",todaystring);
	
	path=obj_AppDelegate.getdatabasepath;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		static sqlite3_stmt *statement;
		statement = nil;
		const char *s = "insert into Goal(Goal_No,status,date,today) values(?,?,?,?)";
		
		if(sqlite3_prepare_v2(database, s, -1, &statement, NULL) == SQLITE_OK)
		{
			sqlite3_bind_text(statement, 1, [str_text UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 2, [@"No" UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 3, [date UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 4, [todaystring UTF8String], -1, SQLITE_TRANSIENT);

		}
		else
		{
			NSAssert1(0, @"Error while creating insert statement. '%s'", sqlite3_errmsg(database));
		}
		
		if(sqlite3_step(statement) == SQLITE_DONE) 
		{
			sqlite3_finalize(statement);
			
			
		}
		else
		{
			NSAssert1(0, @"Error while inserting. '%s'", sqlite3_errmsg(database));
		}
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}		
	
	sqlite3_close(database);
}
-(void)DeleteDataFromDatabase:(NSString *)str_delete deleteYesNO:(NSString *)bool_dele;
{
	path=obj_AppDelegate.getdatabasepath;
	
	if(sqlite3_open([path UTF8String], &database)==SQLITE_OK)
	{
		
		const char *sql1="delete  from Goal where Goal_No = ?";
		
		sqlite3_stmt *statement;
		
		if(sqlite3_prepare_v2(database,sql1,-1, &statement,NULL)==SQLITE_OK)
		{
			
			
			sqlite3_bind_text(statement, 1,[str_delete UTF8String], -1,SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 2,[bool_dele UTF8String], -1, SQLITE_TRANSIENT);
			
			
			if(sqlite3_step(statement) == SQLITE_DONE) 
			{
				sqlite3_reset(statement);
				sqlite3_finalize(statement);
			}
			else
			{
				NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
			}
		}
		else
		{
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_close(database);
		
	} 
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	
	sqlite3_close(database);
}
-(void)updatecell:(NSString *)str_update update:(NSString *)str_bool
{
	path=obj_AppDelegate.getdatabasepath;
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sql1 = "update Goal set status=? where Goal_No=?";
		sqlite3_stmt *statement;
		statement = nil;
		
		if(sqlite3_prepare_v2(database, sql1, -1, &statement, NULL) == SQLITE_OK)
		{
			
			
			if([str_bool isEqualToString:@"Yes"])
			{
				sqlite3_bind_text(statement, 1, [@"No" UTF8String], -1, SQLITE_TRANSIENT);
				sqlite3_bind_text(statement, 2, [str_update UTF8String], -1, SQLITE_TRANSIENT);
				
			}
			else 
			{
				sqlite3_bind_text(statement, 1, [@"Yes" UTF8String], -1, SQLITE_TRANSIENT);
				sqlite3_bind_text(statement, 2, [str_update UTF8String], -1, SQLITE_TRANSIENT);
				
				
			}
			
			//			sqlite3_bind_int(statement,  3, [txtsalary.text intValue]);
			//			sqlite3_bind_int(statement,  4, [txtid.text intValue]);
			//			
		}
		else
		{
			NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
		}		
		
		if(sqlite3_step(statement) == SQLITE_DONE) 
		{
			sqlite3_finalize(statement);
			
			
		}
		else
		{
			NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
		}		
		
		sqlite3_close(database);
		
	}
	
	
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}	
	
	
	
	
	sqlite3_close(database);
	
}

-(void)updateToDocell:(NSString *)str_update update:(NSString *)str_bool
{
	path=obj_AppDelegate.getdatabasepath;
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sql1 = "update Todotask set status=? where task=?";
		sqlite3_stmt *statement;
		statement = nil;
		
		if(sqlite3_prepare_v2(database, sql1, -1, &statement, NULL) == SQLITE_OK)
		{
			
			
			if([str_bool isEqualToString:@"Yes"])
			{
				sqlite3_bind_text(statement, 1, [@"No" UTF8String], -1, SQLITE_TRANSIENT);
				sqlite3_bind_text(statement, 2, [str_update UTF8String], -1, SQLITE_TRANSIENT);
				
			}
			else 
			{
				sqlite3_bind_text(statement, 1, [@"Yes" UTF8String], -1, SQLITE_TRANSIENT);
				sqlite3_bind_text(statement, 2, [str_update UTF8String], -1, SQLITE_TRANSIENT);
				
				
			}
			
			//			sqlite3_bind_int(statement,  3, [txtsalary.text intValue]);
			//			sqlite3_bind_int(statement,  4, [txtid.text intValue]);
			//			
		}
		else
		{
			NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
		}		
		
		if(sqlite3_step(statement) == SQLITE_DONE) 
		{
			sqlite3_finalize(statement);
			
			
		}
		else
		{
			NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
		}		
		
		sqlite3_close(database);
		
	}
	
	
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}	
	
	
	
	
	sqlite3_close(database);
	
}


//-------------------------------------------------------------------------------------------------------------
//------------------- Database Process of Todotask Class And its Table ----------------------------------------
//-------------------------------------------------------------------------------------------------------------

-(void)updateTodo_AlermValue:(NSString *)str_text  Date:(NSString *)date  updateToday_date:(NSString*)updateTodaydat
{
	path=obj_AppDelegate.getdatabasepath;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sql1 = "update Todotask set setremainder=? ,today=?, Remainder=? where task=?";
		sqlite3_stmt *statement;
		statement = nil;
		//if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK)
//			NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
//		
		
		if(sqlite3_prepare_v2(database, sql1, -1, &statement, NULL) == SQLITE_OK)
		{
			
			sqlite3_bind_text(statement, 1, [date UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 2, [updateTodaydat UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 3, [updateTodaydat UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 4, [str_text UTF8String], -1, SQLITE_TRANSIENT);
		}
		else
		{
			NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
		}		
		
		if(sqlite3_step(statement) == SQLITE_DONE) 
		{
			sqlite3_finalize(statement);
			
			
		}
		else
		{
			NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
		}		
		
		sqlite3_close(database);
		
	}
	
	
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}	
	
	
	
	
	sqlite3_close(database);
	
	
}


-(void)insertdata_todotask:(NSString *)str_data remeinderdate:(NSString *)str_date;
{
	NSDate *today1=[NSDate date];
	
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	
	[df setDateFormat:@"dd MMM, yyyy"];
	NSString *todaystring =[[df stringFromDate:today1]retain];
	
	
	path=obj_AppDelegate.getdatabasepath;
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		static sqlite3_stmt *statement;
		statement = nil;
		const char *s = "insert into Todotask(task,Remainder,today,setremainder,status) values(?,?,?,?,?)";
		
		if(sqlite3_prepare_v2(database, s, -1, &statement, NULL) == SQLITE_OK)
		{
			sqlite3_bind_text(statement, 1, [str_data UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 2, [str_date UTF8String], -1, SQLITE_TRANSIENT);
		//	sqlite3_bind_text(statement, 3, [todaystring UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 4, [@"No Remainder" UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 5, [@"No" UTF8String], -1, SQLITE_TRANSIENT);
			
			if(str_date==NULL)
			{
				sqlite3_bind_text(statement, 3, [todaystring UTF8String], -1, SQLITE_TRANSIENT);
			}
			else
			{
				sqlite3_bind_text(statement, 3, [str_date UTF8String], -1, SQLITE_TRANSIENT);
				
			}
			
			
		}
		else
		{
			NSAssert1(0, @"Error while creating insert statement. '%s'", sqlite3_errmsg(database));
		}
		
		if(sqlite3_step(statement) == SQLITE_DONE) 
		{
			sqlite3_finalize(statement);
			
			
			
		}
		else
		{
			NSAssert1(0, @"Error while inserting. '%s'", sqlite3_errmsg(database));
		}
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}		
	
	
	
}

-(NSMutableDictionary *)RandomDataSerching_FromToDotask:(NSString *)date;
{
	NSDate *today1=[NSDate date];
	
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	
	//dd/MMM/yyyy
	[df setDateFormat:@"dd MMM, yyyy"];
	NSString *todaystring =[[df stringFromDate:today1]retain];
		
	
	NSMutableDictionary *dictionary_ary=[[NSMutableDictionary alloc]init];
	NSMutableArray *ary_remainderdate=[[NSMutableArray alloc]init];
	NSMutableArray *ary_todotask=[[NSMutableArray alloc]init];
	NSMutableArray *ary_taskStatus = [[NSMutableArray alloc] init];
	path=obj_AppDelegate.getdatabasepath;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		NSString *sql1 =@"";
		if(obj_AppDelegate.istoday)
		{
		//	sql1 = "select * from Todotask where today = 'No' And today='todaystring'";
			//sql1 = "select * from Todotask where today='todaystring'";
			
			if([date isEqualToString:@""] && obj_AppDelegate.isStatus)
			{
				
					// sql1 = "select * from Goal where status = 'No'";
					//sql1=[NSString stringWithFormat:@"select * from Todotask where status = 'No' And today='%@'",todaystring];
				sql1=[NSString stringWithFormat:@"select * from Todotask where status = 'No' order by today desc"];

					obj_AppDelegate.isStatusToDo=FALSE;
				

			}
			else 
			{
				//sql1=[NSString stringWithFormat:@"select * from Todotask where status = 'No' And today='%@'",date];    
				sql1=[NSString stringWithFormat:@"select * from Todotask where status = 'No' order by today desc"];    

				obj_AppDelegate.istoday=FALSE;
				obj_AppDelegate.isStatusToDo=FALSE;
			}

		}
		else 
		{
			//sql1 =[NSString stringWithFormat:@"select * from Todotask order by todotaskid desc"];
			sql1 =[NSString stringWithFormat:@"select * from Todotask order by today desc"];
		}
		
		
				
		
	
		
		sqlite3_stmt *statement;
		statement = nil;
		
        if(sqlite3_prepare_v2(database, [sql1 UTF8String], -1, &statement, NULL) == SQLITE_OK) 
		{
			
			
			while (sqlite3_step(statement)==SQLITE_ROW) 
			{
				str_statusToDo  = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
				str_remainder  = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
			//	int_id=sqlite3_column_int(statement, 1);
				str_task = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
				
				if([str_remainder isEqualToString:@""])
				{
					NSLog(@"Blank Value Of Remainder :-%@",str_remainder);
					
				}
				
				//	[ary_id addObject:[NSString stringWithFormat:@"%d",int_id]];
				[ary_taskStatus addObject:str_statusToDo];
				[ary_remainderdate addObject:str_remainder];
				[ary_todotask addObject:str_task];
				
				
			}
        }		
		else
		{
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	
	
	sqlite3_close(database);
	
	[dictionary_ary setObject:ary_todotask forKey:@"todotask"];
	[dictionary_ary setObject:ary_remainderdate forKey:@"remainder"];
	[dictionary_ary setObject:ary_taskStatus forKey:@"status"];
	return dictionary_ary;
	[ary_todotask release];
	[ary_remainderdate release];
	
}

-(NSString *)GetRemindar:(NSString *)task
{
		//    int l;
		//     NSString *trimmedString = [date stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		//    l = [trimmedString length];
		//    NSLog(@"%i",l);
	
	NSString *txtString;
		txtString = [[NSString alloc] init];
		txtString = @"";
	path=obj_AppDelegate.getdatabasepath;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
			
			const char *selectSql = "select setremainder from Todotask where task = ?";	
			
			sqlite3_stmt *compiledStatement;
			compiledStatement=nil;
			
			if(sqlite3_prepare_v2(database, selectSql , -1, &compiledStatement, NULL) == SQLITE_OK) {
				
				sqlite3_bind_text(compiledStatement, 1, [task UTF8String], -1, SQLITE_TRANSIENT);
				
				while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
					txtString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				}
				//			sqlite3_step(detailStmt);
			}
			sqlite3_finalize(compiledStatement);
			
		}
		sqlite3_close(database);
		
	NSLog(@"%@",txtString);
	
		return txtString;
}
	


-(NSMutableDictionary *)RandomDataTodoFromJournal_FromToDotask:(NSString *)date
{
		
	NSMutableDictionary *dictionary_ary=[[NSMutableDictionary alloc]init];
	NSMutableArray *ary_remainderdate=[[NSMutableArray alloc]init];
	NSMutableArray *ary_todotask=[[NSMutableArray alloc]init];
	NSMutableArray *ary_taskStatus = [[NSMutableArray alloc] init];
	path=obj_AppDelegate.getdatabasepath;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		
		
		
		NSString *sql_qry =@"";
		
			
		
		if(obj_AppDelegate.isStatus)
		{
			// sql1 = "select * from Goal where status = 'No'";
			sql_qry=[NSString stringWithFormat:@"select * from Todotask where status = 'No' And today='%@'",date];
			
			obj_AppDelegate.isStatusToDo=FALSE;
		}
		else 
		{
			sql_qry=[NSString stringWithFormat:@"select * from Todotask where today='%@'",date];
			obj_AppDelegate.isStatusToDo=FALSE;
		}
		
		
		sqlite3_stmt *statement;
		statement = nil;
		
        if(sqlite3_prepare_v2(database, [sql_qry UTF8String], -1, &statement, NULL) == SQLITE_OK) 
		{
			
			
			while (sqlite3_step(statement)==SQLITE_ROW) 
			{
				str_statusToDo  = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]; 
				str_remainder  = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
				//	int_id=sqlite3_column_int(statement, 1);
				str_task = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
				
				if([str_remainder isEqualToString:@""])
				{
					NSLog(@"Blank Value Of Remainder :-%@",str_remainder);
					
				}
				
				//	[ary_id addObject:[NSString stringWithFormat:@"%d",int_id]];
				[ary_taskStatus addObject:str_statusToDo];
				[ary_remainderdate addObject:str_remainder];
				[ary_todotask addObject:str_task];
				
				
			}
        }	
	
		else
		{
			NSAssert1(0, @"Error while Searching . '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	
	
	sqlite3_close(database);
	
	[dictionary_ary setObject:ary_todotask forKey:@"todotask"];
	[dictionary_ary setObject:ary_remainderdate forKey:@"remainder"];
	[dictionary_ary setObject:ary_taskStatus forKey:@"status"];
	return dictionary_ary;
	[ary_todotask release];
	[ary_remainderdate release];
	
}


-(void)DeleteDataFromTodoList:(NSString *)str_delete //remainderdate:(NSString *)str_remaind
{
	
	path=obj_AppDelegate.getdatabasepath;
	const char *sql1= "delete from Todotask where task = ?";
	sqlite3_stmt *deleteStmt = nil;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
    {
        if (sqlite3_prepare_v2(database, sql1, -1, &deleteStmt, NULL)== SQLITE_OK) 
        {
            sqlite3_bind_text(deleteStmt, 1,[str_delete UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_int(deleteStmt,-1,[str_delete intValue]);
            sqlite3_step(deleteStmt) ;
            sqlite3_finalize(deleteStmt);
            sqlite3_close(database);
        }
        else
        {
            sqlite3_close(database);
        }
    }
	
}
//-------------------------------------------------------------------------------------------------------
//------------------------ Database Proces of Gratitude Class and its Table -----------------------------
//-------------------------------------------------------------------------------------------------------


-(NSMutableDictionary *)RandomDataSerching_FromGratitudeTable
{
	NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]init];
	NSMutableArray *ary_gratitude=[[NSMutableArray alloc]init];
	NSMutableArray *ary_date33=[[NSMutableArray alloc]init];
	NSMutableArray *ary_status=[[NSMutableArray alloc]init];

	NSString *status;
	
	//NSDate *today1=[NSDate date];
	
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	
	[df setDateFormat:@"MMM/dd/yyyy"];
	//NSString *todaystring =[[df stringFromDate:today1]retain];
	
	NSString *sql1=@"";
	
	
	path=obj_AppDelegate.getdatabasepath;
	//const char *sql1;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		if(obj_AppDelegate.isStatusGrati)
		{
			//sql1 = "select * from Gratitude where status = 'No'";
			
		sql1=[NSString stringWithFormat:@"select * from Gratitude where status = 'No'"];

			obj_AppDelegate.isStatusGrati=FALSE;
		}
		else 
		{
			sql1=[NSString stringWithFormat:@"select * from Gratitude order by id desc"];
		}
		sqlite3_stmt *statement;
		statement = nil;
		
        if(sqlite3_prepare_v2(database, [sql1 UTF8String], -1, &statement, NULL) == SQLITE_OK) 
		{
			
			
			while (sqlite3_step(statement)==SQLITE_ROW) 
			{
				
				str_task   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
				
				str_date33   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
				status = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];

				
				[ary_gratitude addObject:str_task];
				[ary_date33 addObject:str_date33];
				[ary_status addObject:status];
				
			}
        }		
		else
		{
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	
	sqlite3_close(database);
	
	[dictionary setObject:ary_gratitude forKey:@"gratitude"];
	[dictionary setObject:ary_date33 forKey:@"date"];
	[dictionary setObject:ary_status forKey:@"status"];

	return dictionary;
	[ary_gratitude release];
}	

-(void)insertdata:(NSString *)str_textfield Date:(NSString*)date
{
	NSDate *today1=[NSDate date];
	
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	
	[df setDateFormat:@"dd/MMM/yyyy"];
	NSString *todaystring =[[df stringFromDate:today1]retain];
	
	path=obj_AppDelegate.getdatabasepath;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		static sqlite3_stmt *statement;
		statement = nil;
		const char *s = "insert into Gratitude(Gratitude_no,date,status,today) values(?,?,?,?)";
		
		if(sqlite3_prepare_v2(database, s, -1, &statement, NULL) == SQLITE_OK)
		{
			sqlite3_bind_text(statement, 1, [str_textfield UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 2, [date UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 3, [@"No" UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 4, [todaystring UTF8String], -1, SQLITE_TRANSIENT);

		}
		else
		{
			NSAssert1(0, @"Error while creating insert statement. '%s'", sqlite3_errmsg(database));
		}
		
		if(sqlite3_step(statement) == SQLITE_DONE) 
		{
			sqlite3_finalize(statement);
			
		}
		else
		{
			NSAssert1(0, @"Error while inserting. '%s'", sqlite3_errmsg(database));
		}
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}		
	
}

-(void)updatecellofGratitude:(NSString *)str_update update:(NSString *)str_bool
{
	path=obj_AppDelegate.getdatabasepath;
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sql1 = "update Gratitude set status=? where Gratitude_no=?";
		sqlite3_stmt *statement;
		statement = nil;
		
		if(sqlite3_prepare_v2(database, sql1, -1, &statement, NULL) == SQLITE_OK)
		{
			
			
			if([str_bool isEqualToString:@"Yes"])
			{
				sqlite3_bind_text(statement, 1, [@"No" UTF8String], -1, SQLITE_TRANSIENT);
				sqlite3_bind_text(statement, 2, [str_update UTF8String], -1, SQLITE_TRANSIENT);
				
			}
			else 
			{
				sqlite3_bind_text(statement, 1, [@"Yes" UTF8String], -1, SQLITE_TRANSIENT);
				sqlite3_bind_text(statement, 2, [str_update UTF8String], -1, SQLITE_TRANSIENT);
				
				
			}
			
			//			sqlite3_bind_int(statement,  3, [txtsalary.text intValue]);
			//			sqlite3_bind_int(statement,  4, [txtid.text intValue]);
			//			
		}
		else
		{
			NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
		}		
		
		if(sqlite3_step(statement) == SQLITE_DONE) 
		{
			sqlite3_finalize(statement);
			
			
		}
		else
		{
			NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
		}		
		
		sqlite3_close(database);
		
	}
	
	
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}	
	
	
	
	
	sqlite3_close(database);
	
}

-(void)UpdateGratitude_AlermValue:(NSString *)str_text  Date:(NSString *)date
{
	path=obj_AppDelegate.getdatabasepath;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sql1 = "update Gratitude set date=? where Gratitude_no=?";
		sqlite3_stmt *statement;
		statement = nil;
		
		if(sqlite3_prepare_v2(database, sql1, -1, &statement, NULL) == SQLITE_OK)
		{
			
			sqlite3_bind_text(statement, 1, [date UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 2, [str_text UTF8String], -1, SQLITE_TRANSIENT);
		}
		else
		{
			NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
		}		
		
		if(sqlite3_step(statement) == SQLITE_DONE) 
		{
			sqlite3_finalize(statement);
			
			
		}
		else
		{
			NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
		}		
		
		sqlite3_close(database);
		
	}
	
	
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}	
	
	
	
	
	sqlite3_close(database);
	
	
}


-(void)DeleteDataFromGratitude:(NSString *)str_delete deleteYesNO:(NSString *)bool_dele
{
	
	path=obj_AppDelegate.getdatabasepath;
	//NSString *str_del=(NSString *)[ary_id objectAtIndex:i];
	//	NSString *str_del=str_delete;
	
	if(sqlite3_open([path UTF8String], &database)==SQLITE_OK)
	{
		
		const char *sql1="delete  from Gratitude where gratitude_no = ?";
		
		sqlite3_stmt *statement;
		
		if(sqlite3_prepare_v2(database,sql1,-1, &statement,NULL)==SQLITE_OK)
		{
			
			
			//	sqlite3_bind_int(statement, 1,[str_del intValue] );
			
			sqlite3_bind_text(statement, 1, [str_delete  UTF8String],-1,SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 2,[bool_dele UTF8String], -1, SQLITE_TRANSIENT);

			
			
			//	sqlite3_bind_text(statement, 1, [txtview_desc.text UTF8String], -1, SQLITE_TRANSIENT);
			
			
			if(sqlite3_step(statement) == SQLITE_DONE) 
			{
				sqlite3_reset(statement);
				sqlite3_finalize(statement);
			}
			else
			{
				NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
			}
		}
		else
		{
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_close(database);
		
	} 
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	
}
//-------------------------------------------------------------------------------------------------------------
//--------------------------- Database Process Of Affirmation Table And Class ---------------------------------
//-------------------------------------------------------------------------------------------------------------


-(NSMutableDictionary *)RandomDataSerching_FromAffirmationTable
{
	NSMutableDictionary *dict_Affirmation=[[NSMutableDictionary alloc]init];
	NSMutableArray *ary_affimation=[[NSMutableArray alloc]init];
	NSMutableArray *ary_date22=[[NSMutableArray alloc]init];
	NSMutableArray *Ary_status=[[NSMutableArray alloc]init];
	
	path=obj_AppDelegate.getdatabasepath;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
	
		const char *sql1;
		if(obj_AppDelegate.isStatusAffr)
		{
			sql1 = "select * from Affirmation where status = 'No'";
			obj_AppDelegate.isStatusAffr=FALSE;
		}
		else 
		{
			sql1 = "select * from Affirmation order by id desc";
		}
		
		
		sqlite3_stmt *statement;
		statement = nil;
		
		if(sqlite3_prepare_v2(database, sql1, -1, &statement, NULL) == SQLITE_OK) 
		{
			while (sqlite3_step(statement)==SQLITE_ROW) 
			{
				
				str_task   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
				
				str_date22 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
				NSString *status = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];

				[ary_affimation addObject:str_task];
				[ary_date22 addObject:str_date22];
				[Ary_status addObject:status];
			}
		}		
		else
		{
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	
	sqlite3_close(database);
	[dict_Affirmation setObject:ary_affimation forKey:@"affirmation"];
	[dict_Affirmation setObject:ary_date22 forKey:@"date"];
	[dict_Affirmation setObject:Ary_status forKey:@"status"];
	return dict_Affirmation;
	[ary_affimation release];
	
	
}

-(void)updatecellofAffirmation:(NSString *)str_update update:(NSString *)str_bool
{
	path=obj_AppDelegate.getdatabasepath;
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sql1 = "update Affirmation set status=? where Affirmation_name=?";
		sqlite3_stmt *statement;
		statement = nil;
		
		if(sqlite3_prepare_v2(database, sql1, -1, &statement, NULL) == SQLITE_OK)
		{
			
			
			if([str_bool isEqualToString:@"Yes"])
			{
				sqlite3_bind_text(statement, 1, [@"No" UTF8String], -1, SQLITE_TRANSIENT);
				sqlite3_bind_text(statement, 2, [str_update UTF8String], -1, SQLITE_TRANSIENT);
				
			}
			else 
			{
				sqlite3_bind_text(statement, 1, [@"Yes" UTF8String], -1, SQLITE_TRANSIENT);
				sqlite3_bind_text(statement, 2, [str_update UTF8String], -1, SQLITE_TRANSIENT);
				
				
			}
			
			//			sqlite3_bind_int(statement,  3, [txtsalary.text intValue]);
			//			sqlite3_bind_int(statement,  4, [txtid.text intValue]);
			//			
		}
		else
		{
			NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
		}		
		
		if(sqlite3_step(statement) == SQLITE_DONE) 
		{
			sqlite3_finalize(statement);
			
			
		}
		else
		{
			NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
		}		
		
		sqlite3_close(database);
		
	}
	
	
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}	
	
	
	
	
	sqlite3_close(database);
	
}

-(void)insertdata_Affirmation:(NSString *)strind_field Date:(NSString*)date
{
	NSDate *today1=[NSDate date];
	
	NSDateFormatter *df=[[NSDateFormatter alloc]init];
	
	[df setDateFormat:@"MMM/dd/yyyy"];
	NSString *todaystring =[[df stringFromDate:today1]retain];
	
	
	path=obj_AppDelegate.getdatabasepath;
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		static sqlite3_stmt *statement;
		statement = nil;
		const char *s = "insert into Affirmation(Affirmation_name,date,status,today) values(?,?,?,?)";
		
		if(sqlite3_prepare_v2(database, s, -1, &statement, NULL) == SQLITE_OK)
		{
			sqlite3_bind_text(statement, 1, [strind_field UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 2, [date UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 3, [@"No" UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 4, [todaystring UTF8String], -1, SQLITE_TRANSIENT);


		}
		else
		{
			NSAssert1(0, @"Error while creating insert statement. '%s'", sqlite3_errmsg(database));
		}
		
		if(sqlite3_step(statement) == SQLITE_DONE) 
		{
			sqlite3_finalize(statement);
			
			
		}
		else
		{
			NSAssert1(0, @"Error while inserting. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}		
	
	sqlite3_close(database);
}


-(void)updateAffirmation_AlermValue:(NSString *)str_text  Date:(NSString *)date
{
	path=obj_AppDelegate.getdatabasepath;
	
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		
		const char *sql1 = "update Affirmation set date=? where Affirmation_name=?";
		sqlite3_stmt *statement;
		statement = nil;
		
		if(sqlite3_prepare_v2(database, sql1, -1, &statement, NULL) == SQLITE_OK)
		{
			
			sqlite3_bind_text(statement, 1, [date UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(statement, 2, [str_text UTF8String], -1, SQLITE_TRANSIENT);
		}
		else
		{
			NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
		}		
		
		if(sqlite3_step(statement) == SQLITE_DONE) 
		{
			sqlite3_finalize(statement);
			
			
		}
		else
		{
			NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
		}		
		
		sqlite3_close(database);
		
	}
	
	
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}	
	
	
	
	
	sqlite3_close(database);
	
	
}

-(void)DeleteDataFromAffirmation:(NSString *)str_delete deleteYesNO:(NSString *)bool_dele;
{
	path=obj_AppDelegate.getdatabasepath;
//	
//	if(sqlite3_open([path UTF8String], &database)==SQLITE_OK)
//	{
//		
//		const char *sql1="delete  from Affirmation where Affirmation_Name = ?";
//		
//		sqlite3_stmt *statement;
//		
//		if(sqlite3_prepare_v2(database,sql1,-1, &statement,NULL)==SQLITE_OK)
//		{
//			
//			
//			//sqlite3_bind_int(statement, 1,[str_del intValue] );
//			
//			sqlite3_bind_text(statement, 2, [str_delete  UTF8String],-1,SQLITE_TRANSIENT);
//			sqlite3_bind_text(statement, 1,[bool_dele UTF8String], -1, SQLITE_TRANSIENT);
//			
//			
//			if(sqlite3_step(statement) == SQLITE_DONE) 
//			{
//				sqlite3_reset(statement);
//				sqlite3_finalize(statement);
//			}
//			else
//			{
//				NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
//			}
//		}
//		else
//		{
//			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
//		}
//		
//		sqlite3_close(database);
//		
//	} 
//	else 
//	{
//		sqlite3_close(database);
//		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
//	}
//	
//	sqlite3_close(database);
	
	//-(void)delData:(NSString *)path
//	{
		//NSLog(@"path=%@",path);
		
		//int pathint = [path intValue];
		
		if(sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
			
			NSString *sqlQuery=[NSString stringWithFormat:@"delete from Affirmation where Affirmation_Name = '%@'",str_delete];    
			NSLog(@"query:%@",sqlQuery);
			
			sqlite3_stmt *compiledStatement;
			compiledStatement=nil;
			
			if(sqlite3_prepare_v2(database, [sqlQuery UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK) {
				
				sqlite3_step(compiledStatement);
			}
			sqlite3_finalize(compiledStatement);
			
		}
		sqlite3_close(database);
	
}
//--------------------------------------------------------------------------------------------------
//------------------ Login Table Database ----------------------------------------------------------
//---------------------------------------------------------------------------------------------------

-(BOOL)RandomDataSerching_FromLogin:(NSString *)username  password:(NSString *)password;
{
	BOOL isSuccess=FALSE;
	
	path=[obj_AppDelegate getdatabasepath];
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
		NSString  *sql1 = [NSString stringWithFormat:@"select * from Login where username='%@'",username];
		//select password  from Login where username='admin';
		
		sqlite3_stmt *statement;
		statement = nil;
		
        if(sqlite3_prepare_v2(database, [sql1 UTF8String], -1, &statement, NULL) == SQLITE_OK) 
		{
			
			
			while (sqlite3_step(statement)==SQLITE_ROW) 
			{
				
				str_username   = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
				str_password = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
				
				if([password isEqualToString:str_password])
				{
					isSuccess=TRUE;
				}
				
			}
        }		
		else
		{
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(statement);
		sqlite3_close(database);
		
	}
	else 
	{
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	return isSuccess;
}





/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */

- (void)dealloc {
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/



@end
