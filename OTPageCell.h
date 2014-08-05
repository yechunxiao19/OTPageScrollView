//
//  OTPageCell.h
//  OTPageScrollView
//
//  Created by yechunxiao on 14-8-4.
//  Copyright (c) 2014年 Oolong Tea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTPageCell : UIView

@property (strong, nonatomic) UIView* contentView;
@property (strong, nonatomic) UIView* selectedBackgroundView;
@property (assign, nonatomic) BOOL isSelected;
@property (strong, nonatomic) NSString* identifiy;
@property (assign, nonatomic) NSInteger index;

- (instancetype)initWithIdentifiy:(NSString*)identifiy;

@end
