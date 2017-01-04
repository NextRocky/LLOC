//
//  LLCollectionViewCell.h
//  WaterFallOC
//
//  Created by 罗李 on 16/12/30.
//  Copyright © 2016年 罗李. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLClothModel.h"
@interface LLCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) LLClothModel *cellDataSource;
@end
