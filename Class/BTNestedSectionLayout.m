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
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"self.representedElementKind == %@", UICollectionElementKindSectionHeader];
    
    
    
    
    NSArray *headerArray = [origionLayoutAttributes filteredArrayUsingPredicate:resultPredicate];
    
    NSMutableArray *sections = @[].mutableCopy;
    __block BTNestedSectionLayoutObject *section;
    [headerArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *itemAttribute, NSUInteger idx, BOOL * _Nonnull stop) {
        itemAttribute.zIndex = 1024 - itemAttribute.hierarchy;
        if (itemAttribute.hierarchy == BTLayoutHierarchyDefault) {
            BTNestedSectionLayoutObject *nextSection = [BTNestedSectionLayoutObject new];
            if (section) {
                section.nextSameLevelSection = nextSection;
            }
            section = nextSection;
            [sections addObject:section];
        }
        [section addSubSectionLayoutAttributes:itemAttribute];
    }];
    
    [sections enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        *stop = [obj arrangeLayoutAttributes:self.collectionView];
    }];
    
    return origionLayoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *obj = [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
    [obj setHierarchy:[self sectionHeaderHierarchy:indexPath.section]];
    obj.zIndex = 1024 - obj.hierarchy;
    return obj;
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
