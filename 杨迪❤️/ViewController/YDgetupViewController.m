//
//  YDgetupViewController.m
//  杨迪❤️
//
//  Created by Star J on 2020/4/29.
//  Copyright © 2020 Farben. All rights reserved.
//

#import "YDgetupViewController.h"
#import "Header.h"

@interface YDgetupViewController ()

@property (nonatomic,strong)UIImageView *backImageView;

@end

@implementation YDgetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.backImageView.image = [UIImage imageNamed:@"起床背景"];
    self.backImageView.alpha = 0.4;
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    [self.view addSubview:self.backImageView];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor= ColorWhite;
    
    
}


- (IBAction)addCase:(UIButton *)sender {
}

- (IBAction)cancelClick:(UIButton *)sender {
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
