//
//  YDgetupViewController.m
//  小可爱❤️
//
//  Created by Star J on 2020/4/29.
//  Copyright © 2020 Farben. All rights reserved.
//

#import "YDgetupViewController.h"
#import "Header.h"
#import "ContentView.h"

@interface YDgetupViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;

//@property (nonatomic,strong)UIImageView *backImageView;

@end

@implementation YDgetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor= ColorWhite;
    self.backScrollView.contentSize = CGSizeMake(0, 1000);
    
    
}


- (IBAction)addCase:(UIButton *)sender {
    ContentView *addContentView = [[ContentView alloc]dateView];
    addContentView.frame = CGRectMake(40, 150, 300, 300);
    [self.view addSubview:addContentView];
    
//    ContentView *addContentView = [[ContentView alloc]dateView];
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
