//
//  FilterGroupVeiw.m
//  iOSSystemCamera
//
//  Created by Guanghui Liao on 2/3/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

#import "GHFilterGroupVeiw.h"

@interface GHFilterGroupVeiw ()
@property (nonatomic, strong)UICollectionViewFlowLayout *collectionViewLayout;
@end

@implementation GHFilterGroupVeiw

 - (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configCollectionView];
    }
    return self;
}

- (void)configCollectionView{
    
    self.filterCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.collectionViewLayout];
    self.filterCollectionView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.filterCollectionView];
    
    
    
}


#pragma mark- lazy

- (UICollectionViewFlowLayout *)collectionViewLayout{
    
    if (!_collectionViewLayout) {
        _collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionViewLayout.itemSize = CGSizeMake(50, 50);
        _collectionViewLayout.minimumLineSpacing = 5;
        _collectionViewLayout.minimumInteritemSpacing = 5;
        _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _collectionViewLayout;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.filterCollectionView.frame = self.bounds;
}

@end
