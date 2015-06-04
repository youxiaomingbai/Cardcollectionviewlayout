//
//  TestCollectionViewController.m
//  TestCollection
//
//  Created by Eric on 15/5/12.
//  Copyright (c) 2015年 eric. All rights reserved.
//

#import "TestCollectionViewController.h"
#import "TestCollectionView.h"
#import "CardLayout.h"
#import "TestCollectionViewCell.h"


@interface TestCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,LinlayoutDelegate,TestCollectionViewCellDelegate>
//@property(nonatomic,strong) NSIndexPath *hiddenindexpath;

@property (nonatomic, strong) TestCollectionView *collectionV;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,assign) NSInteger currentItemNum;
@property (nonatomic,strong) NSMutableArray *arrM;
@property (nonatomic,assign) BOOL isLoad;


@end

@implementation TestCollectionViewController


static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.arrM= [NSMutableArray arrayWithCapacity:200];
    NSArray *arr = @[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1];
    self.arrM= [NSMutableArray arrayWithArray:arr];
    CardLayout *layout=[[CardLayout alloc]init];
    [layout setDelegate:self];
    self.collectionV = [[TestCollectionView alloc]initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) collectionViewLayout:layout];
    
    [self.collectionV registerClass:[TestCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCellB"];
//    self.collectionV.backgroundColor = [UIColor redColor];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
//    self.collectionV.contentInset =UIEdgeInsetsMake(5, 0, 5, 0);
    [self.view addSubview:self.collectionV];
    self.collectionV.decelerationRate=0;
    
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(100, [[UIScreen mainScreen] bounds].size.height - 100,100 , 50)];
    [self.label setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.label];
    self.collectionV.scrollsToTop = NO;
    
    
    NSIndexPath *indexpath= [NSIndexPath indexPathForItem:20 inSection:0];
    
    [self.collectionV scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
    
    
    
    
    



//    [self.collectionView scrollToItemAtIndexPath:self.indexpath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    
//    [self.collectionView setPagingEnabled:YES];
//    self.collectionView.alwaysBounceHorizontal=YES;
    
    // Do any additional setup after loading the view.
//    self.collectionView.scrollEnabled= NO;
//    UIPanGestureRecognizer *recognizer= [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(Pan:)];
//    [self.collectionView addGestureRecognizer:recognizer];
       
//    [self reloadInputViews];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)setCurrentItemNum:(NSInteger)currentItemNum{
//    
//    if (_currentItemNum !=6 && currentItemNum ==6&& _isLoad ==NO) {
//        _isLoad = YES;
//            NSInteger i = 0;
//        i++;
//            NSLog(@"%d",i);
//            NSArray *arr = @[@1,@1];
////            NSRange rang = NSMakeRange(0, [arr count]);
////            NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:rang];
////            [self.arrM insertObjects:arr atIndexes:set];
//            //        [self.collectionV reloadData];
//            
//        
//    }
//    _currentItemNum = currentItemNum;
//}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrM.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TestCollectionViewCell *cell = [TestCollectionViewCell cellWith:collectionView withIndexpath:indexPath];
    cell.hidden = NO;
    cell.delegate=self;
    
    
    cell.contentV.backgroundColor = indexPath.row%2 ?([UIColor redColor]) :[UIColor blueColor];
    return cell;
}
#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d---%d",indexPath.section,indexPath.row);
    if (self.currentItemNum != indexPath.row) {
        [self.collectionV scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
        
//        [self.collectionV reloadData];
    }
    
}


-(void)CardLayout:(CardLayout *)linelayout didscrollToItematRow:(NSInteger)row{
    NSString *string=[NSString stringWithFormat:@"当前%ld",(long)row];
    [self.label setText:string];
    self.currentItemNum = row;
    
    
}

-(void)didDeletecell:(TestCollectionViewCell *)cell{
    NSLog(@"%d",cell.indexPath.row);
    [self.arrM removeObjectAtIndex:cell.indexPath.row];
    NSArray *cells = [self.collectionV visibleCells];
    
    for (TestCollectionViewCell *cel in cells) {
        if (cel.indexPath.row > cell.indexPath.row) {
            cel.indexPath = [NSIndexPath indexPathForRow:cel.indexPath.row - 1 inSection:cel.indexPath.section];
        }
    }
    
//    [self.collectionV deleteItemsAtIndexPaths:@[cell.indexPath]];
    [self.collectionV reloadData];
//    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:cell.indexPath.row-1 inSection:0];
//    [self.collectionV scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}

-(void)insertTop{
//    NSIndexPath *firstindex = [NSIndexPath indexPathForItem:1 inSection:1];
//   [self.collectionV performBatchUpdates:^{
//       [self.collectionV insertItemsAtIndexPaths:@[firstindex]];
//   } completion:nil] ;
    
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    [self.collectionV setContentOffset:CGPointMake(targetContentOffset->x, targetContentOffset->y)animated:YES];
}

//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
////    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:self.currentItemNum+1 inSection:0];
////    TestCollectionViewCell *cell = [self.collectionV cellForItemAtIndexPath:indexpath];
////    [UIView animateWithDuration:0.3f animations:^{
////        cell.alpha = 0.5;
////        
////        
////    } completion:^(BOOL finished) {
////        cell.hidden = YES;
////    }];
//////
////
//    [self.collectionV reloadData];
//}


@end
