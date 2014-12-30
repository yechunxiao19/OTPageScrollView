//
//  OTPageCell.m
//  OTPageScrollView
//
//  Created by yechunxiao on 14-8-4.
//  Copyright (c) 2014年 Oolong Tea. All rights reserved.
//

#import "OTPageCell.h"

@implementation OTPageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView* contentV = [UIView new];
        contentV.backgroundColor = [UIColor clearColor];
        [self setContentView:contentV];
        
        UIView* selectedV = [UIView new];
        selectedV.backgroundColor = [UIColor lightGrayColor];
        [self setSelectedBackgroundView:selectedV];
    }
    return self;
}

- (instancetype)initWithIdentifiy:(NSString*)identifiy{
    self = [super init];
    if (self) {
        _identifiy = identifiy;
    }
    return self;
}

- (void) layoutSubviews
{
    _contentView.frame = self.bounds;
    if (_isSelected) {
        _selectedBackgroundView.frame = _contentView.bounds;
        _selectedBackgroundView.hidden =  NO;
        [_contentView insertSubview:_selectedBackgroundView atIndex:0];
    }
    else
    {
        _selectedBackgroundView.hidden = YES;
    }
}

- (void) setContentView:(UIView *)contentView
{
    if (_contentView != contentView) {
        [_contentView removeFromSuperview];
        _contentView = contentView;
        [self addSubview:contentView];
        [self setNeedsLayout];
    }
}

- (void) setSelectedBackgroundView:(UIView *)selectedBackgroundView{
    if (_selectedBackgroundView != selectedBackgroundView) {
        [_selectedBackgroundView removeFromSuperview];
        _selectedBackgroundView = selectedBackgroundView;
        [self addSubview:_selectedBackgroundView];
        [self setNeedsLayout];
    }
}

- (void) setIsSelected:(BOOL)isSelected
{
    if (_isSelected != isSelected) {
        _isSelected = isSelected;
        [self setNeedsLayout];
    }
}

- (void) prepareForReused
{
    _index = NSNotFound;
    [self setIsSelected:NO];
}

@end
