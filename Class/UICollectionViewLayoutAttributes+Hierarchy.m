//
//  UICollectionViewLayoutAttributes+Hierarchy.m
//  Demo
//
//  Created by Tongtong Xu on 15/6/29.
//  Copyright (c) 2015年 Luxi Innovation Co. Ltd. All rights reserved.
//

#import "UICollectionViewLayoutAttributes+Hierarchy.h"
#import <objc/runtime.h>

static char BTLayoutHierarchy;

@implementation UICollectionViewLayoutAttributes (Hierarchy)

- (void)setHierarchy:(NSInteger)hierarchy
{
    objc_setAssociatedObject(self, &BTLayoutHierarchy, @(hierarchy), OBJC_ASSOCIATION_RETAIN);
}

- (NSInteger)hierarchy
{
    return [objc_getAssociatedObject(self, &BTLayoutHierarchy) integerValue];
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

- (CGFloat)y
{
    return CGRectGetMinY(self.frame);
}

- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

@end
