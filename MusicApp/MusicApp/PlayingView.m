//
//  PlayingView.m
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/17.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import "PlayingView.h"
#define kSongsPath [NSHomeDirectory() stringByAppendingString:@"/Documents/songs.arch"]
#import "AFNetworking.h"
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
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryRecord error:nil];
    [session setActive:YES error:nil];
    
    UIBlurEffect *eff = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *ve = [[UIVisualEffectView alloc]initWithEffect:eff];
    ve.frame = self.artworkIV.frame;
    [self.artworkIV addSubview:ve];
    [self initUI];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
    
    self.songs = [NSKeyedUnarchiver unarchiveObjectWithFile:kSongsPath];
    if (self.songs.count>0) {
        
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finishAction:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)updateUI{
    float currentTime = self.player.currentTime.value*1.0/self.player.currentTime.timescale;
    self.progressSlider.value = currentTime;
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
}

- (IBAction)sliderAction:(id)sender {
}
@end
