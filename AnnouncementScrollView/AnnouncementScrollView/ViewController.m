//
//  ViewController.m
//  AnnouncementScrollView
//
//  Created by gcct on 2016/10/25.
//  Copyright © 2016年 sunhaichen. All rights reserved.
//

#import "ViewController.h"
#import "PageScrollview.h"
@interface ViewController ()<PageScrollDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array1 = @[@"1",@"2",@"3"];
    PageScrollview * viewS = [[PageScrollview alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
    viewS.timerShows = 3;//公告轮转时间
    viewS.noticeArray = [NSMutableArray arrayWithArray:array1];//公告数据数组
    viewS.iconName = @"公告";//公告图片名称
    viewS.delegate = self;
    [self.view addSubview:viewS];
    
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma make -- pageScrollerDelegate
- (void)pushName:(NSString *)str
{
    NSLog(@"%@",str);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
