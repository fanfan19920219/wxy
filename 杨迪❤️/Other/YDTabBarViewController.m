//
//  YDTabBarViewController.m
//  杨迪❤️
//
//  Created by Farben on 2020/4/27.
//  Copyright © 2020 Farben. All rights reserved.
//

#import "YDTabBarViewController.h"
#import "Header.h"
#import "YDMainViewController.h"
#import "YDPersonalViewController.h"

#define BARHEIGHT 44.f


@interface YDTabBarViewController ()

@property (nonatomic,strong)UIView *barView;

@end

@implementation YDTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setselfViewControllers];
    
}

-(void)setselfViewControllers{
    YDMainViewController *one = [[YDMainViewController alloc]init];
    UINavigationController *oneNav = [[UINavigationController alloc]initWithRootViewController:one];
    oneNav.tabBarItem.selectedImage = [UIImage imageNamed:@"caidan-1.png"];
    oneNav.tabBarItem.image = [UIImage imageNamed:@"caidan.png"];
    one.title = @"";
    
    YDPersonalViewController *two = [[YDPersonalViewController alloc]init];
    UINavigationController *twoNav = [[UINavigationController alloc]initWithRootViewController:two];
    twoNav.tabBarItem.selectedImage = [UIImage imageNamed:@"zhanghaosvg-1.png"];
    twoNav.tabBarItem.image = [UIImage imageNamed:@"zhanghaosvg.png"];
    two.title = @"";
    
    
    self.viewControllers =@[oneNav,twoNav];
    self.tabBar.tintColor = MainColor;
    self.tabBar.backgroundColor = [UIColor whiteColor];
//    self.tabBar.hidden = YES;
    //设置导航栏背景色和文字颜色
    [[UINavigationBar appearance] setBarTintColor:MainColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [self.view addSubview:self.barView];
    
}


-(UIView*)barView{
    if(!_barView){
        _barView = [[UIView alloc]init];
        _barView.backgroundColor = RGBA(244, 244, 244, 0.4);
        _barView.frame = CGRectMake(0, ScreenHeight - SafeAreaBottomHeight - BARHEIGHT, ScreenWidth, SafeAreaBottomHeight + BARHEIGHT);
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        leftButton.frame = CGRectMake(0, 5, 30, 30);
        [leftButton setBackgroundImage:[UIImage imageNamed:@"杨"] forState:UIControlStateNormal];
        [_barView addSubview:leftButton];
    }
    return _barView;
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
