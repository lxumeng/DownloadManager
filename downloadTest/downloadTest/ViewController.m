//
//  ViewController.m
//  downloadTest
//
//  Created by 李旭萌 on 2018/7/19.
//  Copyright © 2018年 李旭萌. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AVPlayer * av = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"https://v.manlanvideo.com/shortvideo2/%E3%80%8A%E7%96%AF%E7%8B%82%E5%8A%A8%E7%89%A9%E5%9F%8E%E3%80%8B3%E3%80%90%E5%85%94%E6%9C%B1%E8%BF%AA%E5%9C%A8%E4%BA%A4%E9%80%9A%E7%AE%A1%E5%88%B6%E4%B8%AD%E5%8F%91%E7%8E%B0%E5%B0%8F%E5%81%B7%E7%AB%8B%E9%A9%AC%E8%BF%BD%E6%8D%95%EF%BC%8C%E7%89%9B%E8%AD%A6%E5%AE%98%E8%AF%B4%E8%BF%99%E4%B8%8D%E6%98%AF%E5%85%94%E5%AD%90%E8%AD%A6%E5%AE%98%E7%AE%A1%E5%88%B6%E8%8C%83%E5%9B%B4%E5%86%85%E5%86%B3%E5%AE%9A%E8%A7%A3%E9%9B%87%E5%A5%B9%E3%80%91.mp4"]];
    [av play];
    AVPlayerLayer * avl = [AVPlayerLayer playerLayerWithPlayer:av];
    avl.frame = self.view.bounds;
    [self.view.layer addSublayer:avl];
    
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
