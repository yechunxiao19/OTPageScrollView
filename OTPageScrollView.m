//
//  OTPageScrollView.m
//  OTPageScrollView
//
//  Created by akron on 7/22/14.
//  Copyright (c) 2014 Oolong Tea. All rights reserved.
//

#import "OTPageScrollView.h"

@interface OTPageScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong)   UIScrollView * scrollView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong)   NSMutableArray * viewsInPage;

@end

@implementation OTPageScrollView{
    CGSize    _cellSize;
    NSInteger _numberOfCell;
    
}

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
    _padding = 10;
    self.clipsToBounds = YES;
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
    
    [[self.scrollView subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    self.viewsInPage = nil;
    self.viewsInPage = [NSMutableArray array];
    
    for (int i = 0; i < _numberOfCell; i ++) {
        UIView * cell = [self.dataSource pageScrollView:self viewForRowAtIndex:i];
        cell.frame = CGRectMake(startX, topY, _cellSize.width, _cellSize.height);
        [self.scrollView addSubview:cell];
        startX += self.padding + _cellSize.width;
        [self.viewsInPage addObject:cell];
    }
    
    float scrollViewSizeWith = startX - self.padding + (self.frame.size.width - _cellSize.width)/2;
    self.scrollView.contentSize = CGSizeMake(scrollViewSizeWith, 1);
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

- (void)setPadding:(CGFloat)padding
{
    [self reloadData];
}

- (UITapGestureRecognizer*)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [_tapGesture setNumberOfTapsRequired:1];
        [_tapGesture setNumberOfTouchesRequired:1];
    }
    return _tapGesture;
}

- (UIScrollView*)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.autoresizesSubviews = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.multipleTouchEnabled = NO;
        _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        _scrollView.delegate = self;
        [_scrollView addGestureRecognizer:self.tapGesture];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (float)leftRightOffset
{
    return (self.frame.size.width - _cellSize.width)/2;
}

#pragma mark - Action

- (void)handlePanGesture:(UITapGestureRecognizer*)tapGesture
{
    CGPoint tapPoint = [tapGesture locationInView:self];
    
    float topY   = (self.frame.size.height - _cellSize.height)/2;
    BOOL yInCell = NO;
    if(tapPoint.y > topY && tapPoint.y < self.frame.size.height-topY) yInCell = YES;
    int xInCellNumber = (_scrollView.contentOffset.x + tapPoint.x - self.leftRightOffset)/(_cellSize.width + self.padding) + 1;
    if (yInCell) {
        [self.delegate pageScrollView:self didTapPageAtIndex:xInCellNumber];
    }
}

#pragma mark - Clean up

- (void)dealloc
{
    _viewsInPage = nil;
    [[self.scrollView subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self.scrollView removeFromSuperview];
    self.scrollView = nil;
}


@end
