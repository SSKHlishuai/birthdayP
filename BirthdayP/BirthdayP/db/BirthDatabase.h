//
//  BirthDatabase.h
//  BirthdayP
//
//  Created by mc on 15/6/9.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "BirthModel.h"

@interface BirthDatabase : NSObject

@property(nonatomic,strong)FMDatabaseQueue* GeebooQueue;


+(id)shareInstance;


-(void)insertPIDataWithModel:(BirthModel *)bmodel;


@end
