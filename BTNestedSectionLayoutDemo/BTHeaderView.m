//
//  BTHeaderView.m
//  BTNestedSectionLayoutDemo
//
//  Created by Tongtong Xu on 15/9/17.
//  Copyright (c) 2015年 Luxi Innovation Co. Ltd. All rights reserved.
//

#import "BTHeaderView.h"

@implementation BTHeaderView

- (void)setHierarchy:(NSInteger)hierarchy
{
    _hierarchy = hierarchy;
    [self configColorView];
}

- (void)setSection:(NSInteger)section
{
    _section = section;
    _sectionLabel.text = [NSString stringWithFormat:@"section: %@",@(section)];
}

- (void)configColorView
{
    _colorView.backgroundColor = [[UIColor colorWithRed:74 / 255.0 green:184 / 255.0 blue:204 / 255.0 alpha:1.0] colorWithAlphaComponent:1 - (_hierarchy - BTLayoutHierarchyDefault) * 0.1];
    _colorViewLeadingConstraint.constant = (_hierarchy - BTLayoutHierarchyDefault) * 20;
}

@end
