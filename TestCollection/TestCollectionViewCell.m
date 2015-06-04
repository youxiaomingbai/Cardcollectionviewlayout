//
//  TestCollectionViewCell.m
//  TestCollection
//
//  Created by Eric on 15/5/21.
//  Copyright (c) 2015年 eric. All rights reserved.
//

#import "TestCollectionViewCell.h"
#define             WINDOW_WIDTH     [[UIScreen mainScreen] bounds].size.width






@interface TestCollectionViewCell()<UIGestureRecognizerDelegate>
@property (nonatomic, assign) CGFloat deleteWeight;
@property (nonatomic, assign) CGFloat contentWeight;
@property (nonatomic, assign) CGFloat detaW;

@property (nonatomic, assign) CGPoint panStartPoint;


@end

@implementation TestCollectionViewCell


+ (instancetype)cellWith:(UICollectionView *)collectionview withIndexpath:(NSIndexPath *)indexpath
{
    static NSString *cellID = @"HomeCellB";
    TestCollectionViewCell *cell = [collectionview dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexpath];
    cell.indexPath = indexpath;
    if (!cell) {
        cell = [[TestCollectionViewCell alloc] init];
    }
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.deleteWeight = WINDOW_WIDTH * 0.35;
        
        
       
        
        [self setUpViews];
        [self setUpGestureRecognizer];
    }
    return self;
}


#pragma mark  ----设置内部控件
- (void)setUpViews{
    self.contentV = [[UIView alloc]init];

    [self.contentV setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentV setUserInteractionEnabled:YES];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor yellowColor];
    CGRect frame = self.contentV.frame;
    btn.frame = CGRectMake(frame.size.width-50, frame.size.height - 50, 50, 50);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentV addSubview:btn];
    [self.contentView addSubview:self.contentV];
}
- (void)btnClick:(UIButton *)btn{
    NSLog(@"2222");
}
- (void)setUpGestureRecognizer{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cellDidSwip:)];
    [pan setDelegate:self];
    [self.contentV addGestureRecognizer:pan];
    

}

- (void)cellDidSwip:(UIPanGestureRecognizer *)pan{
    
    switch (pan.state) {
    case UIGestureRecognizerStateBegan:
       
        
        self.panStartPoint = [pan translationInView:self.contentV];
        break;
        
    case UIGestureRecognizerStateChanged:{
        CGPoint current = [pan translationInView:self.contentV];
        CGFloat deltaX = current.x - self.panStartPoint.x;
        if (fabs(deltaX) < self.deleteWeight&& deltaX<0) {
            self.contentV.transform = CGAffineTransformMakeTranslation(-fabs(deltaX), 0);
            [UIView animateWithDuration:0.5f animations:^{
                self.contentV.alpha = (100-fabs(deltaX))/100+0.5;
            }];
           
        }
        break;
    case UIGestureRecognizerStateEnded:{
        CGPoint end = [pan translationInView:self.contentV];
        CGFloat deltaX = end.x - self.panStartPoint.x;
        if (fabs(deltaX)<self.deleteWeight || deltaX>0) {
            [UIView animateWithDuration:0.5f animations:^{
                self.contentV.transform = CGAffineTransformMakeTranslation(0, 0);

                self.contentV.alpha = 1;
            }];
        }
        else{
           
            [self cellDeleted];
        }
    }
        
      
        
      }
        
    }
    

}


- (void)cellDeleted
{
    [UIView animateWithDuration:0.5f animations:^{
        self.contentV.transform = CGAffineTransformMakeTranslation(-self.deleteWeight*2, 0);
        self.contentV.alpha = 0;
        
        
    } completion:^(BOOL finished) {
        NSLog(@"删除");
        if ([_delegate respondsToSelector:@selector(didDeletecell:)]) {
            
            [self.delegate didDeletecell:self];
        }
        self.contentV.transform = CGAffineTransformMakeTranslation(0, 0);
        self.contentV.alpha = 1;
    }];
}



-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer {
    // We only want to deal with the gesture of it's a pan gesture
    
    if ([panGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        
        return YES;
    }
    
    if ([panGestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return YES;
    }
    
    if ([panGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [panGestureRecognizer translationInView:[self superview]];
        return (fabs(translation.x) / fabs(translation.y) > 1) ? YES : NO;
    } else {
        return NO;
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    
   
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return NO;
    }
    return YES;
}
@end
