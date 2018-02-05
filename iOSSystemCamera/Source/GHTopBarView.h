//
//  topBarView.h
//  iOSSystemCamera
//
//  Created by Guanghui Liao on 2/2/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^btnClickEventBlock)(BOOL isSelec);// 0 未选中  1 已选中
@interface GHTopBarView : UIView
@property (nonatomic, copy) btnClickEventBlock filterBtnClick;
@end
