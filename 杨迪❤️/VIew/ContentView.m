//
//  ContentView.m
//  天上琳琅
//
//  Created by Farben on 2020/4/27.
//  Copyright © 2020 Farben. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView



-(ContentView *)contentView{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ContentView" owner:self options:nil];
    return [nibView objectAtIndex:0];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
