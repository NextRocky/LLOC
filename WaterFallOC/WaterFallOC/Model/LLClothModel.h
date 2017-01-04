//
//  LLClothModel.h
//  WaterFallOC
//
//  Created by 罗李 on 16/12/30.
//  Copyright © 2016年 罗李. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLClothModel : NSObject
// 图片
@property (nonatomic, copy) NSString *icon;
// 价格
@property (nonatomic, copy) NSString *price;
// 高度
@property (nonatomic, assign) NSInteger height;
// 宽度
@property (nonatomic, assign) NSInteger width;

+ (instancetype)loadWithDic:(NSDictionary *)dic;

+ (NSArray *)arrayModelWithPListName:(NSString *)plistName;
@end
