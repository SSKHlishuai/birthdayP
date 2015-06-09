//
//  BirthDatabase.m
//  BirthdayP
//
//  Created by mc on 15/6/9.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "BirthDatabase.h"

@implementation BirthDatabase


#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

#define GeebooDB @"mydatabase.sqlite"

static BirthDatabase *dbConnection;

+(id)shareInstance
{
    if(!dbConnection)
    {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            dbConnection = [[BirthDatabase alloc]init];
        });
    }
    return dbConnection;
}
-(id)init{
    self=[super init];
    if (self) {
        // accountId = [UserInfor getInstanceUser].accountId;
        self.GeebooQueue= [FMDatabaseQueue databaseQueueWithPath:[self documentsDirectoryWithFileName:GeebooDB]];
        
    }
    
    return self;
}

-(NSString*)documentsDirectoryWithFileName:(NSString*)fileName
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    NSString *directoryString = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    return directoryString;
}


#pragma mark - public

//添加
-(void)insertPIDataWithModel:(BirthModel *)bmodel
{
    [self.GeebooQueue inDatabase:^(FMDatabase * db){
        [db beginTransaction];
        [db executeUpdate:@"insert into BirthdbTable (name,gender,level,birthday,remark,userid) values(?,?,?,?,?,?)",bmodel.bname,bmodel.bgender,bmodel.blevel,bmodel.bbirthday,bmodel.bremarks,bmodel.buserid];
        FMDBQuickCheck(![db hadError]);
        [db commit];
    }];
    
}


@end
