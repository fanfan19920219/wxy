//
//  YDMainViewController.m
//  小可爱❤️
//
//  Created by Farben on 2020/4/27.
//  Copyright © 2020 Farben. All rights reserved.
//

#import "YDMainViewController.h"
#import "Header.h"
#import "ContentView.h"
#import <QuartzCore/QuartzCore.h>
#import "YDWebViewViewController.h"
#import <AFNetworking.h>
#import <UserNotifications/UserNotifications.h>
#import <AVFoundation/AVFoundation.h>

@interface YDMainViewController ()<UIScrollViewDelegate,AVAudioPlayerDelegate>
@property (nonatomic,strong)UIImageView *backImageView;
@property (nonatomic,strong)UIImageView *backAlphaImageVIew;
@property (nonatomic,strong)UIScrollView *backScrollView;
@property (nonatomic,strong)UIImageView *backbottomImageView;
@property (nonatomic,strong)ContentView *downContentView;
@property (nonatomic,strong)AVAudioPlayer *avAudioPlayer;

@property (nonatomic ,assign)NSInteger badge;

@end

@implementation YDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.backbottomImageView];
    self.view.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.backAlphaImageVIew];
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.backScrollView];
    
    [self addContentView];
    [self addFlower];
    [self push:@"10:30" andcontentString:@"该喝水啦姜瑜瑜😁" andTime:10 :30 :2];
    [self push:@"15:30" andcontentString:@"该喝水啦姜瑜瑜😁" andTime:15 :30 :2];
    [self playMp3];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self push:@"23:30" andcontentString:@"睡觉时间到 晚安❤️" andTime:23 :30 :2];
    });
    
    
    
;
    
}

//播放本地音频
-(void)playMp3{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"夏天的风" ofType:@"mp3"];
    // (2)把音频文件转化成url格式
    NSURL *url = [NSURL fileURLWithPath:path];
    // (3)初始化音频类 并且添加播放文件
    _avAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    // (4) 设置代理
    _avAudioPlayer.delegate = self;
    // (5) 设置初始音量大小 默认1，取值范围 0~1
    _avAudioPlayer.volume = 2;
    // (6)设置音乐播放次数 负数为一直循环，直到stop，0为一次，1为2次，以此类推
    _avAudioPlayer.numberOfLoops = -1;
    // (7)准备播放
    [_avAudioPlayer prepareToPlay];
    
    [_avAudioPlayer play];


}

#pragma mark - 推送
-(void)push:(NSString *)pushString andcontentString:(NSString*)contentString andTime:(NSInteger)hour :(NSInteger)min :(NSInteger)second{
    // 申请通知权限
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        // A Boolean value indicating whether authorization was granted. The value of this parameter is YES when authorization for the requested options was granted. The value is NO when authorization for one or more of the options is denied.
        if (granted) {
            
            // 1、创建通知内容，注：这里得用可变类型的UNMutableNotificationContent，否则内容的属性是只读的
            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
            // 标题
            content.title = @"温馨提醒";
            // 次标题
//            content.subtitle = @"柯梵办公室通知";
            // 内容
            content.body = contentString;
            
            self.badge++;
            // app显示通知数量的角标
            content.badge = @(0);
            
            // 通知的提示声音，这里用的默认的声音
            content.sound = [UNNotificationSound defaultSound];
            
//            NSURL *imageUrl = [[NSBundle mainBundle] URLForResource:@"kun" withExtension:@"jpeg"];
            //UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageIndetifier" URL:imageUrl options:nil error:nil];
            
            // 附件 可以是音频、图片、视频 这里是一张图片
            //content.attachments = @[attachment];
            
            // 标识符
            content.categoryIdentifier = [NSString stringWithFormat:@"categoryIndentifier%@",pushString];
            
            // 2、创建通知触发
            /* 触发器分三种：
             UNTimeIntervalNotificationTrigger : 在一定时间后触发，如果设置重复的话，timeInterval不能小于60
             UNCalendarNotificationTrigger : 在某天某时触发，可重复
             UNLocationNotificationTrigger : 进入或离开某个地理区域时触发
             */
            NSDateComponents *date = [[NSDateComponents alloc]init];
            date.hour = hour;
            date.minute = min;
            date.second = second;
            
            UNCalendarNotificationTrigger *trigger1 = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:date repeats:YES];
            //UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
            
            
            NSString *notificationRequestString = [NSString stringWithFormat:@"KFGroupNotification%@",pushString];
            // 3、创建通知请求
            UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:notificationRequestString content:content trigger:trigger1];
            
            // 4、将请求加入通知中心
            [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
                if (error == nil) {
                    NSLog(@"已成功加推送%@",notificationRequest.identifier);
                }
            }];
            
            
            [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
                if (error == nil) {
                    NSLog(@"已成功加推送%@",notificationRequest.identifier);
                }
            }];
        }
        
    }];
}

-(void)getshanxiWeather{
//    []
}

-(void)addContentView{
    self.downContentView = [[ContentView alloc]contentView];
    self.downContentView.frame = CGRectMake(0, 400, ScreenWidth, ScreenHeight);
    [self.backScrollView addSubview:self.downContentView];
    
    
    [self.downContentView.meituanButton addTarget:self action:@selector(jumpToMeiTuan:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.downContentView.eatButton addTarget:self action:@selector(jumpToMeiTuan:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.downContentView.weatherButton addTarget:self action:@selector(jumpToMeiTuan:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)jumpToMeiTuan:(UIButton*)sender{
    
    /*
     @"http://tieba.baidu.com/wxf/25431955?kw=%E6%AF%94%E5%BF%83app&fr=frsshare"]];
     //http://tieba.baidu.com/wxf/25431955?kw=%E6%AF%94%E5%BF%83app&fr=frsshare
     //http://i.meituan.com/
     //https://tieba.baidu.com/f?ie=utf-8&kw=比心APP&fr=search
     */
    //https://jinshuju.net/f/kmnRjy?submit_link_generated_from=poster
    NSString *url;
    switch (sender.tag) {
        case 1:
            url = @"https://m.baidu.com/from=844b/s?word=%E4%B8%8A%E6%B5%B7%E5%A4%A9%E6%B0%94&ts=2319229&t_kt=0&ie=utf-8&fm_kl=021394be2f&rsv_iqid=0314338759&rsv_t=82e0d02tlGMv0w6qw6opjHGu%252F%252BY%252Ff7HghZvD4LmkVK4n8VFhmQqfKwmh8A&sa=ib&ms=1&rsv_pq=0314338759&rsv_sug4=3429&ss=110&inputT=2207&sugid=5696672720873426571&tj=1";
//              url = @"https://jinshuju.net/f/kmnRjy?submit_link_generated_from=poster";
            break;
        
        case 2:
            url = @"http://i.meituan.com/";
        break;
            
        case 3:
            url = @"https://m.baidu.com/from=844b/s?word=%E4%B8%8A%E6%B5%B7%E5%A4%A9%E6%B0%94&ts=0&t_kt=0&ie=utf-8&fm_kl=021394be2f&rsv_iqid=1058371444&rsv_t=972aVXVZ%252BJOSjXugzDtojAT0xBw%252B6VMtkd2Qc2jLMjEVDZDh1MIs2FuXbw&sa=is_1&ms=1&rsv_pq=1058371444&rsv_sug4=1591179459667&inputT=1591179460583&sugid=5901898404259021508&ss=100&rq=shang%E2%80%86hai%E2%80%86tian%E2%80%86qi";
            break;
            
        default:
            break;
    }
    
    YDWebViewViewController *webViewVC = [[YDWebViewViewController alloc]init];
//    self.modalPresentationStyle = 0;
    webViewVC.urlString = url;
    webViewVC.modalPresentationStyle = 0;
    
    [self presentViewController:webViewVC animated:YES completion:^{
        
    }];
    
    
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

-(UIImageView*)backbottomImageView{
    if(!_backbottomImageView){
        _backbottomImageView = [[UIImageView alloc]init];
        _backbottomImageView.image = [UIImage imageNamed:@"最底层背景.jpeg"];
        _backbottomImageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }
    return _backbottomImageView;
}


-(UIImageView*)backImageView{
    if(!_backImageView){
        _backImageView = [[UIImageView alloc]init];
        _backImageView.contentMode = UIViewContentModeScaleAspectFit;
        _backImageView.image = [UIImage imageNamed:@"背景"];
//        _backImageView.backgroundColor = UIColor.yellowColor;
        _backImageView.frame = self.view.bounds;
    }
    return _backImageView;
}


-(UIImageView*)backAlphaImageVIew{
    if(!_backAlphaImageVIew){
        _backAlphaImageVIew = [[UIImageView alloc]init];
        _backAlphaImageVIew.contentMode = UIViewContentModeScaleAspectFit;
        _backAlphaImageVIew.image = [UIImage imageNamed:@"背景透明"];
        _backAlphaImageVIew.alpha = 0;
//        _backImageView.backgroundColor = UIColor.yellowColor;
        _backAlphaImageVIew.frame = self.view.bounds;
    }
    return _backAlphaImageVIew;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollVIew -- %f",scrollView.contentOffset.y);
    self.backImageView.alpha = (1 - (scrollView.contentOffset.y -200)/170);
    //_backAlphaImageVIew
    self.downContentView.alpha = self.backImageView.alpha + 0.2;
    self.backbottomImageView.alpha = self.backImageView.alpha;
    self.backAlphaImageVIew.alpha = (1- self.backImageView.alpha);
    
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



//播放的代理
#pragma mark - AVAudioPlayerDelegate
// 当播放完成时执行的代理
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    NSLog(@"audioPlayerDidFinishPlaying");
}
// 当播放发生错误时调用
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error {
    NSLog(@"播放发生错误%@",error);
}
// 当播放器发生中断时调用 如来电
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
    
    NSLog(@"audioPlayerBeginInterruption");
    // 暂停播放 用户不暂停，系统也会帮你暂停。但是如果你暂停了，等来电结束，需要再开启
    [_avAudioPlayer pause];
}
// 当中断停止时调用 如来电结束
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags {
    
    NSLog(@"audioPlayerEndInterruption");
    // 你可以帮用户开启 也可以什么都不执行，让用户自己决定
    [_avAudioPlayer play];
}

@end
