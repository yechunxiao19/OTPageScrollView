//
//  OTPageScrollView.h
//  OTPageScrollView
//
//  Created by yechunxiao on 7/22/14.
//  Copyright (c) 2014 Oolong Tea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OTPageScrollView;
@protocol OTPageScrollViewDelegate <UIScrollViewDelegate>
@required
- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView;
@optional
- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView;
- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index;
@end

@protocol OTPageScrollViewDataSource <UIScrollViewDelegate>
@required
- (UIView*)pageScrollView:(OTPageScrollView *)pageScrollView viewForRowAtIndex:(int)index;
@end

@interface OTPageScrollView : UIScrollView

@property (nonatomic, assign) CGSize  cellSize;

@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) float leftRightOffset;
@property (nonatomic, strong) UIImageView* backgroundView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray* visibleCell;
@property (nonatomic, strong) NSMutableSet* cacheCells;
@property (nonatomic, strong) NSMutableDictionary* visibleCellsMap;
@property (nonatomic, assign) CGFloat pageViewWith;

@property (nonatomic, weak) id<OTPageScrollViewDataSource> dataSource;
@property (nonatomic, weak) id<OTPageScrollViewDelegate> delegate;

- (void)reloadData;
- (UIView*)viewForRowAtIndex:(NSInteger)index;

@end
