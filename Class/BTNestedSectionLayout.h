//
//  BTNestedSectionLayout.h
//  Demo
//
//  Created by Tongtong Xu on 15/6/24.
//  Copyright (c) 2015年 Luxi Innovation Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 代表最高层级的值
 */
extern const NSInteger BTLayoutHierarchyDefault;

/**
 获取SectionHeaderView的层级的协议
 */
@protocol BTNestedSectionLayoutProtocol

/**
 获取SectionHeaderView的层级
 
 最高层级为BTLayoutHierarchyDefault
 其他层级根据实际情况由BTLayoutHierarchyDefault减值获得
 
 @param section SectionHeaderView的section
 
 @return 该SectionHeaderView的层级
 */
- (NSInteger)sectionHeaderHierarchy:(NSUInteger)section;

@end

@interface BTNestedSectionLayout : UICollectionViewFlowLayout

@end