//
//  GHFilterManager.m
//  iOSSystemCamera
//
//  Created by Guanghui Liao on 2/3/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

#import "GHFilterManager.h"
#import "GPUImageFilter.h"
#import "GPUImageAddBlendFilter.h"
#import "GPUImageAmatorkaFilter.h"
#import "GPUImageAverageLuminanceThresholdFilter.h"
#import "GPUImageMonochromeFilter.h"
#import "GPUImageClosingFilter.h"
#import "GPUImageColorBurnBlendFilter.h"
#import "GPUImageContrastFilter.h"


#import "GPUImageCrosshatchFilter.h"
#import "GPUImageDarkenBlendFilter.h"
#import "GPUImageEmbossFilter.h"
#import "GPUImageExposureFilter.h"
#import "GPUImageGaussianBlurFilter.h"
#import "GPUImageGammaFilter.h"
#import "GPUImageHalftoneFilter.h"
#import "GPUImageHardLightBlendFilter.h"
#import "GPUImageHazeFilter.h"
#import "GPUImageHighPassFilter.h"
#import "GPUImageLowPassFilter.h"
#import "GPUImageSketchFilter.h"
































@implementation GHFilterManager
+ (GHFilterManager *)sharedInstance{
    
    static GHFilterManager *sharedObj = nil;
    @synchronized (self)
    {
        if (sharedObj == nil){
            sharedObj = [[self alloc] init];
        }
    }
    return sharedObj;
}

#pragma mark- adding the filter you need
- (NSArray *)setdataList{
    NSMutableArray *mutableFilterArray = [NSMutableArray arrayWithCapacity:10];
    [mutableFilterArray addObject:[self closingFilter]];
//    [mutableFilterArray addObject:[self colorBurnBlendFilter]];
    [mutableFilterArray addObject:[self averageLuminanceThresholdFilter]];
    [mutableFilterArray addObject:[self monochromeFilter]];
    [mutableFilterArray addObject:[self contrastFilter]];
    
    [mutableFilterArray addObject:[self crosshatchFilter]];
//    [mutableFilterArray addObject:[self darkenBlendFilter]];
    [mutableFilterArray addObject:[self embossFilter]];
    [mutableFilterArray addObject:[self exposureFilter]];
    [mutableFilterArray addObject:[self gaussianBlurFilter]];
    [mutableFilterArray addObject:[self gammaFilter]];
    [mutableFilterArray addObject:[self halftoneFilter]];
//    [mutableFilterArray addObject:[self hardLightBlendFilter]];
    [mutableFilterArray addObject:[self hazeFilter]];
    [mutableFilterArray addObject:[self highPassFilter]];    
    [mutableFilterArray addObject:[self lowPassFilter]];
    [mutableFilterArray addObject:[self sketchFilter]];

    return mutableFilterArray.copy;
}

- (GPUImageOutput *)closingFilter{
    GPUImageClosingFilter *closingFilter = [[GPUImageClosingFilter alloc]init];
    return closingFilter;
}

- (GPUImageOutput *)colorBurnBlendFilter{
    GPUImageColorBurnBlendFilter *colorBurnBlendFilter = [[GPUImageColorBurnBlendFilter alloc]init];
    return colorBurnBlendFilter;
}

- (GPUImageOutput *)averageLuminanceThresholdFilter{
    GPUImageAverageLuminanceThresholdFilter *averageLuminanceThresholdFilter = [[GPUImageAverageLuminanceThresholdFilter alloc]init];
    return averageLuminanceThresholdFilter;
}

- (GPUImageOutput *)monochromeFilter{
    GPUImageMonochromeFilter *monochromeFilter = [[GPUImageMonochromeFilter alloc]init];
    return monochromeFilter;
}

- (GPUImageOutput *)contrastFilter{
    
    GPUImageContrastFilter *contrastFilter = [[GPUImageContrastFilter alloc]init];
    return contrastFilter;
}

#pragma mark- new adding

- (GPUImageOutput *)crosshatchFilter{
    
    GPUImageCrosshatchFilter *crosshatchFilter = [[GPUImageCrosshatchFilter alloc]init];
    return crosshatchFilter;
}

- (GPUImageOutput *)darkenBlendFilter{
    
    GPUImageDarkenBlendFilter *darkenBlendFilter = [[GPUImageDarkenBlendFilter alloc]init];
    return darkenBlendFilter;
}

- (GPUImageOutput *)embossFilter{
    
    GPUImageEmbossFilter *embossFilter = [[GPUImageEmbossFilter alloc]init];
    return embossFilter;
}

- (GPUImageOutput *)exposureFilter{
    
    GPUImageExposureFilter *exposureFilter = [[GPUImageExposureFilter alloc]init];
    return exposureFilter;
}

- (GPUImageOutput *)gaussianBlurFilter{
    
    GPUImageGaussianBlurFilter *gaussianBlurFilter = [[GPUImageGaussianBlurFilter alloc]init];
    return gaussianBlurFilter;
}

- (GPUImageOutput *)gammaFilter{
    
    GPUImageGammaFilter *gammaFilter = [[GPUImageGammaFilter alloc]init];
    return gammaFilter;
}

- (GPUImageOutput *)halftoneFilter{
    
    GPUImageHalftoneFilter *halftoneFilter = [[GPUImageHalftoneFilter alloc]init];
    return halftoneFilter;
}

- (GPUImageOutput *)hardLightBlendFilter{
    
    GPUImageHardLightBlendFilter *hardLightBlendFilter = [[GPUImageHardLightBlendFilter alloc]init];
    return hardLightBlendFilter;
}

- (GPUImageOutput *)hazeFilter{
    
    GPUImageHazeFilter *hazeFilter = [[GPUImageHazeFilter alloc]init];
    return hazeFilter;
}

- (GPUImageOutput *)highPassFilter{
    
    GPUImageHighPassFilter *highPassFilter = [[GPUImageHighPassFilter alloc]init];
    return highPassFilter;
}

- (GPUImageOutput *)lowPassFilter{
    
    GPUImageLowPassFilter *lowPassFilter = [[GPUImageLowPassFilter alloc]init];
    return lowPassFilter;
}

- (GPUImageOutput *)sketchFilter{
    
    GPUImageSketchFilter *sketchFilter = [[GPUImageSketchFilter alloc]init];
    return sketchFilter;
}



- (NSArray *)filterList{
    if (!_filterList) {
        _filterList = [NSArray arrayWithArray:[self setdataList]];
    }
    return _filterList;
}

@end
