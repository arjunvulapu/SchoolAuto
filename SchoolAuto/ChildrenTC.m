//
//  ChildrenTC.m
//  SchoolAuto
//
//  Created by Apple on 13/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ChildrenTC.h"

@implementation ChildrenTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bgView.layer.cornerRadius=10;
    _bgView.clipsToBounds=YES;
    
    _infoBtn.layer.cornerRadius=10;
    _infoBtn.clipsToBounds=YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)infoBtnAction:(id)sender {
    if(self.infoBtnPressed){
        self.infoBtnPressed();
    }
}
@end
