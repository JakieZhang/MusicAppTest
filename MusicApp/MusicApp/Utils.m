//
//  Utils.m
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/17.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import "Utils.h"
#import <AVFoundation/AVFoundation.h>
@implementation Utils
+(NSDictionary *)parseLrcWithPath:(NSURL *)url{
    NSString *lrcString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [lrcString componentsSeparatedByString:@"\n"];
    NSMutableDictionary *lrcDIc = [NSMutableDictionary dictionary];
    for (NSString *line in lines) {
        if (![line containsString:@"]"]) {
            continue;
        }
        NSArray *timeAndText = [line componentsSeparatedByString:@"]"];
        NSString *text = [timeAndText lastObject];
        NSString *timeString = [[timeAndText firstObject]substringFromIndex:1];
        NSArray *timeArr = [timeString componentsSeparatedByString:@":"];
        float time = [timeArr[0] integerValue]*60+[timeArr[1] floatValue];
        [lrcDIc setObject:text forKey:@(time)];
    }
    return lrcDIc;
}
@end
