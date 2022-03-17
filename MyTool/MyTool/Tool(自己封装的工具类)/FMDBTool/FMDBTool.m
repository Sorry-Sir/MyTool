//
//  FMDBTool.m
//  MyToolDemo
//
//  Created by sorry.sir on 2017/8/3.
//  Copyright © 2017年 hongxujia. All rights reserved.
//

#import "FMDBTool.h"

#import <FMDB/FMDB.h>

@implementation FMDBTool

static FMDatabase * _db;

+(void)initialize{
    
    NSString *_dbPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"SVNSQLTest.sqlite"];
    
    _db =[FMDatabase databaseWithPath:_dbPath];
    
    if (![_db open]) {
        
        NSLog(@"打开失败");
        
        return;
    }
    
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_SVNSQLTestTable(id integer PRIMARY KEY, Name text,Password text);"];
    
    
}

+(void)addName:(NSString *)name Password:(NSString *)password{
    
    [_db executeUpdateWithFormat:@"INSERT INTO t_SVNSQLTestTable(Name,Password) VALUES(%@,%@);",name,password];
    
    
}

+(void)updateName:(NSString *)name Password:(NSString *)password{
    
    [_db executeUpdateWithFormat:@"UPDATE t_SVNSQLTestTable SET Password = %@ WHERE Name = %@;",password,name];
    
    
}

+(void)removeName:(NSString *)name Password:(NSString *)password;{
    
    [_db executeUpdateWithFormat:@"DELETE FROM t_SVNSQLTestTable WHERE Name = %@;",name];
    
}

+(void)removeAll{
    
    [_db executeUpdateWithFormat:@"DELETE FROM t_SVNSQLTestTable;"];
    
}

+(NSMutableArray*)selectAll{
    
    FMResultSet *resultSet=[_db executeQueryWithFormat:@"SELECT * FROM t_SVNSQLTestTable;"];
    
    NSMutableArray *arrM=[[NSMutableArray alloc]init];
    
    while (resultSet.next) {
        
        NSString *name=[resultSet objectForColumn:@"Name"];
        NSString *password=[resultSet objectForColumn:@"Password"];
        NSDictionary *dic =@{name:password};
        
        [arrM addObject:dic];
    }
    
    return arrM;
}

+(NSMutableArray*)selectName:(NSString *)name{
    
    FMResultSet *resultSet=[_db executeQueryWithFormat:@"SELECT * FROM t_SVNSQLTestTable WHERE Name = %@;",name];
    
    NSMutableArray *arrM=[[NSMutableArray alloc]init];
    
    while (resultSet.next) {
        
        NSString *name=[resultSet objectForColumn:@"Name"];
        NSString *password=[resultSet objectForColumn:@"Password"];
        NSDictionary *dic =@{name:password};
        
        [arrM addObject:dic];
    }
    
    return arrM;
}



@end













