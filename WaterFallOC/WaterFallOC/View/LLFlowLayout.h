//
//  LLFlowLayout.h
//  WaterFallOC
//
//  Created by 罗李 on 17/1/3.
//  Copyright © 2017年 罗李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) CGFloat margin;
//  列数
@property (nonatomic, assign) NSInteger colNum;
//  将数据给瀑布流对象
@property (nonatomic, strong) NSArray *clothInfo;
@end
