//
//  XXBShapButton.m
//  XXBSahpButtonDemo
//
//  Created by xiaobing5 on 2018/11/30.
//  Copyright © 2018 xiaobing5. All rights reserved.
//

#import "XXBShapButton.h"
#import "UIImage+Color.h"

@interface XXBShapButton()

/**
 上一次点击的点
 */
@property (nonatomic, assign) CGPoint previousTouchPoint;

/**
 上一次点击是否生效
 */
@property (nonatomic, assign) BOOL previousTouchHitTestResponse;

@end

@implementation XXBShapButton

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self resetHitTestCache];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [super setBackgroundImage:image forState:state];
    [self resetHitTestCache];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL superResult = [super pointInside:point withEvent:event];
    if (!superResult) {
        return superResult;
    }
    
    if (CGPointEqualToPoint(point, self.previousTouchPoint)) {
        return self.previousTouchHitTestResponse;
    } else {
        self.previousTouchPoint = point;
    }
    
    // We can't test the image's alpha channel if the button has no image. Fall back to super.
    UIImage *buttonImage = [self imageForState:UIControlStateNormal];
    UIImage *buttonBackground = [self backgroundImageForState:UIControlStateNormal];
    
    BOOL response = NO;
    
    if (buttonImage == nil && buttonBackground == nil) {
        response = NO;
    } else if (buttonImage != nil && !response) {
        
        if (CGRectContainsPoint(self.imageView.frame, point)) {
            CGPoint pointInImageView = [self convertPoint:point toView:self.imageView];
            response = [self isAlphaVisibleAtPoint:pointInImageView forImage:buttonImage andTouchViewSize:self.imageView.frame.size];
        }
    } else if (buttonBackground != nil && !response) {
        response = [self isAlphaVisibleAtPoint:point forImage:buttonImage andTouchViewSize:self.frame.size];
    }
    self.previousTouchHitTestResponse = response;
    return response;
}

- (BOOL)isAlphaVisibleAtPoint:(CGPoint)point forImage:(UIImage *)image  andTouchViewSize:(CGSize )touchViewSize{
    CGSize iSize = image.size;
    CGSize bSize = touchViewSize;
    point.x *= (bSize.width != 0) ? (iSize.width / bSize.width) : 1;
    point.y *= (bSize.height != 0) ? (iSize.height / bSize.height) : 1;
    
    CGColorRef pixelColor = [[image colorAtPixel:point] CGColor];
    CGFloat alpha = CGColorGetAlpha(pixelColor);
    return alpha >= kAlphaVisibleThreshold;
}


- (void)resetHitTestCache {
    self.previousTouchPoint = CGPointMake(CGFLOAT_MIN, CGFLOAT_MIN);
    self.previousTouchHitTestResponse = NO;
}
@end
