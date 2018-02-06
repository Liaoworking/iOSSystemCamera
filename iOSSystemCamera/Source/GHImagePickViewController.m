//
//  GHImagePickViewController.m
//  iOSSystemCamera
//
//  Created by Guanghui Liao on 2/2/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

#import "GHImagePickViewController.h"
#import "GPUImage.h"
#import "GHTopBarView.h"
#import "GHBottomBarView.h"
#import "GHFilterGroupVeiw.h"
#import "GHFilterCollectionViewCell.h"
#import "GHFilterManager.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <Photos/PHPhotoLibrary.h>
@interface GHImagePickViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)GHFilterGroupVeiw *filterGroup;
@property (nonatomic, strong)NSArray *datalist;
@end

@implementation GHImagePickViewController{
    
    GPUImageVideoCamera *videoCamera;
    GPUImageView *mainView;
    GPUImageFilter *mainFilter;
    GPUImageMovieWriter * writer;
    GHTopBarView *topBar;
    GHBottomBarView *bottomBar;
    GHFilterManager *filtManager;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.datalist = [GHFilterManager sharedInstance].filterList;
    [self configTopbarVeiw];
    [self configBottomBarView];
    [self configMainCameraView];
    [videoCamera startCameraCapture];

}

- (void)configTopbarVeiw{
    topBar = [[GHTopBarView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    __weak __typeof__(self) weakSelf = self;
    topBar.filterBtnClick = ^(BOOL isSelec) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf showOrHideFilter:isSelec];

    };
    [self.view addSubview:topBar];
}

- (void)configBottomBarView{
    bottomBar = [[GHBottomBarView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100, [UIScreen mainScreen].bounds.size.width, 100)];
    __weak __typeof__(self) weakSelf = self;
    bottomBar.shootBtnClick = ^(BOOL isSelec) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf onClick:isSelec];
    };
    [self.view addSubview:bottomBar];
}

- (void)configMainCameraView{
    
    videoCamera = [[GPUImageVideoCamera alloc]initWithSessionPreset:AVCaptureSessionPresetPhoto cameraPosition:AVCaptureDevicePositionBack];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;

    mainView = [[GPUImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topBar.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 150)];
    [self.view addSubview:mainView];
    
    mainFilter = [[GPUImageFilter alloc]init];
    [mainFilter addTarget:mainView];
    [videoCamera addTarget:mainFilter];
    
}

- (void)showOrHideFilter:(BOOL)isShow{
    if (isShow) {
        [UIView animateWithDuration:0.25 animations:^{
            self.filterGroup.frame = CGRectMake(0, CGRectGetMinY(bottomBar.frame) - 60, [UIScreen mainScreen].bounds.size.width, 60);
            
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.filterGroup.frame = CGRectMake(0, CGRectGetMinY(bottomBar.frame) - 5, [UIScreen mainScreen].bounds.size.width, 5);
        } completion:^(BOOL finished) {
#warning TODO:
            [self.filterGroup.filterCollectionView removeFromSuperview];
            self.filterGroup.filterCollectionView = nil;
        }];
    }
}

- (void)onClick:(BOOL)isSelected {
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie4.m4v"];
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    if(isSelected) {
        NSLog(@"Start recording");
        unlink([pathToMovie UTF8String]); // 如果已经存在文件，AVAssetWriter会有异常，删除旧文件
        writer = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 640.0)];
        writer.encodingLiveVideo = YES;
        [mainFilter addTarget:writer];
        videoCamera.audioEncodingTarget = writer;
        [writer startRecording];
        
//        _mLabelTime = 0;
//        _mLabel.hidden = NO;
//        [self onTimer:nil];
//        _mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    }
    else {
        NSLog(@"End recording");
//        _mLabel.hidden = YES;
//        if (_mTimer) {
//            [_mTimer invalidate];
//        }
        [mainFilter removeTarget:writer];
        videoCamera.audioEncodingTarget = nil;
        [writer finishRecording];
       
        if (pathToMovie) {
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(pathToMovie)) {
                //保存相册核心代码
                UISaveVideoAtPathToSavedPhotosAlbum(pathToMovie, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            }
        }
    }
}


#pragma mark- 保存完毕的回调
//保存视频完成之后的回调

- (void)video:(id)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    if (error) {
        NSLog(@"保存视频失败%@", error.localizedDescription);
    }
    else {
        NSLog(@"保存视频成功");
    }
}

#pragma mark- lazy
- (GHFilterGroupVeiw *)filterGroup{
    if (!_filterGroup) {
        _filterGroup = [[GHFilterGroupVeiw alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(bottomBar.frame) - 5, [UIScreen mainScreen].bounds.size.width, 5)];
        _filterGroup.filterCollectionView.delegate = self;
        _filterGroup.filterCollectionView.dataSource = self;
        [_filterGroup.filterCollectionView registerClass:[GHFilterCollectionViewCell class] forCellWithReuseIdentifier:@"GHFilterCollectionViewCell"];
        [self.view addSubview:_filterGroup];
    }
    return _filterGroup;
}


#pragma mark- collectionViewDelegate and dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GHFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHFilterCollectionViewCell" forIndexPath:indexPath];
    
    GPUImageOutput *outPut = self.datalist[indexPath.item];
    cell.output = outPut;
    [videoCamera addTarget:outPut];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GPUImageOutput *outPut = self.datalist[indexPath.item];
    [mainView removeFromSuperview];
    mainView = [[GPUImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topBar.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 150)];
    [outPut addTarget:mainView];
    [videoCamera addTarget:outPut];
    [self.view addSubview:mainView];
    mainFilter = outPut;
    [self.view bringSubviewToFront:self.filterGroup];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
