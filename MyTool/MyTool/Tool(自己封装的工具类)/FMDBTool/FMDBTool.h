//
//  FMDBTool.h
//  MyToolDemo
//
//  Created by sorry.sir on 2017/8/3.
//  Copyright © 2017年 hongxujia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBTool : NSObject

+(void)addName:(NSString *)name Password:(NSString *)password;

+(void)updateName:(NSString *)name Password:(NSString *)password;

+(void)removeName:(NSString *)name Password:(NSString *)password;

+(void)removeAll;

+(NSMutableArray*)selectAll;

+(NSMutableArray*)selectName:(NSString *)name;

@end

