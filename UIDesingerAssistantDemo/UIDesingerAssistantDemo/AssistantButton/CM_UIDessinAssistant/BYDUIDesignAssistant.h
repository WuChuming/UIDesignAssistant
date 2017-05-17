//
//  BYDUIDesignAssistant.h
//  BYDnetwork
//
//  Created by WuChuMing on 17/5/16.
//  Copyright © 2017年 Shawn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYDUIDesignAssistant : NSObject

+ (instancetype)shareInstance;

- (void)setAssistant;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *textDataSource;

@end
