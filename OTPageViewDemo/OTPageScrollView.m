//
//  OTPageScrollView.m
//  OTPageScrollView
//
//  Created by yechunxiao on 7/22/14.
//  Copyright (c) 2014 Oolong Tea. All rights reserved.
//

#import "OTPageScrollView.h"

@interface OTPageScrollView()

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) NSMutableArray * viewsInPage;
@property (nonatomic, assign) NSInteger numberOfCell;

@end

@implementation OTPageScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeValue];
        [self reloadData];
    }
    return self;
}

- (void)initializeValue
{
    self.clipsToBounds = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.autoresizesSubviews = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.multipleTouchEnabled = NO;
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    [self addGestureRecognizer:self.tapGesture];
}

- (void)reloadData
{
    if (!self.delegate || ![self.delegate respondsToSelector:@selector(numberOfPageInPageScrollView:)]) {
        return;
    }
    if (!self.dataSource || ![self.dataSource respondsToSelector:@selector(pageScrollView:viewForRowAtIndex:)]) {
        return;
    }
    
    _cellSize.width = self.frame.size.width - self.padding * 2 - 10 * 2;
    if ([self.delegate respondsToSelector:@selector(sizeCellForPageScrollView:)]) {
        _cellSize = [self.delegate sizeCellForPageScrollView:self];
    }
    
    _numberOfCell = [self.delegate numberOfPageInPageScrollView:self];
    
    float startX = self.leftRightOffset;
    float topY   = (self.frame.size.height - _cellSize.height)/2;
    
    [[self subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    self.viewsInPage = nil;
    self.viewsInPage = [NSMutableArray array];
    
    for (int i = 0; i < _numberOfCell; i ++) {
        UIView * cell = [self.dataSource pageScrollView:self viewForRowAtIndex:i];
        cell.frame = CGRectMake(startX, topY, _cellSize.width, _cellSize.height);
        [self addSubview:cell];
        startX += self.padding + _cellSize.width;
        [self.viewsInPage addObject:cell];
    }
    
    float scrollViewSizeWith = startX - self.padding + (self.frame.size.width - _cellSize.width)/2;
    self.contentSize = CGSizeMake(scrollViewSizeWith, 1);
}

- (UIView*)viewForRowAtIndex:(NSInteger)index
{
    if (index < self.viewsInPage.count) {
        return self.viewsInPage[index];
    }
    return nil;
}

#pragma mark - Properties

- (NSMutableArray*)viewsInPage
{
    if (!_viewsInPage) {
        _viewsInPage = [NSMutableArray array];
    }
    return _viewsInPage;
}

- (UITapGestureRecognizer*)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [_tapGesture setNumberOfTapsRequired:1];
        [_tapGesture setNumberOfTouchesRequired:1];
    }
    return _tapGesture;
}

- (float)leftRightOffset
{
    if (!_leftRightOffset) {
        return (self.frame.size.width - _cellSize.width)/2;
    }
    return _leftRightOffset;
}

- (CGFloat)padding{
    if (!_padding) {
        return 10;
    }
    return _padding;
}

#pragma mark - Action

- (void)handleTapGesture:(UITapGestureRecognizer*)tapGesture
{
    CGPoint tapPoint = [tapGesture locationInView:self];
    
    float topY   = (self.frame.size.height - _cellSize.height)/2;
    BOOL yInCell = NO;
    if (tapPoint.y > topY && tapPoint.y < self.frame.size.height-topY){
        yInCell = YES;
    }
    int xInCellNumber = (tapPoint.x - self.leftRightOffset)/(_cellSize.width + self.padding);
    BOOL xInCell = NO;
    if (tapPoint.x > self.leftRightOffset + ((_cellSize.width + self.padding) * xInCellNumber)
        && tapPoint.x < self.leftRightOffset + ((_cellSize.width + self.padding) * xInCellNumber) + _cellSize.width) {
        xInCell = YES;
    }
    if (xInCellNumber < 0 || xInCellNumber >= _numberOfCell) {
        xInCell = NO;
    }
    if (yInCell && xInCell) {
        self.selectedIndex = xInCellNumber;
        [self.delegate pageScrollView:self didTapPageAtIndex:xInCellNumber];
        [UIView animateWithDuration:0.3 animations:^{
            [self setContentOffset:CGPointMake((_cellSize.width + self.padding) * xInCellNumber, 0)];
        }];
    }
}

@end
