//
//  YDPersonalViewController.m
//  杨迪❤️
//  
//  Created by Farben on 2020/4/27.
//  Copyright © 2020 Farben. All rights reserved.
//

#import "YDPersonalViewController.h"

@interface YDPersonalViewController ()

@end

@implementation YDPersonalViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor blackColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (IBAction)getup:(UIButton *)sender {
    NSLog(@"current");
}

- (IBAction)eat:(UIButton *)sender {
    NSLog(@"current");
}

- (IBAction)accompany:(UIButton *)sender {
    NSLog(@"current");
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
