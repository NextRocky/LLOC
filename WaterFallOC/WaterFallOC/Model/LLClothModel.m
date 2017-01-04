//
//  LLClothModel.m
//  WaterFallOC
//
//  Created by 罗李 on 16/12/30.
//  Copyright © 2016年 罗李. All rights reserved.
//

#import "LLClothModel.h"

@implementation LLClothModel
+ (instancetype)loadWithDic:(NSDictionary *)dic {
    LLClothModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

+ (NSArray *)arrayModelWithPListName:(NSString *)plistName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:arr.count];
    
    [arr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LLClothModel *model = [self loadWithDic:obj];
        
        [muArr addObject:model];
    }];
    
    return muArr.copy;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%ld,%ld",self.icon,self.price,self.height,self.width];
}

@end
