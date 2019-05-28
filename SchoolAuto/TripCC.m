//
//  TripCC.m
//  SchoolAuto
//
//  Created by Apple on 14/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "TripCC.h"

@implementation TripCC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _driverBtn.layer.cornerRadius=10;
    _driverBtn.clipsToBounds=YES;
    
    _bgiew.layer.cornerRadius=10;
    _bgiew.clipsToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)driverAction:(id)sender {
    if(self.driverAction){
        self.driverAction();
    }
}
@end
