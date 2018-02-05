//
//  GHFilterCollectionViewCell.m
//  iOSSystemCamera
//
//  Created by Guanghui Liao on 2/3/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

#import "GHFilterCollectionViewCell.h"

@implementation GHFilterCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self configFileterView];
    }
    return self;
}

- (void)configFileterView{
    
    _videoView = [[GPUImageView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:_videoView];
    
}

@end
