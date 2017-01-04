//
//  ViewController.m
//  WaterFallOC
//
//  Created by 罗李 on 16/12/29.
//  Copyright © 2016年 罗李. All rights reserved.
//

#import "ViewController.h"
#import "LLClothModel.h"
#import "LLCollectionViewCell.h"
#import "LLFlowLayout.h"
static NSString *cellIdentifier = @"key";
static NSString *footerIdentifier = @"footer";
static NSString *headerIdentifier = @"header";
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *fallCollectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIActivityIndicatorView *refresh;

@property (nonatomic, strong) UILabel *prompt;
@end

@implementation ViewController

- (UIActivityIndicatorView *)refresh
{
    if (!_refresh) {
        _refresh = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        CGFloat w = 44;
        CGFloat h = 44;
        CGFloat x = ([UIScreen mainScreen].bounds.size.width - w) / 2;
        CGFloat y = 3;
        _refresh.frame = CGRectMake(x, y, w, h);
        _refresh.color = [UIColor redColor];
        _refresh.hidden = YES;
    }
    return _refresh;
}
- (UILabel *)prompt
{
    if (!_prompt) {
        _prompt = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.refresh.frame), 3, 100, 44)];
        _prompt.text = @"正在刷新...";
        _prompt.font = [UIFont systemFontOfSize:20];
        _prompt.hidden = YES;
    }
    return _prompt;
}
#pragma mark- collectionView
- (UICollectionView *)fallCollectionView
{
    if (!_fallCollectionView) {
//        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
//        flowLayout.itemSize = CGSizeMake(117, 161);
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        flowLayout.minimumLineSpacing = 5;
//        flowLayout.minimumInteritemSpacing = 5;
        LLFlowLayout *flowLayout = [LLFlowLayout new];
        flowLayout.colNum = 3;
        flowLayout.margin = 5;
    
        flowLayout.clothInfo = self.dataSource;
        CGRect frame = self.view.bounds;
        _fallCollectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
        
    }
    return _fallCollectionView;
}

#pragma mark - 数据源
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObjectsFromArray:[LLClothModel arrayModelWithPListName:@"1.plist"]];
    }
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self sutupCollectionView];
    
}

#pragma mark - 加载更过数据
- (void)reloadMoreData
{
    NSString *plistName = [NSString stringWithFormat:@"%d.plist",arc4random_uniform(3) +1];
    
    [self.dataSource addObjectsFromArray:[LLClothModel arrayModelWithPListName:plistName]];
    
}
- (void)sutupCollectionView
{

    self.fallCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.fallCollectionView];
    self.fallCollectionView.delegate = self;
    self.fallCollectionView.dataSource = self;
    
    [self.fallCollectionView registerClass:[LLCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    //  注册底部刷新视图
    [self.fallCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LLClothModel *model = self.dataSource[indexPath.item];

    LLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.cellDataSource = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == self.dataSource.count - 1) {
        self.refresh.hidden = NO;
        self.prompt.hidden = NO;
        [self.refresh startAnimating];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //  记载更过
            [self reloadMoreData];
            
            [self.fallCollectionView reloadData];
        });
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 50);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerIdentifier forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor whiteColor];
        
        [footerView addSubview:self.refresh];
        [footerView  addSubview:self.prompt];
        return footerView;
    }
    
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
