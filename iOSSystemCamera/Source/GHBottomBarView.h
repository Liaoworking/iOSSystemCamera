//
//  BottomBarView.h
//  iOSSystemCamera
//
//  Created by Guanghui Liao on 2/3/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^shootEventBlock)(BOOL isSelec);// 0 未选中  1 已选中

@interface GHBottomBarView : UIView
@property (nonatomic, copy) shootEventBlock shootBtnClick;

@end
