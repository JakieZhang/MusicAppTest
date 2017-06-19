//
//  SongsInfo.h
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/17.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import "JSONModel.h"

@interface SongsInfo : JSONModel
@property (nonatomic, copy)NSString *songname;
@property (nonatomic, copy)NSString *artistname;
@end
