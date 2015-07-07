//
//  ViewController.m
//  下拉放大效果演习
//
//  Created by  yunjinghui on 15/7/3.
//  Copyright (c) 2015年 rayootech. All rights reserved.
//


#define NavigationBarHight 64.f
#define ImageHight 200.f

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation ViewController {
    UIImageView *_zoomImageView;  // 变化的图片做底层
    
    UIImageView *_circleView;     // 类似头像的UIImageView
    UILabel     *_textLabel;      // 类似昵称UILabel
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTableView.contentInset = UIEdgeInsetsMake(ImageHight, 0, 0, 0);
    
    [self.view addSubview:self.myTableView];
    
    _zoomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    _zoomImageView.frame = CGRectMake(0, -ImageHight, self.view.frame.size.width, ImageHight);
    
    _zoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.myTableView addSubview:_zoomImageView];
    
}




#pragma mark - UITableViewData
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y + NavigationBarHight;
    
    if (y < -ImageHight) {
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _zoomImageView.frame = frame;
    }
}

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _myTableView.backgroundColor = [UIColor redColor];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        
//        _myTableView.tableFooterView = [UIView new];
    }
    return _myTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
