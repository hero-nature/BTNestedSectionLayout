//
//  BTNestedSectionLayoutObject.h
//  Demo
//
//  Created by Tongtong Xu on 15/6/29.
//  Copyright (c) 2015年 Luxi Innovation Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UICollectionViewLayoutAttributes+Hierarchy.h"

@interface BTNestedSectionLayoutObject : NSObject

@property (nonatomic, strong) UICollectionViewLayoutAttributes *layoutAttributes;
@property (nonatomic, readonly) NSArray *subSections;
@property (nonatomic, weak) BTNestedSectionLayoutObject *superSection;
@property (nonatomic, weak) BTNestedSectionLayoutObject *nextSameLevelSection;

// add subSection layoutAttributes
- (void)addSubSectionLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes;
// arrange layoutAttributes
- (BOOL)arrangeLayoutAttributes:(UICollectionView *)collectionView;

@end
