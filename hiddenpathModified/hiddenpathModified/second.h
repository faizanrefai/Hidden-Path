//
//  second.h
//  TABBAR
//
//  Created by openxcell technolabs on 6/18/11.
//  Copyright 2011 jn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface second : UIViewController <UIApplicationDelegate,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
{
	IBOutlet UITableView *tbl_More;
	NSArray *Ary_data;
	IBOutlet UIImageView *imgview;
	

}

@end
