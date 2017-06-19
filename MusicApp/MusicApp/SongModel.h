//
//  SongModel.h
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/17.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import "JSONModel.h"

@interface SongModel : JSONModel
@property (nonatomic, copy) NSString *artist_500_500;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSURL *pic_big;
@property (nonatomic, copy) NSString *album_title;
@property (nonatomic, copy) NSString *pic_singer;
@property (nonatomic, copy) NSString *artist_640_1136;
@property (nonatomic, strong) NSURL *lrclink;
@property (nonatomic, copy) NSString *song_id;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, strong) NSURL *album_500_500;
@property (nonatomic, copy) NSString *file_duration;
@property (nonatomic, copy) NSString *artist_1000_1000;
@property (nonatomic, copy) NSString *album_1000_1000;
@property (nonatomic, copy) NSString *artist_480_800;


@property (nonatomic, strong) NSURL<Ignore> *musicURL;
@end
