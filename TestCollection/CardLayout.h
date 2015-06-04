//
//  LineLayout.h
//  TestCollection
//
//  Created by Eric on 15/5/14.
//  Copyright (c) 2015年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CardLayout;
@protocol LinlayoutDelegate<NSObject>
@optional
-(void) CardLayout:(CardLayout *)CardLayout didscrollToItematRow:(NSInteger)row;
@end

@interface CardLayout : UICollectionViewFlowLayout
@property (weak,nonatomic)id <LinlayoutDelegate> delegate;
@property (nonatomic,assign) int LineSpace;
@property (nonatomic,assign) float Zoom;


@end
