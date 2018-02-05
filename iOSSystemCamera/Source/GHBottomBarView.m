//
//  BottomBarView.m
//  iOSSystemCamera
//
//  Created by Guanghui Liao on 2/3/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

#import "GHBottomBarView.h"

@implementation GHBottomBarView
{
    UIButton *shootBtn;
    
}
//默认高度是100
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self configShootBtn];
    }
    return self;
}

- (void)configShootBtn{
    
    shootBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    shootBtn.frame = CGRectMake(self.frame.size.width * 0.5 - 40, 15, 80, 80);
    shootBtn.backgroundColor = [UIColor whiteColor];
    [self addSubview:shootBtn];
    
    
    
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
