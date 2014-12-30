//
//  OTPageView.m
//  OTPageScrollView
//
//  Created by yechunxiao on 14-12-10.
//  Copyright (c) 2014年 Oolong Tea. All rights reserved.
//

#import "OTPageView.h"

@implementation OTPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pageScrollView = [[OTPageScrollView alloc] init];
        [self.pageScrollView setPagingEnabled:YES];
        [self.pageScrollView setClipsToBounds:NO];
        self.pageScrollView.pageViewWith = self.frame.size.width;
        [self addSubview:self.pageScrollView];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!CGRectContainsPoint(self.pageScrollView.frame, point)) {
        return self.pageScrollView;
    }
    return [super hitTest:point withEvent:event];
}

@end
