//
//  TestCollectionViewCell.h
//  TestCollection
//
//  Created by Eric on 15/5/21.
//  Copyright (c) 2015年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TestCollectionViewCell;
@protocol TestCollectionViewCellDelegate <NSObject>
@optional
- (void) didDeletecell:(TestCollectionViewCell *)cell ;


@end

@interface TestCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIView *contentV;
@property (nonatomic,weak) id<TestCollectionViewCellDelegate> delegate;
@property (nonatomic,assign) NSIndexPath *indexPath;

+ (instancetype)cellWith:(UICollectionView *)collectionview withIndexpath:(NSIndexPath*)indexpath;
@end
