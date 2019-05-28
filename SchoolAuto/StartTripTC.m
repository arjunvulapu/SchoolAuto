//
//  StartTripTC.m
//  SchoolAuto
//
//  Created by Apple on 21/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "StartTripTC.h"

@implementation StartTripTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _bgView.layer.cornerRadius=10;
    _bgView.clipsToBounds=YES;
    _startBtn.layer.cornerRadius=20;
    _startBtn.clipsToBounds=YES;
//    CABasicAnimation *theAnimation;
//
//    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
//    theAnimation.duration=1.0;
//    theAnimation.repeatCount=HUGE_VALF;
//    theAnimation.autoreverses=YES;
//    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
//    theAnimation.toValue=[NSNumber numberWithFloat:0.0];
//    [_startBtn.layer addAnimation:theAnimation forKey:@"animateOpacity"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)startBtnAction:(id)sender {
    if(self.startTrip){
        self.startTrip();
    }
}
@end
