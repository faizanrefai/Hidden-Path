//
//  PdfReader.h
//  TABBAR
//
//  Created by openxcell technolabs on 6/22/11.
//  Copyright 2011 jn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PdfReader : UIViewController 
{
	IBOutlet UIWebView *Pdf_webview;
	IBOutlet UINavigationBar *nvgBar;
	IBOutlet UIBarButtonItem *btn_homepage;
	BOOL show_nvgbar;
	BOOL isPush;
	IBOutlet UIImageView *imgview;

}

@property(nonatomic)BOOL isPush;
@property(nonatomic,retain)UIWebView *Pdf_webview;
@property(nonatomic)BOOL show_nvgbar;
-(IBAction)btn_homepage_clicked:(id)sender;

@end
