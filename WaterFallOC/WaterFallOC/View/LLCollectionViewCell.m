//
//  LLCollectionViewCell.m
//  WaterFallOC
//
//  Created by 罗李 on 16/12/30.
//  Copyright © 2016年 罗李. All rights reserved.
//

#import "LLCollectionViewCell.h"


@interface LLCollectionViewCell ()
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIImageView *cellImageView;
@end
@implementation LLCollectionViewCell
- (UIImageView *)cellImageView
{
    if (!_cellImageView) {
        _cellImageView = [UIImageView new];
        [self.contentView addSubview:_cellImageView];
    }
    return _cellImageView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)setCellDataSource:(LLClothModel *)cellDataSource {
    _cellDataSource  = cellDataSource;
    self.cellImageView.image = [UIImage imageNamed:cellDataSource.icon];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _cellImageView.frame = self.contentView.bounds;
    
}
@end
