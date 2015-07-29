//
//  UIWindow+XHNewFeature.m
//  0324-XH彩票
//
//  Created by mac on 15-3-28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "UIWindow+XHNewFeature.h"
#import "XHFeatureViewController.h"
#import "XHTabBarViewController.h"

@implementation UIWindow (XHNewFeature)
-(void)jumpRootViewContrller{
    //从UIApplication中获取当前主窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //从plist文件中获取，当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    //获取本地保存的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *saveVersion = [defaults valueForKey:@"saveVersion"];
#warning 是否跳过新特性
    //判断两个版本是否一致
    if (([currentVersion compare:saveVersion] == NSOrderedAscending)) {
        //注册点击事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpRvc) name:@"jumpRootViewContrller" object:nil];
        //显示新特新
        XHFeatureViewController *featureVc = [[XHFeatureViewController alloc]init];
        //更新版本号
        [defaults setValue:currentVersion forKey:@"saveVersion"];
        
        window.rootViewController = featureVc;
    }else{//直接跳转到app
        XHTabBarViewController *tableBarVc = [[XHTabBarViewController alloc]init];
        window.rootViewController = tableBarVc;
        
        
    }
}

-(void)jumpRvc
{
    //首先销毁通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //跳转到app控制
    XHTabBarViewController *tableBarVc = [[XHTabBarViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tableBarVc;
}

@end
