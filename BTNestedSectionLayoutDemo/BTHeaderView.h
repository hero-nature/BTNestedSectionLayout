//
//  BTHeaderView.h
//  BTNestedSectionLayoutDemo
//
//  Created by Tongtong Xu on 15/9/17.
//  Copyright (c) 2015年 Luxi Innovation Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTNestedSectionLayout.h"

@interface BTHeaderView : UICollectionReusableView
@property (nonatomic) NSInteger hierarchy;
@property (nonatomic) NSInteger section;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorViewLeadingConstraint;
@end
