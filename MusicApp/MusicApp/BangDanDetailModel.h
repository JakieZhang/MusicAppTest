//
//  BangDanDetailModel.h
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/19.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import "JSONModel.h"

@interface BangDanDetailModel : JSONModel
@property (nonatomic,copy)NSString<Optional> *title;
@property (nonatomic,copy)NSString<Optional> *author;
@property (nonatomic,strong)NSURL<Optional> *pic_small;
@property (nonatomic,strong)NSURL<Optional> *lrclink;
@property (nonatomic,copy)NSString<Optional> *has_mv;

@property (nonatomic,copy)NSString<Optional> *song_id;
@property (nonatomic,copy)NSString<Optional> *resource_type_ext;
@property (nonatomic,copy)NSString<Optional> *rank;
@end
