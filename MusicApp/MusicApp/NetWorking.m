//
//  NetWorking.m
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/17.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import "NetWorking.h"
#import "AFNetworking.h"
@implementation NetWorking
+(void)getObjFromNetWorkWithPagram:(NSDictionary *)paragrm andURL:(NSString *)url andCompletion:(MyCallBack)callback{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:url parameters:paragrm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        callback(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(error);
    }];
}
@end
