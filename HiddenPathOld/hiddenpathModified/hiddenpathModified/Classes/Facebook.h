//
//  Facebook.h
//  TABBAR
//
//  Created by openxcell technolabs on 6/23/11.
//  Copyright 2011 jn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Facebook : UIViewController <UIWebViewDelegate>
{
	IBOutlet UIWebView *wbview_facebook;
	IBOutlet UIBarButtonItem *btn_homepage;
	IBOutlet UINavigationBar *nvg_bar;
	BOOL show_nvg;
	UIActivityIndicatorView *indicator;

}
@property(nonatomic)BOOL show_nvg;
-(IBAction)btn_homepage_clicked:(id)sender;


@end
