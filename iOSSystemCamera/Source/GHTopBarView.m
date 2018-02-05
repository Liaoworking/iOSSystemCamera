//
//  topBarView.m
//  iOSSystemCamera
//
//  Created by Guanghui Liao on 2/2/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

#import "GHTopBarView.h"
//自定义高度为50
@implementation GHTopBarView{
    
    UIButton *filterBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self configAddFilterBtn];
        
    }
    return self;
}

- (void)configAddFilterBtn{
    //自定义高度是40
    filterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    filterBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 20, 25, 25);
    [filterBtn setBackgroundImage:[UIImage imageNamed:@"magic"] forState:UIControlStateNormal];
    [filterBtn setBackgroundImage:[UIImage imageNamed:@"magic_selected"] forState:UIControlStateSelected];
    [filterBtn addTarget:self action:@selector(addFilterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:filterBtn];
}

- (void)addFilterBtn:(UIButton *)filterBtn{
    filterBtn.selected = !filterBtn.isSelected;
    if (self.filterBtnClick) {
        self.filterBtnClick(filterBtn.isSelected);
    }

}


@end
