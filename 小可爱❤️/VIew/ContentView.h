//
//  ContentView.h
//  天上琳琅
//
//  Created by Farben on 2020/4/27.
//  Copyright © 2020 Farben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentView : UIView

@property (weak, nonatomic) IBOutlet UITextField *caseTextField;

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UITextField *addTimeTextField;

@property (weak, nonatomic) IBOutlet UIButton *meituanButton;

@property (weak, nonatomic) IBOutlet UIButton *eatButton;

@property (weak, nonatomic) IBOutlet UIButton *weatherButton;


-(ContentView *)contentView;

-(ContentView*)dateView;

@end

NS_ASSUME_NONNULL_END
