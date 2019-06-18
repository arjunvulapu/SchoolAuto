//
//  AboutUsViewController.h
//  TieProperty
//
//  Created by apple on 27/06/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface AboutUsViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(strong,nonatomic) NSString *from;
@property (weak, nonatomic) IBOutlet UIImageView *aboutBgImage;
@end
