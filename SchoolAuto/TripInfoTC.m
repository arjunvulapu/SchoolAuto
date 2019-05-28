//
//  TripInfoTC.m
//  SchoolAuto
//
//  Created by Apple on 24/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "TripInfoTC.h"

@implementation TripInfoTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _tripBgView.layer.cornerRadius=10;
//    _tripBgView.clipsToBounds=YES;
    
    [_tripBgView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_tripBgView.layer setShadowOpacity:0.2];
    [_tripBgView.layer setShadowRadius:5.0];
    [_tripBgView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    _tripImage.layer.cornerRadius=10;
    _tripImage.clipsToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
