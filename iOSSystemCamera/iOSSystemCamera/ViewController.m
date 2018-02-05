//
//  ViewController.m
//  iOSSystemCamera
//
//  Created by Guanghui Liao on 2/2/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

#import "ViewController.h"
#import "GHImagePickViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)takePhotoooo:(UIButton *)sender {
    
    [self presentViewController:[GHImagePickViewController new] animated:true completion:nil];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
