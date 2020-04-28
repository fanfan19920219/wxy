//
//  YDMainViewController.m
//  杨迪❤️
//
//  Created by Farben on 2020/4/27.
//  Copyright © 2020 Farben. All rights reserved.
//

#import "YDMainViewController.h"
#import "Header.h"
#import "ContentView.h"
#import <QuartzCore/QuartzCore.h>
#import <AFNetworking.h>

@interface YDMainViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIImageView *backImageView;
@property (nonatomic,strong)UIImageView *backAlphaImageVIew;
@property (nonatomic,strong)UIScrollView *backScrollView;
@property (nonatomic,strong)UIImageView *topImageView;
@property (nonatomic,strong)ContentView *downContentView;

@end

@implementation YDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.backAlphaImageVIew];
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.backScrollView];
    
    [self addContentView];
    [self addFlower];
    
    
    
}

-(void)getshanxiWeather{
//    []
}

-(void)addContentView{
    self.downContentView = [[ContentView alloc]contentView];
    self.downContentView.frame = CGRectMake(0, 400, ScreenWidth, ScreenHeight);
    [self.backScrollView addSubview:self.downContentView];
    
}

-(UIScrollView*)backScrollView{
    if(!_backScrollView){
        _backScrollView = [[UIScrollView alloc]init];
        _backScrollView.frame = self.view.bounds;
        _backScrollView.delegate = self;
        _backScrollView.backgroundColor = UIColor.clearColor;
        _backImageView.clipsToBounds = YES;
        _backScrollView.contentSize = CGSizeMake
        (0, ScreenHeight*1.2);
    }
    return _backScrollView;
}


-(UIImageView*)backImageView{
    if(!_backImageView){
        _backImageView = [[UIImageView alloc]init];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backImageView.image = [UIImage imageNamed:@"背景"];
//        _backImageView.backgroundColor = UIColor.yellowColor;
        _backImageView.frame = self.view.bounds;
    }
    return _backImageView;
}


-(UIImageView*)backAlphaImageVIew{
    if(!_backAlphaImageVIew){
        _backAlphaImageVIew = [[UIImageView alloc]init];
        _backAlphaImageVIew.contentMode = UIViewContentModeScaleAspectFill;
        _backAlphaImageVIew.image = [UIImage imageNamed:@"背景透明"];
//        _backImageView.backgroundColor = UIColor.yellowColor;
        _backAlphaImageVIew.frame = self.view.bounds;
    }
    return _backAlphaImageVIew;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollVIew -- %f",scrollView.contentOffset.y);
    self.backImageView.alpha = (1 - (scrollView.contentOffset.y -200)/170);
}




//=========== 樱花效果 =============

-(void)addFlower{
    CAEmitterLayer * snowEmitterLayer = [CAEmitterLayer layer];
        snowEmitterLayer.emitterPosition = CGPointMake(100, -30);
        snowEmitterLayer.emitterSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
        snowEmitterLayer.emitterMode = kCAEmitterLayerOutline;
        snowEmitterLayer.emitterShape = kCAEmitterLayerLine;
    //    snowEmitterLayer.renderMode = kCAEmitterLayerAdditive;
        
        CAEmitterCell * snowCell = [CAEmitterCell emitterCell];
        snowCell.contents = (__bridge id)[UIImage imageNamed:@"樱花瓣2"].CGImage;
        
        // 花瓣缩放比例
        snowCell.scale = 0.02;
        snowCell.scaleRange = 0.5;
        
        // 每秒产生的花瓣数量
        snowCell.birthRate = 7;
        snowCell.lifetime = 80;
        
        // 每秒花瓣变透明的速度
        snowCell.alphaSpeed = -0.01;
        
        // 秒速“五”厘米～～
        snowCell.velocity = 40;
        snowCell.velocityRange = 60;
        
        // 花瓣掉落的角度范围
        snowCell.emissionRange = M_PI;
        
        // 花瓣旋转的速度
        snowCell.spin = M_PI_4;

        // 每个cell的颜色
    //    snowCell.color = [[UIColor redColor] CGColor];
        
        // 阴影的 不透明 度
        snowEmitterLayer.shadowOpacity = 1;
        // 阴影化开的程度（就像墨水滴在宣纸上化开那样）
        snowEmitterLayer.shadowRadius = 8;
        // 阴影的偏移量
        snowEmitterLayer.shadowOffset = CGSizeMake(3, 3);
        // 阴影的颜色
        snowEmitterLayer.shadowColor = [[UIColor whiteColor] CGColor];
        
        
        snowEmitterLayer.emitterCells = [NSArray arrayWithObject:snowCell];
    [self.backImageView.layer addSublayer:snowEmitterLayer];
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
