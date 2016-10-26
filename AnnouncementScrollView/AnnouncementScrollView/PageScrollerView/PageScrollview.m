//
//  PageScrollview.m
//  PageSourceView
//
//  Created by sunhaichen on 2016/10/24.
//  Copyright © 2016年 sunhaichen. All rights reserved.
//
#define HEIGHT_CONTROLLER_DEFAULT   ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?[[UIScreen mainScreen] bounds].size.height+20:[[UIScreen mainScreen] bounds].size.height)
#define WIDTH_CONTROLLER_DEFAULT   [[UIScreen mainScreen] bounds].size.width
#import "PageScrollview.h"
#import "UIColor+AddColor.h"

@implementation PageScrollview
{
    CGFloat noticeHeight;
    NSInteger everyNum;
    NSInteger secondsNum;
}
- (NSMutableArray *)noticeArray
{
    if (!_noticeArray) {
        _noticeArray = [NSMutableArray array];
    }
    return _noticeArray;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)createUI
{
    //公告图标位置
    noticeHeight = self.frame.size.height/2;
    //公告图标
    UIImageView *imageNotice = [[UIImageView alloc] initWithFrame:CGRectMake(9, noticeHeight/2, noticeHeight, noticeHeight)];
    imageNotice.backgroundColor = [UIColor whiteColor];
    imageNotice.image = [UIImage imageNamed:self.iconName];
    [self addSubview:imageNotice];
    //公告view分界线 UP
    UIView *viewLineNotice = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    viewLineNotice.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:viewLineNotice];
    //公告view分界线 DONW
    UIView *viewLineNotice1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 1)];
    viewLineNotice1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:viewLineNotice1];
    [self noticeContentShow];
}
//首页公告视图
- (void)noticeContentShow
{
    self.scrollViewNotice = [[UIScrollView alloc] initWithFrame:CGRectMake(9+noticeHeight+5, 0, self.frame.size.width-9-noticeHeight-5, self.frame.size.height)];
    self.scrollViewNotice.backgroundColor = [UIColor clearColor];
    self.scrollViewNotice.contentOffset = CGPointMake(1, self.frame.size.height);
    self.scrollViewNotice.contentSize = CGSizeMake(self.frame.size.width-9-noticeHeight-5, self.frame.size.height * (self.noticeArray.count + 1));
    self.scrollViewNotice.delegate = self;
    self.scrollViewNotice.scrollEnabled = NO;
    self.scrollViewNotice.userInteractionEnabled = YES;//禁止滑动
    [self addSubview:self.scrollViewNotice];
    for (int i = 1; i <= self.noticeArray.count; i++) {
//        UILabel *labelNotice = [CreatView creatWithLabelFrame:CGRectMake(0, self.frame.size.height * i, _scrollViewNotice.frame.size.width, self.frame.size.height) backgroundColor:[UIColor clearColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:[self.noticeArray objectAtIndex:i - 1]];
        UILabel *labelNotice = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height * i, _scrollViewNotice.frame.size.width, self.frame.size.height)];
        labelNotice.backgroundColor = [UIColor clearColor];
        labelNotice.textColor = [UIColor findZiTiColor];
        labelNotice.textAlignment = NSTextAlignmentLeft;
        labelNotice.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        labelNotice.text = [self.noticeArray objectAtIndex:i-1];
        [_scrollViewNotice addSubview:labelNotice];
        labelNotice.userInteractionEnabled = YES;
        labelNotice.exclusiveTouch = YES;
        labelNotice.tag = i;
        UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapActions)];
        gensture.delegate = self;
        [labelNotice addGestureRecognizer:gensture];
        everyNum = self.noticeArray.count + 1;
        secondsNum = self.noticeArray.count;
    }
}
- (void)scrollViewTapActions
{
    NSInteger tager;
    if (self.noticeArray.count == 1) {
        self.touchShow = 1;
    }else if (self.noticeArray.count == 0)
    {
        self.touchShow = 0;
    }
    tager = self.noticeArray.count - self.touchShow;
    if ([_delegate respondsToSelector:@selector(pushName:)]) {
        [_delegate pushName:[self.noticeArray objectAtIndex:tager]];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView == _scrollViewNotice) {
            if (_scrollViewNotice.contentOffset.y >= self.noticeArray.count * self.frame.size.height + self.frame.size.height) {
                
                [_scrollViewNotice setContentOffset:CGPointMake(0, self.frame.size.height) animated:NO];
                secondsNum = self.noticeArray.count-1;
            }
    }
}

- (void)timerFireMethod:(NSTimer *)theTimer
{
    [_scrollViewNotice setContentOffset:CGPointMake(0, self.frame.size.height * (everyNum - secondsNum)) animated:YES];
//    NSLog(@"%ld",secondsNum);
    if (secondsNum == 0) {
        self.touchShow = self.noticeArray.count;
    }else
    {
        self.touchShow = secondsNum;
    }
    secondsNum--;
}

- (void)drawRect:(CGRect)rect
{
    self.timerNotice = [NSTimer scheduledTimerWithTimeInterval:self.timerShows target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    if (self.noticeArray.count == 0 || self.noticeArray.count == 1 || self.noticeArray == nil) {
        [self.timerNotice setFireDate:[NSDate distantFuture]];
    }else
    {
        [self.timerNotice setFireDate:[NSDate distantPast]];
    }
    [self createUI];
}

@end
