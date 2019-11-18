//
//  ViewController.m
//  LevelTableView
//
//  Created by 张奥 on 2019/11/18.
//  Copyright © 2019 张奥. All rights reserved.
//

#import "ViewController.h"
#import "HeadView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,HeadViewDelegate>
@property (nonatomic,copy) NSArray *titles;
@property (nonatomic,copy) NSArray *contants;
@property (nonatomic,strong) NSMutableArray *dataSuroces;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableDictionary *extendDic;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSuroces = [NSMutableArray arrayWithObjects:@[],@[],@[],@[], nil];
    self.extendDic = [NSMutableDictionary dictionary];
    self.titles = @[@"水果",@"好友",@"学科"];
    self.contants = @[@[@"西瓜",@"南瓜",@"西红柿"],@[@"嘻嘻",@"哈哈",@"呵呵",@"哒哒"],@[@"数学",@"语文",@"外语",@"政治",@"历史"]];
    for (int i=0; i<self.titles.count; i++) {
        NSDictionary *dic = @{@(i):@NO};
        [self.extendDic setValuesForKeysWithDictionary:dic];
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    tableView.separatorColor = [UIColor grayColor];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [tableView registerClass:[HeadView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([HeadView class])];
    [self.view addSubview:tableView];
    
    tableView.tableFooterView = [UIView new];
}

# pragma mark -- UITabelViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSuroces[section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *text = self.dataSuroces[indexPath.section][indexPath.row];
    cell.textLabel.text = text;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了indexRow====%ld",indexPath.row);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([HeadView class])];
    headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    headView.tag = section;
    headView.delegate = self;
    [headView.titleButton setTitle:self.titles[section] forState:UIControlStateNormal];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(void)selectTag:(NSInteger)tag{
    BOOL isExtend = [self.extendDic[@(tag)] boolValue];
    isExtend = !isExtend;
    if (isExtend) {
        [self.dataSuroces replaceObjectAtIndex:tag withObject:self.contants[tag]];
        NSMutableArray *mut = [NSMutableArray array];
        for (int i = 0; i<[self.contants[tag] count]; i++) {
            [mut addObject:[NSIndexPath indexPathForRow:i inSection:tag]];
        }
        //想表格里面插入cell
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:mut withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
        //刷新指定的cellindex(刷新之前必须要添加cell,否则会奔溃)
        [self.tableView reloadRowsAtIndexPaths:mut withRowAnimation:UITableViewRowAnimationNone];
    }else{
        [self.dataSuroces replaceObjectAtIndex:tag withObject:@[]];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:tag] withRowAnimation:UITableViewRowAnimationNone];
    }
    [self.extendDic setObject:@(isExtend) forKey:@(tag)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
