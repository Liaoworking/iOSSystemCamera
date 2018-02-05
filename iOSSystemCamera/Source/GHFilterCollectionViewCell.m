//
//  GHFilterCollectionViewCell.m
//  iOSSystemCamera
//
//  Created by Guanghui Liao on 2/3/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

#import "GHFilterCollectionViewCell.h"
@interface GHFilterCollectionViewCell ()
@property (nonatomic,strong)  GPUImageView *videoView;

@end
@implementation GHFilterCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (GPUImageView *)videoView{
    if (!_videoView) {
        _videoView = [[GPUImageView alloc]initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_videoView];
        
    }
    return _videoView;
}

- (void)setOutput:(GPUImageOutput *)output{
    _output = output;
    [self.videoView removeFromSuperview];
    self.videoView = nil;

    [output addTarget:self.videoView];
    
}

@end
