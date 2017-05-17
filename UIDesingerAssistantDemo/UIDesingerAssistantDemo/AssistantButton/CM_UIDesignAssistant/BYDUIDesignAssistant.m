//
//  BYDUIDesignAssistant.m
//  BYDnetwork
//
//  Created by WuChuMing on 17/5/16.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import "BYDUIDesignAssistant.h"
#import "XFAssistiveTouch.h"
#import "BYDclassSourceController.h"
#import <objc/objc.h>

@interface BYDUIDesignAssistant ()<XFXFAssistiveTouchDelegate>


@end
@implementation BYDUIDesignAssistant


+ (instancetype)shareInstance{
    static BYDUIDesignAssistant *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BYDUIDesignAssistant alloc] init];
    });
    return instance;
}

- (void)setAssistant{
    XFAssistiveTouch *assistiveTouch = [XFAssistiveTouch sharedInstance];
    assistiveTouch.delegate = self;
    [assistiveTouch showAssistiveTouch];
}



- (void)touchButtonDidClick{
    
    if ([self getCurrentVC].navigationController.viewControllers.count > 1 ) {
        [[self getCurrentVC].navigationController popViewControllerAnimated:YES];
    } else {
    BYDclassSourceController *vc = [[BYDclassSourceController alloc] init];
    vc.dataSource = self.dataSource;
    
    [[self getCurrentVC] presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    }
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        
        NSLog(@"===%@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}

#pragma mark ---懒加载---
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)textDataSource{
    if (!_textDataSource) {
        _textDataSource = [NSMutableArray array];
    }
    return _textDataSource;
}

@end
