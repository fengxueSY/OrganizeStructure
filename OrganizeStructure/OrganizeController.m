//
//  OrganizeController.m
//  OrganizeStructure
//
//  Created by 666gps on 2017/5/3.
//  Copyright © 2017年 666gps. All rights reserved.
//

#import "OrganizeController.h"

#define WindowWidth [UIScreen mainScreen].bounds.size.width
#define WindowHeight [UIScreen mainScreen].bounds.size.height

@interface OrganizeController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray * array;
    NSUserDefaults * userDefaults;
}
@property (nonatomic,strong) UIScrollView * titleScrollView;
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation OrganizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    userDefaults = [NSUserDefaults standardUserDefaults];
    array = [[NSMutableArray alloc]init];
    if (self.parmStr == nil) {
        self.parmStr = @"首页";
    }
    NSArray * arr = [userDefaults objectForKey:@"organizeStructureTitleArray"];
    if (arr == nil || arr.count <= 0) {
        [array addObject:self.parmStr];
    }else{
        array = [[NSMutableArray alloc]initWithArray:arr];
        [array addObject:self.parmStr];
    }
    NSArray * arra = [[NSArray alloc]initWithArray:array];
    [userDefaults setObject:arra forKey:@"organizeStructureTitleArray"];
    [userDefaults synchronize];
    [self addLabelForScrollView];
}
-(void)addLabelForScrollView{
    for (int i = 0; i < array.count; i++) {
        UILabel * label = [[UILabel alloc]init];
        label.tag = 18000 + i;
        label.font = [UIFont systemFontOfSize:14];
        if (i == 0) {
            label.frame = CGRectMake(0, 10, [self stringWidth:array[i]], 30);
        }else{
            UILabel * label0 = (UILabel *)[self.view viewWithTag:18000 + (i - 1)];
            float Y = CGRectGetMaxX(label0.frame);
            label.frame = CGRectMake(Y + 8, 10, [self stringWidth:array[i]], 30);
        }
        label.text = array[i];
        if (CGRectGetMaxX(label.frame) > WindowWidth) {
            self.titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(label.frame), 50);
        }
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelAction:)];
        [label addGestureRecognizer:tap];
        [self.titleScrollView addSubview:label];
    }
    [self.tableView reloadData];
}
-(void)labelAction:(UITapGestureRecognizer *)sender{
    NSInteger a = sender.view.tag - 18000;
    NSMutableArray * array0 = [[NSMutableArray alloc]init];
    for (int i  = 0; i <= a; i++) {
        [array0 addObject:array[i]];
    }
    NSArray * arr0 = [[NSArray alloc]initWithArray:array0];
    [userDefaults setObject:arr0 forKey:@"organizeStructureTitleArray"];
    [userDefaults synchronize];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:a] animated:YES];
}
#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"ID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个",indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrganizeController * organize = [[OrganizeController alloc]init];
    organize.parmStr = [NSString stringWithFormat:@"第%ld个",indexPath.row];
    [self.navigationController pushViewController:organize animated:YES];
}
#pragma mark - 懒加载
-(UIScrollView *)titleScrollView{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, 50)];
        _titleScrollView.backgroundColor = [UIColor whiteColor];
        _titleScrollView.delegate = self;
        _titleScrollView.contentSize = CGSizeMake(WindowWidth, 50);
        [self.view addSubview:_titleScrollView];
    }
    return _titleScrollView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleScrollView.frame), WindowWidth, WindowHeight - CGRectGetMaxY(self.titleScrollView.frame))];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(CGFloat)stringWidth:(NSString *)str{
    float width = 0.0;
    width = [str boundingRectWithSize:CGSizeMake(10000, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width;
    return width;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
