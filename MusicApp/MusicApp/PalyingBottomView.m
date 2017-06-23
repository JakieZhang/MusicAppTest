//
//  PalyingBottomView.m
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/17.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import "PalyingBottomView.h"
#import "PlayingView.h"
@implementation PalyingBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)tapAction:(id)sender {
    [[PlayingView shareView]show];
}

- (IBAction)nextAction:(id)sender {
}

- (IBAction)PlayBtnAction:(UIButton *)sender {
    if ([PlayingView shareView].isPlaying) {
        [[PlayingView shareView].player pause];
        sender.selected = [PlayingView shareView].playorpauseBtn.selected = NO;
    }else{
        [[PlayingView shareView].player play];
        sender.selected = [PlayingView shareView].playorpauseBtn.selected = YES;
    }
    
}
@end
