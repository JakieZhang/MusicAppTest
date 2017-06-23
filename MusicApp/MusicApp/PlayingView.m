//
//  PlayingView.m
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/17.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import "PlayingView.h"

#import "AFNetworking.h"
#import "Utils.h"
#import "AppDelegate.h"
static PlayingView *_playingView;
@implementation PlayingView

+(PlayingView *)shareView{
    if (!_playingView) {
        _playingView = [[[NSBundle mainBundle]loadNibNamed:@"PlayingView" owner:self options:nil]lastObject];
    }
    return _playingView;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //后台播放，设置回话类型
    AVAudioSession *session = [AVAudioSession sharedInstance];
    //类型是：播放和录音
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    //而且要激活，音频会话
    [session setActive:YES error:nil];
    // 创建毛玻璃特效
    UIBlurEffect *eff = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //特效视图
    UIVisualEffectView *ve = [[UIVisualEffectView alloc]initWithEffect:eff];
    ve.frame = self.artworkIV.frame;
    //把毛玻璃视图添加到控件中
    [self.artworkIV addSubview:ve];
    //初始化MainSV 里面的控件
    [self initUI];
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
    //得到之前保存的数组和下标
    self.songs = [NSKeyedUnarchiver unarchiveObjectWithFile:kSongsPath];
    if (self.songs>0) {
        BangDanDetailModel *songs = self.songs[0];
        self.song = songs;
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finishAction) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)updateUI{
    //得到歌曲当前播放的时间
    float currentTime = self.player.currentTime.value*1.0/self.player.currentTime.timescale;
    //设置slider的值
    self.progressSlider.value = currentTime;
    //设置进度条的值
    self.playingBpttomView.progressView.progress = currentTime/self.songDetail.file_duration.floatValue;
    
    for (NSInteger i = 0; i< self.keys.count; i++) {
        float time = [self.keys[i] floatValue];
        if (time > currentTime) {
            int row = i==0?0:i-1;
            [self.lrcTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            break;
        }
    }
}

-(void)initUI{
    self.songListTableView = [[UITableView alloc]initWithFrame:self.mainSV.bounds style:UITableViewStylePlain];
    self.songListTableView.delegate = self;
    self.songListTableView.dataSource = self;
    self.songListTableView.tag = 0;
    [self.mainSV addSubview:self.songListTableView];
    
    
    
    self.centerView = [[[NSBundle mainBundle]loadNibNamed:@"CenterView" owner:self options:nil]firstObject];
    self.centerView.left = kSW;
    [self.mainSV addSubview: self.centerView];
    
    self.lrcTableView  = [[UITableView alloc]initWithFrame:self.mainSV.bounds style:UITableViewStylePlain];
    self.lrcTableView.separatorStyle = self.songListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.lrcTableView.left = 2*kSW;
    self.lrcTableView.delegate = self;
    self.lrcTableView.dataSource = self;
    self.lrcTableView.tag = 1;
    self.lrcTableView.size = self.mainSV.size;

    
    [self.mainSV addSubview:self.lrcTableView];
    
    self.mainSV.contentSize = CGSizeMake(3*kSW, 0);
    self.mainSV.pagingEnabled = YES;
    self.mainSV.contentOffset = CGPointMake(kSW, 0);
    
    self.lrcTableView.backgroundColor = self.songListTableView.backgroundColor = [UIColor clearColor];

}

-(void)show{
    [self.superview bringSubviewToFront:self];
    [UIView animateWithDuration:.5 animations:^{
        self.top = 0;
    }];
}

-(void)dismiss{
[UIView animateWithDuration:.5 animations:^{
    self.top = kSH;
}];
}



- (IBAction)BackAction:(id)sender {
    [self dismiss];
}

- (IBAction)sliderAction:(UISlider *)sender {
    [self.player pause];
    [self.player seekToTime:CMTimeMakeWithSeconds(sender.value, self.player.currentTime.timescale) completionHandler:^(BOOL finished) {
        [self.player play];
    }];
    
}

- (IBAction)musicControlAction:(UIButton *)sender {
    if (sender.tag == 0) {
        if (self.isPlaying) {
            [self.player pause];
            self.isPlaying = NO;
            sender.selected = self.playingBpttomView.playBtn.selected = NO;
        }else{
            [self.player play];
            self.isPlaying = YES;
            sender.selected = self.playingBpttomView.playBtn.selected = YES;
        }
    }else if(sender.tag == 1){
        self.currentIndex--;
        if (self.currentIndex == -1) {
            self.currentIndex = self.songs.count-1;
        }
        self.songs = self.songs[self.currentIndex];
    }else{
        self.currentIndex++;
        if (self.currentIndex == self.songs.count) {
            self.currentIndex = 0;
        }
        self.songs = self.songs[self.currentIndex];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:[UIApplication sharedApplication].keyWindow];
    self.beginY = p.y;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:[UIApplication sharedApplication].keyWindow];
    float offsetY = p.y - self.beginY;
    self.y += offsetY;
    //每次移动完成之后的坐标为下一次的起始坐标
    self.beginY = p.y;
    if (self.top <= 0) {
        self.top = 0;
    }


}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.top < 200) {
        [self show];
    }else{
        [self dismiss];
    }
}

-(void)setSong:(BangDanDetailModel *)song{
    [[NSUserDefaults standardUserDefaults]setInteger:self.currentIndex forKey:@"playIndex"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    _song = song;
    [self.task cancel];
    if (self.player.currentItem) {
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
    self.progressView.progress = 0;
    //请求歌曲详情
    [NetWorking getGetObjFromNetWorkWithPagram:nil andURL:[NSString stringWithFormat:kSongsPath,song.song_id] andCompletion:^(id obj) {
        SongModel *song = [[SongModel alloc]initWithDictionary:obj[@"songinfo"] error:nil];
        NSString *musicPath = obj[@"songurl"][@"url"][0][@"show_link"];
        song.musicURL = [NSURL URLWithString:musicPath];
        self.songDetail = song;
        self.centerView.song = self.songDetail;
        [self.artworkIV setImageWithURL:self.songDetail.pic_big];
        NSString *musicPathNew = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.mp3",self.songDetail.title];
        AVPlayerItem *item = nil;
        if ([[NSFileManager defaultManager]fileExistsAtPath:musicPathNew]) {
            NSURL *url = [NSURL fileURLWithPath:musicPathNew];
            item = [AVPlayerItem playerItemWithURL:url];
            self.progressView.progress = 1;
        }else{
            item = [AVPlayerItem playerItemWithURL:self.songDetail.musicURL];
        }
        
        //监听歌曲 下载情况
        [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [self.player replaceCurrentItemWithPlayerItem:item];
        
        self.lrcDic = [Utils parseLrcWithPath:self.songDetail.lrclink];
        self.keys = [self.lrcDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
        [self.lrcTableView reloadData];
        
        self.progressSlider.maximumValue = self.songDetail.file_duration.floatValue;
        [self.playingBpttomView.artworkIV setImageWithURL:self.songDetail.pic_big];
        self.playingBpttomView.titleLabel.text = self.songDetail.title;
        self.playingBpttomView.authorLabel.text = self.songDetail.author;
        
        
    }];
    self.playingBpttomView.playBtn.selected = YES;

}


-(void)finishAction{
    self.currentIndex++;
    if (self.currentIndex == self.songs.count) {
        self.currentIndex = 0;
    }
    self.song = self.songs[self.currentIndex];
}

-(void)downloadMusic{
    NSURL *musicUrl = self.songDetail.musicURL;
    self.musicDate = [NSMutableData data];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    self.task = [manager dataTaskWithRequest:[NSURLRequest requestWithURL:musicUrl] uploadProgress:nil downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.progress = downloadProgress.fractionCompleted;
        });
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSString *newPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.mp3",self.songDetail.title];
        [self.musicDate writeToFile:newPath atomically:YES];
        NSMutableArray *songs = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:kSongsPath]];
        [songs addObject:self.song];
        [NSKeyedArchiver archiveRootObject:songs toFile:kSongsPath];
    }];
    [manager setDataTaskDidReceiveDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSData * _Nonnull data) {
        [self.musicDate appendData:data];
    }];
    [self.task resume];

}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    AVPlayerStatus status = [change[@"new"] integerValue];
    switch (status) {
        case AVPlayerStatusReadyToPlay:
            [self.player play];
            self.isPlaying = YES;
            break;
        case AVPlayerStatusFailed:
            NSLog(@"加载失败");
            break;
        case AVPlayerStatusUnknown:
            NSLog(@"找不到资源");
            break;
        default:
            break;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionP{
    if (tableView.tag == 0) {
        return self.songs.count;
    }
    return  self.lrcDic.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.textColor = [UIColor lightGrayColor];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
            cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        }
        BangDanDetailModel *songs = self.songs[indexPath.row];
        cell.textLabel.text = songs.title;
        cell.detailTextLabel.text = songs.author;
        if (indexPath.row == self.currentIndex) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
                NSData *data = [NSData dataWithContentsOfURL:songs.pic_small];
                UIImage *image = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageView.image = image;
                    [cell setNeedsLayout];
                });
            });
        }else{
            cell.imageView.image = nil;
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        NSNumber *key = self.keys[indexPath.row];
        NSString *text = self.lrcDic[key];
        cell.textLabel.text = text;
        
        
        //控制显示效果
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.shadowColor = [UIColor whiteColor];
        cell.textLabel.shadowOffset = CGSizeMake(.5, .5);
        //歌词高亮颜色
        cell.textLabel.highlightedTextColor = [UIColor yellowColor];
        //去掉选中颜色
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        return cell;
    }

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        self.currentIndex = indexPath.row;
        self.song = self.songs[indexPath.row];
        [self.songListTableView reloadData];
    }else{
        NSString *key = self.keys[indexPath.row];
        [self.player pause];
        [self.player seekToTime:CMTimeMakeWithSeconds(key.floatValue, self.player.currentTime.timescale) completionHandler:^(BOOL finished) {
            if (finished) {
                [self.player play];
            }
        }];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        return 25;
    }
    return 40;
}








@end
