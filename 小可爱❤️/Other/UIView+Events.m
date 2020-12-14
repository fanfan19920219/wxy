//
//  UIView+Events.m
//  小可爱❤️
//
//  Created by Farben on 2020/5/4.
//  Copyright © 2020 Farben. All rights reserved.
//

#import "UIView+Events.h"

//

#import "UIView+Events.h"
#import <objc/runtime.h>

static const void *YSUIViewBlockKey = &YSUIViewBlockKey;

@interface  UIView ()



@property void(^clickBlock)(id);

@end

@implementation UIView (Events)




- (NSMutableDictionary *)gestureBlocks
{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        obj = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(gestureBlocks), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}



#pragma mark - Category Events

- (id)addGestureTarget:(id)target action:(SEL)action gestureClass:(Class)class {
    UIGestureRecognizer *gesture = [[class alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:gesture];
    return gesture;
}

- (UITapGestureRecognizer *)addGestureTapTarget:(id)target action:(SEL)action {
    return [self addGestureTarget:target action:action gestureClass:[UITapGestureRecognizer class]];
}

- (UIPanGestureRecognizer *)addGesturePanTarget:(id)target action:(SEL)action {
    return [self addGestureTarget:target action:action gestureClass:[UIPanGestureRecognizer class]];
}

- (UIPinchGestureRecognizer *)addGesturePinchTarget:(id)target action:(SEL)action {
    return [self addGestureTarget:target action:action gestureClass:[UIPinchGestureRecognizer class]];
}

- (UILongPressGestureRecognizer *)addGestureLongPressTarget:(id)target action:(SEL)action {
    return [self addGestureTarget:target action:action gestureClass:[UILongPressGestureRecognizer class]];
}

- (UISwipeGestureRecognizer *)addGestureSwipeTarget:(id)target action:(SEL)action {
    return [self addGestureTarget:target action:action gestureClass:[UISwipeGestureRecognizer class]];
}

- (UIRotationGestureRecognizer *)addGestureRotationTarget:(id)target action:(SEL)action {
    return [self addGestureTarget:target action:action gestureClass:[UIRotationGestureRecognizer class]];
}

- (UIScreenEdgePanGestureRecognizer *)addGestureScreenEdgePanTarget:(id)target action:(SEL)action {
    return [self addGestureTarget:target action:action gestureClass:[UIScreenEdgePanGestureRecognizer class]];
}



#pragma mark - Category Block Events

- (id)addGestureEventHandle:(void (^)(id, id))event gestureClass:(Class)class {
    UIGestureRecognizer *gesture = [[class alloc] initWithTarget:self action:@selector(handleGestureRecognizer:)];
    [self addGestureRecognizer:gesture];
    if (event) {
        [[self gestureBlocks] setObject:event forKey:NSStringFromClass(class)];
    }
    return gesture;
}

- (UITapGestureRecognizer *)addGestureTapEventHandle:(void (^)(id sender, UITapGestureRecognizer *recognizer))event {
    return [self addGestureEventHandle:event gestureClass:[UITapGestureRecognizer class]];
}

- (UIPanGestureRecognizer *)addGesturePanEventHandle:(void (^)(id sender, UIPanGestureRecognizer *recognizer))event {
    return [self addGestureEventHandle:event gestureClass:[UIPanGestureRecognizer class]];
}

- (UIPinchGestureRecognizer *)addGesturePinchEventHandle:(void (^)(id sender, UIPinchGestureRecognizer *recognizer))event {
    return [self addGestureEventHandle:event gestureClass:[UIPinchGestureRecognizer class]];
}

- (UILongPressGestureRecognizer *)addGestureLongPressEventHandle:(void (^)(id sender, UILongPressGestureRecognizer *recognizer))event {
    return [self addGestureEventHandle:event gestureClass:[UILongPressGestureRecognizer class]];
}

- (UISwipeGestureRecognizer *)addGestureSwipeEventHandle:(void (^)(id sender, UISwipeGestureRecognizer *recognizer))event {
    return [self addGestureEventHandle:event gestureClass:[UISwipeGestureRecognizer class]];
}

- (UIRotationGestureRecognizer *)addGestureRotationEventHandle:(void (^)(id sender, UIRotationGestureRecognizer *recognizer))event {
    return [self addGestureEventHandle:event gestureClass:[UIRotationGestureRecognizer class]];
}

- (UIScreenEdgePanGestureRecognizer *)addGestureScreenEdgePanEventHandle:(void (^)(id sender, UIScreenEdgePanGestureRecognizer *recognizer))event {
    return [self addGestureEventHandle:event gestureClass:[UIScreenEdgePanGestureRecognizer class]];
}



#pragma mark -

- (void)handleGestureRecognizer:(UIGestureRecognizer *)gesture
{
    NSString *key = NSStringFromClass(gesture.class);
    void (^block)(id sender, UIGestureRecognizer *tap) = [self gestureBlocks][key];
    block ? block(self, gesture) : nil;
}




- (void)setClickBlock:(void (^)(id))clickBlock {
    objc_setAssociatedObject(self, YSUIViewBlockKey, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(id))clickBlock{
    return objc_getAssociatedObject(self, YSUIViewBlockKey);
}

- (void)addClickEventBlock:(void (^)(id obj))aBlock {
    self.clickBlock = aBlock;
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blockAction)];
        [self addGestureRecognizer:tap];
    }
}

- (void)blockAction {
    if (self.clickBlock) {
        self.clickBlock(self);
    }
}

@end
