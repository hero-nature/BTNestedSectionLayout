//
//  UICollectionViewLayoutAttributes+Hierarchy.h
//  Demo
//
//  Created by Tongtong Xu on 15/6/29.
//  Copyright (c) 2015年 Luxi Innovation Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewLayoutAttributes (Hierarchy)

@property (nonatomic) NSInteger hierarchy;

@property (nonatomic, readonly) CGFloat height;
@property (nonatomic, readonly) CGFloat y;

- (void)setY:(CGFloat)y;

@end
