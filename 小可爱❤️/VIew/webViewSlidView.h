//
//  webViewSlidView.h
//  小可爱❤️
//
//  Created by Farben on 2020/5/4.
//  Copyright © 2020 Farben. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface webViewSlidView : UIView

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
-(webViewSlidView *)contentView;
@property (weak, nonatomic) IBOutlet UIButton *lastPage;

@property (weak, nonatomic) IBOutlet UIButton *exitPage;

@end

NS_ASSUME_NONNULL_END
