//
//  AboutUsViewController.m
//  TieProperty
//
//  Created by apple on 27/06/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "AboutUsViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
@interface AboutUsViewController ()
{
    NSString *htmlString;
}
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [currentDefaults objectForKey:@"SETTINGS"];
    NSArray *infoarr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if([_from  isEqual: @"about"]){
        for (NSDictionary *dic in infoarr) {
            if([[dic valueForKey:@"content_type"] isEqual:@"about"]){
                htmlString = [dic valueForKey:@"content_matter"];
                break;
            }
        }

        self.navigationItem.title = @"About Us";
    }else   if([_from  isEqual: @"terms"]){
        for (NSDictionary *dic in infoarr) {
            if([[dic valueForKey:@"content_type"] isEqual:@"policies"]){
                htmlString = [dic valueForKey:@"content_matter"];
                break;
            }
        }        self.navigationItem.title = @"POLICIES";

    }
    else   if([_from  isEqual: @"faqs"]){
        for (NSDictionary *dic in infoarr) {
            if([[dic valueForKey:@"content_type"] isEqual:@"faqs"]){
                htmlString = [dic valueForKey:@"content_matter"];
                break;
            }
        }        self.navigationItem.title = @"FAQ's";

    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                   initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                                   options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                   documentAttributes: nil
                                                   error: nil
                                                   ];
    [_textView setScrollEnabled:NO];
    _textView.attributedText = attributedString;
    [_textView setScrollEnabled:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
