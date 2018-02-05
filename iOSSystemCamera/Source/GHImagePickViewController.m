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
@interface GHImagePickViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)GHFilterGroupVeiw *filterGroup;
@property (nonatomic, strong)NSArray *datalist;
@end

@implementation GHImagePickViewController{
    
    GPUImageVideoCamera *videoCamera;
    GPUImageView *mainView;
    GPUImageFilter *mainFilter;
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
    [outPut addTarget:cell.videoView];
    [videoCamera addTarget:outPut];
    
    return cell;
    
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
