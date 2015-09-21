# BTNestedSectionLayout
UICollectionView中嵌套的SectionHeaderView，设置好层级属性后可以无限设置层级。

效果图

![image](https://raw.githubusercontent.com/hero-nature/BTNestedSectionLayout/master/effect.gif)

####  使用方法

1. 在Storyboard设置UICollectionView的collectionViewLayout的类型为BTNestedSectionLayout。

2. 在UICollectionView的delegate中实现代理方法，设置层级。

       - (NSInteger)sectionHeaderHierarchy:(NSUInteger)section;
