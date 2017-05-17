//
//  UIViewController+runtime.m
//  BYDnetwork
//
//  Created by WuChuMing on 17/5/17.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import "UIViewController+runtime.h"
#import "BYDUIDesignAssistant.h"
#import <objc/runtime.h>


@implementation UIViewController (runtime)

+ (void)load{
    int numClasses;    Class *classes = NULL;
    classes = NULL;
    numClasses = objc_getClassList(NULL,0);
    NSLog(@"Number of classes: %d", numClasses);
    
    if (numClasses >0 )
    {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            NSString *className = [NSString stringWithUTF8String:   class_getName(classes[i])];
            if ([self fliterConditionwithClassName:className]) {
                NSLog(@"Class name: %@",className);
                [[BYDUIDesignAssistant shareInstance].dataSource addObject:className];
            }
            }
        free(classes);
    }
}


+ (BOOL)fliterConditionwithClassName:(NSString *)className{
    Class c = NSClassFromString(className);
    
    return ![className hasPrefix:@"_"] && [className hasSuffix:@"Controller"]&& ![className hasPrefix:@"UI"]&&![className hasPrefix:@"AB"]&& [c isSubclassOfClass:[UIViewController class]]&&![className hasPrefix:@"CN"]&&![className hasPrefix:@"MK"]&&![className hasPrefix:@"CM"]&&[className rangeOfString:@"Nav"].length<=0&&![className hasPrefix:@"Deferred"];

}
@end
