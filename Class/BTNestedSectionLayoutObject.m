//
//  BTNestedSectionLayoutObject.m
//  Demo
//
//  Created by Tongtong Xu on 15/6/29.
//  Copyright (c) 2015年 Luxi Innovation Co. Ltd. All rights reserved.
//

#import "BTNestedSectionLayoutObject.h"
#import "BTNestedSectionLayout.h"

@implementation BTNestedSectionLayoutObject

#pragma mark - init index

- (void)addSubSectionLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    if (layoutAttributes.hierarchy == BTLayoutHierarchyDefault) {
        self.layoutAttributes = layoutAttributes;
    }else{
        if (self.layoutAttributes.hierarchy == layoutAttributes.hierarchy - 1) {
            [self addSubSectionLayoutAttributesDirect:layoutAttributes];
        }else{
            NSString *errorMesasge = [NSString stringWithFormat:@"section等于%@的HeaderView的Level不能小于%@",@(layoutAttributes.indexPath.section),@(self.layoutAttributes.hierarchy + 1)];
            NSAssert([self.subSections lastObject], errorMesasge);
            [[self.subSections lastObject] addSubSectionLayoutAttributes:layoutAttributes];
        }
    }
}

- (void)addSubSectionLayoutAttributesDirect:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    BTNestedSectionLayoutObject *object = [BTNestedSectionLayoutObject new];
    object.layoutAttributes = layoutAttributes;
    object.superSection = self;
    [self addSubSection:object];
}

- (void)addSubSection:(BTNestedSectionLayoutObject *)section
{
    NSMutableArray *mulA = _subSections ? _subSections.mutableCopy : @[].mutableCopy;
    BTNestedSectionLayoutObject *previousSection = [mulA lastObject];
    previousSection.nextSameLevelSection = section;
    [mulA addObject:section];
    _subSections = mulA.copy;
}

#pragma mark - reset layout

- (BOOL)arrangeLayoutAttributes:(UICollectionView *)collectionView
{
    BOOL hasConfirmedTopSection = NO;
    
    if ([self isTopSection:collectionView]) {
        
        [self arrangeSelfWhenIsTop:collectionView];
        
        [self.subSections enumerateObjectsWithOptions:NSEnumerationReverse
                                           usingBlock:^(BTNestedSectionLayoutObject *obj, NSUInteger idx, BOOL *stop) {
                                               *stop = [obj arrangeLayoutAttributes:collectionView];
                                           }];
        
        hasConfirmedTopSection = YES;
    }
    
    return hasConfirmedTopSection;
}

- (void)arrangeSelfWhenIsTop:(UICollectionView *)collectionView
{
    self.layoutAttributes.y = self.hierarchyMinY + collectionView.contentOffset.y;
    if (self.nextSameLevelSection) {
        self.layoutAttributes.y = MIN(self.layoutAttributes.y, self.nextSameLevelSection.layoutAttributes.y - self.layoutAttributes.height);
    }else{
        self.layoutAttributes.y = MIN(self.layoutAttributes.y, [self hierarchyMaxY:collectionView] + collectionView.contentOffset.y);
    }
}

#pragma mark - helper

- (CGFloat)hierarchyMinY
{
    CGFloat origionY = 0;
    BTNestedSectionLayoutObject *obj = self.superSection;
    while (obj) {
        origionY += obj.layoutAttributes.height;
        obj = obj.superSection;
    }
    return origionY;
}

- (CGFloat)hierarchyMaxY:(UICollectionView *)collectionView
{
    CGFloat maxY = CGRectGetHeight(collectionView.bounds);
    BTNestedSectionLayoutObject *obj = self.nextSection;
    return obj ? obj.layoutAttributes.y - collectionView.contentOffset.y - self.layoutAttributes.height : maxY - self.layoutAttributes.height;
}

- (BTNestedSectionLayoutObject *)nextSection
{
    BTNestedSectionLayoutObject *nextSection;
    nextSection = self.nextSameLevelSection;
    if (!nextSection){
        BTNestedSectionLayoutObject *obj = self.superSection;
        while (obj) {
            nextSection = obj.nextSameLevelSection;
            obj = nextSection ? nil : obj.superSection;
        }
    }
    return nextSection;
}

- (BOOL)isTopSection:(UICollectionView *)collectionView
{
    if (self.layoutAttributes.y > (self.hierarchyMinY + collectionView.contentOffset.y)) {
        return NO;
    }
    if (self.nextSameLevelSection) {
        return ![self.nextSameLevelSection isTopSection:collectionView];
    }
    return YES;
}

#pragma mark - debug

- (NSString *)description
{
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"-%@",@(self.layoutAttributes.hierarchy)];
    for (UICollectionViewLayoutAttributes *layout in self.subSections) {
        [string appendString:layout.description];
    }
    return string;
}

@end
