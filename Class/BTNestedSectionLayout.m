//
//  BTNestedSectionLayout.m
//  Demo
//
//  Created by Tongtong Xu on 15/6/24.
//  Copyright (c) 2015年 Luxi Innovation Co. Ltd. All rights reserved.
//

#import "BTNestedSectionLayout.h"
#import "BTNestedSectionLayoutObject.h"

const NSInteger BTLayoutHierarchyDefault = 0;

@implementation BTNestedSectionLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGFloat contentOffsetY = self.collectionView.contentOffset.y;
    rect.origin.y = 0;
    rect.size.height = contentOffsetY + CGRectGetHeight(self.collectionView.bounds);
    NSArray *origionLayoutAttributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *sections = @[].mutableCopy;
    __block BTNestedSectionLayoutObject *section;
    [origionLayoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *itemAttribute, NSUInteger idx, BOOL *stop) {
        if (itemAttribute.representedElementKind == UICollectionElementKindSectionHeader) {
            NSInteger sectionHierarchy = [self sectionHeaderHierarchy:itemAttribute.indexPath.section];
            [itemAttribute setHierarchy:sectionHierarchy];
            itemAttribute.zIndex = 1024 - itemAttribute.hierarchy;
            if (sectionHierarchy == BTLayoutHierarchyDefault) {
                BTNestedSectionLayoutObject *nextSection = [BTNestedSectionLayoutObject new];
                if (section) {
                    section.nextSameLevelSection = nextSection;
                }
                section = nextSection;
                [sections addObject:section];
            }
            [section addSubSectionLayoutAttributes:itemAttribute];
        }
    }];
    
    [sections enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        *stop = [obj arrangeLayoutAttributes:self.collectionView];
    }];
    
    return origionLayoutAttributes;
}

#pragma mark - Protocol

- (NSInteger)sectionHeaderHierarchy:(NSUInteger)section
{
    id delegateObject = self.collectionView.delegate;
    if ([delegateObject respondsToSelector:@selector(sectionHeaderHierarchy:)]) {
        return [delegateObject sectionHeaderHierarchy:section];
    }
    return BTLayoutHierarchyDefault;
}

@end
