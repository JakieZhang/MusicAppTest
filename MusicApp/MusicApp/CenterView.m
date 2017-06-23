//
//  CenterView.m
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/17.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import "CenterView.h"
#import "PlayingView.h"
@implementation CenterView

-(void)setSong:(SongModel *)song{
    _song = song;
    self.titleLabel.text = song.title;
    self.suthorLabel.text = song.author;
    [self.artworkIV setImageWithURL:song.album_500_500];

}

- (IBAction)downloadAction:(id)sender {
    [[PlayingView shareView] downloadMusic];
}
@end
