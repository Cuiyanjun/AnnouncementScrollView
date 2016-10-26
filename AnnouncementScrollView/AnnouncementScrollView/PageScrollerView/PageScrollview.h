//
//  PageScrollview.h
//  PageSourceView
//
//  Created by sunhaichen on 2016/10/24.
//  Copyright © 2016年 sunhaichen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PageScrollDelegate <NSObject>
- (void)pushName:(NSString *)str;

@end

@interface PageScrollview : UIView<UIScrollViewDelegate,UIGestureRecognizerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, weak) NSTimer *timerNotice;
@property (nonatomic, strong) NSString *iconName;//图片名称
@property (nonatomic, strong) UIScrollView *scrollViewNotice;//广告滚动视图
@property (nonatomic, strong) NSMutableArray *noticeArray;//广告内容数组
@property (nonatomic, assign) NSInteger timerShows;//广告内容滚动间隔时间
@property (nonatomic, assign) NSInteger touchShow;//记录点击计数
@property (nonatomic, weak) id<PageScrollDelegate> delegate;
-(id)initWithFrame:(CGRect)frame;
@end

