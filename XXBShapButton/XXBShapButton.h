//
//  XXBShapButton.h
//  XXBSahpButtonDemo
//
//  Created by xiaobing5 on 2018/11/30.
//  Copyright © 2018 xiaobing5. All rights reserved.
//

#import <UIKit/UIKit.h>

// -[UIView hitTest:withEvent: ignores views that an alpha level less than 0.1.
// So we will do the same and treat pixels with alpha < 0.1 as transparent.
#define kAlphaVisibleThreshold (0.1f)

@interface XXBShapButton : UIButton

- (void)resetHitTestCache;
@end
