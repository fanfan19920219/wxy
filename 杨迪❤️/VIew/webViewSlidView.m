//
//  webViewSlidView.m
//  杨迪❤️
//
//  Created by Farben on 2020/5/4.
//  Copyright © 2020 Farben. All rights reserved.
//

#import "webViewSlidView.h"

@implementation webViewSlidView

-(webViewSlidView *)contentView{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"webViewSlidView" owner:self options:nil];
    return [nibView objectAtIndex:0];
}

@end
