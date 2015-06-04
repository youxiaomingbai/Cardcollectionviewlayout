# Cardcollectionviewlayout
一个自定义的UICollectionviewLayout类 ，可以实现卡片式滚动效果，使用简单 扩展性强。


 ![image](https://github.com/youxiaomingbai/Cardcollectionviewlayout/raw/master/example.png)


使用方法：


1.实例化：CardLayout *layout=[[CardLayout alloc]init];
           [layout setDelegate:self];
  代理返回给控制器当前item.row
  
  
  
  
  
2.self.collectionV = [[TestCollectionView alloc]initWithFrame:frame collectionViewLayout:layout];

