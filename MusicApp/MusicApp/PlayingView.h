//
//  PlayingView.h
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/17.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SongModel.h"
#import "CenterView.h"
#import "PalyingBottomView.h"
@interface PlayingView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *playorpauseBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIScrollView *mainSV;
@property (weak, nonatomic) IBOutlet UIImageView *artworkIV;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *topView;
@property (weak, nonatomic) IBOutlet UIButton *backAction;
- (IBAction)BackAction:(id)sender;
- (IBAction)sliderAction:(id)sender;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *musicControlAction;

@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,strong)NSArray *songs;
@property(nonatomic,strong)SongModel *songDetail;
@property(nonatomic,assign)NSInteger index;


@property(nonatomic,strong)UITableView *songListTableView;
@property(nonatomic,strong)UITableView *lrcTableView;
@property(nonatomic,strong)CenterView *centerView;
@property(nonatomic,strong)NSDictionary *lrcDic;
@property(nonatomic,strong)NSArray *keys;
@property(nonatomic,assign)float beginY;
@property(nonatomic,strong)NSMutableData *musicDate;
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,assign)BOOL isPlaying;

-(void)show;
-(void)dismiss;
+(PlayingView *)shareView;
@property(nonatomic,strong)PalyingBottomView *playingBpttomView;
@property(nonatomic,strong)NSURLSessionDataTask *task;

-(void)downloadMusic;





@end
