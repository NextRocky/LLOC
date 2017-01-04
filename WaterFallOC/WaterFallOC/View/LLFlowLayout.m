//
//  LLFlowLayout.m
//  WaterFallOC
//
//  Created by 罗李 on 17/1/3.
//  Copyright © 2017年 罗李. All rights reserved.
//

#import "LLFlowLayout.h"
#import "LLClothModel.h"
@interface LLFlowLayout ()
@property (nonatomic, strong) NSArray *layoutAttribute;

@property (nonatomic, strong) NSMutableArray *lastRowY;

@end
@implementation LLFlowLayout

- (NSMutableArray *)lastRowY
{
    if (!_lastRowY) {
        _lastRowY = [NSMutableArray array];
        for (NSInteger i = 0; i < self.colNum; i++) {
            [_lastRowY addObject:@(self.margin)];
        }
        
    }
    return _lastRowY;
}

#pragma mark - 计算布局属性
- (void)prepareLayout
{
    [super prepareLayout];
    //  需要显示的宽度
    CGFloat clothW = ([UIScreen mainScreen].bounds.size.width - self.margin * (self.colNum + 1)) / self.colNum;

    //  创建可变数组
    NSMutableArray *muArr = [NSMutableArray array];
    
    //  清空上一行
    self.lastRowY = nil;
    
    //  循环创建布局属性对象
    for (NSInteger i = 0; i < self.clothInfo.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        UICollectionViewLayoutAttributes *flowLayoutAttrib = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath ];
        
        LLClothModel *model = self.clothInfo[i];

        //  计算行号
        NSInteger numCol = i % self.colNum;
        
        //  计算高度
        CGFloat clothH = model.height * clothW/ model.width;

        //  x
        CGFloat clothX = self.margin + (clothW + self.margin) * numCol;
        //  获取保存在lastY 中的数值
        CGFloat lastY = [self.lastRowY[ numCol] floatValue];
        //  Y
        CGFloat clothY = lastY;
        // 然后将数据放入数组中
        self.lastRowY[numCol] = @(self.margin + lastY + clothH);
        
        flowLayoutAttrib.frame = CGRectMake(clothX, clothY, clothW, clothH);
        
        [muArr addObject:flowLayoutAttrib];
        
    }
    CGFloat maxY = 0;
    for (NSInteger i = 0; i < self.colNum; i++) {
        CGFloat current = [self.lastRowY[i] floatValue];
        if (current > maxY) {
            maxY = current;
        }
    }
    //   底部视图
    CGFloat footerW = [UIScreen mainScreen].bounds.size.width;
    CGFloat footerH = 50;
    CGFloat footerX = 0;
    CGFloat footerY = maxY;
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:0 length:0];
    UICollectionViewLayoutAttributes *footerAttrib = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:indexPath];
    
    footerAttrib.frame = CGRectMake(footerX, footerY, footerW, footerH);
    
    [muArr addObject:footerAttrib];
    
    self.layoutAttribute = muArr.copy;
}

- (CGSize)collectionViewContentSize
{
    UICollectionViewLayoutAttributes *lastAttrib = self.layoutAttribute.lastObject;
    CGSize contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(lastAttrib.frame));
    return contentSize;
}
// 返回 布局对象数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.layoutAttribute;
}

@end
