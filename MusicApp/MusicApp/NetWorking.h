//
//  NetWorking.h
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/17.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^MyCallBack)(id obj);
@interface NetWorking : NSObject
+(void)getObjFromNetWorkWithPagram:(NSDictionary *)paragrm andURL:(NSString *)url andCompletion:(MyCallBack)callback;

+(void)getGetObjFromNetWorkWithPagram:(NSDictionary *)paragrm andURL:(NSString *)url andCompletion:(MyCallBack)callback;
@end
