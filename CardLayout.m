
//
//  LineLayout.m
//  TestCollection
//
//  Created by Eric on 15/5/14.
//  Copyright (c) 2015年 eric. All rights reserved.
//
#import "CardLayout.h"



@interface CardLayout ()

@property (nonatomic,strong ) UICollectionViewLayoutAttributes* attributes;


@end
#define         RIDO_TO_5S              [[UIScreen mainScreen] bounds].size.width / 320.0
#define ITEM_SIZE_HEIGHT 267.0
#define ITEM_SIZE_WIDTH 205.0
@implementation CardLayout

#define ACTIVE_DISTANCE 100
#define ZOOM_FACTOR     0.4


-(id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(ITEM_SIZE_WIDTH*RIDO_TO_5S, ITEM_SIZE_HEIGHT*RIDO_TO_5S);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(130*RIDO_TO_5S, 0.0, 180*RIDO_TO_5S, 0.0);
        self.LineSpace = -237;
        self.Zoom = ZOOM_FACTOR;
        self.minimumLineSpacing = self.LineSpace*RIDO_TO_5S ;

    }
    return self;
}



- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}



-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array     = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size   = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        
        attributes.zIndex = attributes.indexPath.row;//z轴排序
        
        if (CGRectIntersectsRect(attributes.frame, rect)) {

            CGFloat distance           = CGRectGetMidY(visibleRect) - attributes.center.y;
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            CGFloat zoom               = 1 + self.Zoom*(1 - ABS(normalizedDistance));
            
            
            if (ABS(distance) < 30) {
                if (attributes != nil && self.attributes.indexPath.row !=attributes.indexPath.row) {
                    self.attributes = [attributes copy];
                    if ([_delegate respondsToSelector:@selector(CardLayout:didscrollToItematRow:)]) {
                        [_delegate CardLayout:self didscrollToItematRow:(int)self.attributes.indexPath.row];
                    }

                }
//                NSLog(@"%ld",(long)self.attributes.indexPath.row);
                
                
                
                for ( UICollectionViewLayoutAttributes* attributes in array) {
                    if (attributes.indexPath.row>self.attributes.indexPath.row+1||attributes.indexPath.row<self.attributes.indexPath.row-7) {
                        
                        attributes.transform3D     = CATransform3DMakeScale(zoom, zoom, 1.0);
                        attributes.hidden = YES;
                        
                        

                  
                       
                    }else if (attributes.indexPath.row<self.attributes.indexPath.row){
                        
                        int alphaindex ;
                        alphaindex = (int)(self.attributes.indexPath.row-attributes.indexPath.row);
                        
                        
                        attributes.alpha =(7-alphaindex)*0.2;
                        
                        
                        //修改间距代码
//                        attributes.transform3D = CATransform3DIdentity;
//                        CGRect frame = attributes.frame;
//                        
//                        switch (alphaindex) {
//                            case 1:
//                                frame.origin.y -= 10;
//                                break;
//                            case 2:
//                                frame.origin.y -= 3;
//                                break;
//                            case 3:
//                                break;
//                            case 4:
//                                frame.origin.y += 10;
//                                break;
//                            case 5:
//                                frame.origin.y += 20;
//                                break;
//                            case 6:
//                                frame.origin.y += 30;
//                                break;
//                                
//
//                            default:
//
//                                break;
//                        }
//                        
//                        attributes.frame = frame;

                        CGFloat distance           = CGRectGetMidY(visibleRect) - attributes.center.y;
                        CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
                        CGFloat zoom               = 1 + self.Zoom*(1 - ABS(normalizedDistance));
                        
                        attributes.transform3D     = CATransform3DMakeScale(zoom, zoom, 1.0);
                        
                        
            }else if (attributes.indexPath.row ==self.attributes.indexPath.row+1 ){
                        CGFloat distance           = CGRectGetMidY(visibleRect) - attributes.center.y;
                        CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
                        CGFloat zoom               = 1+ self.Zoom*(1 - ABS(normalizedDistance));
                        
                        int z =(int)(zoom*1000);
//                        NSLog(@"%d",z);
                        attributes.transform3D =CATransform3DIdentity ;
                        CGRect frame;
                        frame = attributes.frame;
                        frame.origin.y +=1.8*abs(1400-z)*RIDO_TO_5S;
                        attributes.frame = frame;
                        attributes.transform3D = CATransform3DMakeScale(1.4, 1.4, 1.0) ;
                
                        
                    }
                    else if (self.attributes.indexPath.row == attributes.indexPath.row){
                        attributes.transform3D =CATransform3DIdentity ;

                        CGFloat distance           = CGRectGetMidY(visibleRect) - attributes.center.y;
                        CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
                        CGFloat zoom               = 1 + self.Zoom*(1 - ABS(normalizedDistance));
                        
                        attributes.transform3D     = CATransform3DMakeScale(1.4, 1.4, 1.0);

                    }
                    
                }
            }
            
        }
    }
    
    for ( UICollectionViewLayoutAttributes* attributes in array) {
        CGFloat distance           = CGRectGetMidY(visibleRect) - attributes.center.y;

        if (attributes.indexPath.row>self.attributes.indexPath.row+1||attributes.indexPath.row<self.attributes.indexPath.row-7) {
//            CGFloat distance           = CGRectGetMidY(visibleRect) - attributes.center.y;
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            CGFloat zoom               = 1 + self.Zoom*(1 - ABS(normalizedDistance));
            attributes.transform3D     = CATransform3DMakeScale(zoom, zoom, 1.0);
            attributes.hidden = YES;
            
            
            
            
            
        }else if (attributes.indexPath.row<self.attributes.indexPath.row){
            
            int alphaindex ;
            alphaindex = (int)(self.attributes.indexPath.row-attributes.indexPath.row);
            
            
            attributes.alpha =(7-alphaindex)*0.2;
            
            
            CGFloat distance           = CGRectGetMidY(visibleRect) - attributes.center.y;
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            CGFloat zoom               = 1 + self.Zoom*(1 - ABS(normalizedDistance));
            
            attributes.transform3D     = CATransform3DMakeScale(zoom, zoom, 1.0);
            
            
        }else if (attributes.indexPath.row ==self.attributes.indexPath.row+1 ){
            CGFloat distance           = CGRectGetMidY(visibleRect) - attributes.center.y;
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            CGFloat zoom               = 1+ self.Zoom*(1 - ABS(normalizedDistance));
            
            int z =(int)(zoom*1000);
//            NSLog(@"%d",z);
            attributes.transform3D =CATransform3DIdentity ;
            CGRect frame;
            frame = attributes.frame;
            frame.origin.y +=0.2*abs(1400-z)*RIDO_TO_5S;
            attributes.frame = frame;
            attributes.transform3D =CATransform3DMakeScale(1.4, 1.4, 1.0) ;
        }
        else if (self.attributes.indexPath.row == attributes.indexPath.row){
            attributes.transform3D =CATransform3DIdentity ;
            
            CGFloat distance           = CGRectGetMidY(visibleRect) - attributes.center.y;
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            CGFloat zoom               = 1 + self.Zoom*(1 - ABS(normalizedDistance));
            
            attributes.transform3D     = CATransform3DMakeScale(1.4, 1.4, 1.0);
            
            
            
        }
        
    }

    return array;
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.y + (CGRectGetHeight(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(0.0, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        
        CGFloat itemHorizontalCenter = layoutAttributes.center.y;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
            
            //调整

            
        }
    }
    
    return CGPointMake(proposedContentOffset.x, proposedContentOffset.y + offsetAdjustment );
}

@end