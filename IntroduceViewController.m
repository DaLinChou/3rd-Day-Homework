//
//  IntroduceViewController.m
//  0709_UI_BaseViewController
//
//  Created by rimi on 15/7/9.
//  Copyright (c) 2015年 周林. All rights reserved.
//

#import "IntroduceViewController.h"

static NSString * const context = @"他是一个美国式的英雄，几经起伏，但依然屹立不倒，就像海明威在《老人与海》中说到的，一个人可以被毁灭，但不能被打倒。他创造了“苹果”，掀起了个人电脑的风潮，改变了一个时代，但却在最顶峰的时候被封杀，从高楼落到谷底，但是12年后，他又卷土重来，重新开始第二个“斯蒂夫·乔布斯”时代。";

@interface IntroduceViewController ()

- (void) initializeUserInterface;
- (CGSize)sizeWithContext:(NSString *)context constainWitdth:(CGFloat)constainWith font:(UIFont *)font;
@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeUserInterface];
}

#pragma mark - 初始化界面
- (void)initializeUserInterface {

#pragma mark Button
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.bounds = CGRectMake(0, 0, 50, 30);
    backButton.center = CGPointMake(60, 60);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTintColor:[UIColor blackColor]];
    [backButton addTarget:self action:@selector(respondsToButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
#pragma mark Lable
    /* 人物简介Lable */
    UILabel * titleLable = [[UILabel alloc] init];
    titleLable.bounds = CGRectMake(0, 0, 100, 50);
    titleLable.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(backButton.frame));
    titleLable.text = @"人物简介";
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:titleLable];
    
    /* 乔布斯头像图片 */
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    // 设置图片
    imageView.image = [UIImage imageNamed:@"introduce"];
    // 设置圆角
    imageView.layer.cornerRadius = 75;
    // 超出视图部分不显示
    imageView.clipsToBounds = YES;
    
    /* 姓名Lable */
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), 10, CGRectGetMaxX(self.view.bounds) - CGRectGetMaxX(imageView.frame), CGRectGetMaxY(imageView.frame) /2)];
    nameLable.text = @"史蒂夫·乔布斯";
    nameLable.textAlignment = NSTextAlignmentCenter;
    nameLable.font = [UIFont boldSystemFontOfSize:20];
    
    /* 享年Lable */
    UILabel * yearLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), CGRectGetMaxY(nameLable.frame) - 10, CGRectGetMaxX(self.view.bounds) - CGRectGetMaxX(imageView.frame), CGRectGetMaxY(imageView.frame) /2)];
    yearLable.text = @"1955-2011";
    yearLable.textAlignment = NSTextAlignmentCenter;
    yearLable.font = [UIFont boldSystemFontOfSize:20];
    
    /* 简介Lable */
    UIFont * font = [UIFont systemFontOfSize:20];
    CGSize size = [self sizeWithContext:context constainWitdth:375 font:font];
    UILabel * contexLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), size.width, size.height)];
    contexLable.text = context;
    contexLable.numberOfLines = 0;
    
    /* 外围Lable */
    UILabel * content = [[UILabel alloc] init];
    content.bounds = CGRectMake(0, 0, CGRectGetMaxX(self.view.bounds) - 4, CGRectGetMidY(self.view.bounds));
    content.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) - 50);
    // 设置Lable圆角
    content.layer.cornerRadius = 10;
    // 设置边框宽度
    [content.layer setBorderWidth:0.5];
    // 设置边框颜色
    [content.layer setBorderColor:[UIColor blackColor].CGColor];
    // Lable添加子控件
    [content addSubview:imageView];
    [content addSubview:nameLable];
    [content addSubview:yearLable];
    [content addSubview:contexLable];
    [self.view addSubview:content];
    
    /* 夜间模式Lable */
    UILabel * nightLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(content.frame), CGRectGetMaxY(content.frame) + 20, 100, 20)];
    nightLable.text = @"夜间模式";
    nightLable.textAlignment = NSTextAlignmentCenter;
    nightLable.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:nightLable];
    
#pragma mark Switch
    /* 夜间模式开关 */
    UISwitch * switchControl = [[UISwitch alloc]init];
    switchControl.bounds = CGRectMake(0, 0, 40, 50);
    switchControl.center = CGPointMake(CGRectGetMaxX(nightLable.frame) + 10, CGRectGetMaxY(nightLable.frame));
    switchControl.thumbTintColor = [UIColor purpleColor];
    switchControl.tintColor = [UIColor blackColor];
    [switchControl addTarget:self action:@selector(respondsToControl:) forControlEvents:UIControlEventValueChanged];
    switchControl.on = NO;
    [self.view addSubview:switchControl];
    
}

#pragma mark - responds event
- (void) respondsToButton : (UIButton *) sender {
    /* 点击返回按钮事件 */
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) respondsToControl : (UIControl *) sender {
    
    /* 点击夜间模式事件 */
    if ([sender isKindOfClass:[UISwitch  class]]) {
        UISwitch * switchControl = (UISwitch *)sender;
        self.view.backgroundColor = switchControl.isOn ? [UIColor darkGrayColor] : [UIColor whiteColor];
    }
}

#pragma mark - private methods
- (CGSize)sizeWithContext:(NSString *)context constainWitdth:(CGFloat)constainWith font:(UIFont *)font {
    CGSize size = CGSizeZero;
    // 计算大小
    CGRect rect =  [context boundingRectWithSize:CGSizeMake(constainWith, 1000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    
    size = rect.size;
    return size;
}

@end
