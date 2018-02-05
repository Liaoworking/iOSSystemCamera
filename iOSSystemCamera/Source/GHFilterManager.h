//
//  GHFilterManager.h
//  iOSSystemCamera
//
//  Created by Guanghui Liao on 2/3/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHFilterManager : NSObject
+ (GHFilterManager *)sharedInstance;

@property (nonatomic,strong) NSArray *filterList;

@end
