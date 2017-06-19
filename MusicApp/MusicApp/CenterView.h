//
//  CenterView.h
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/17.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongModel.h"
@interface CenterView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *artworkIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *suthorLabel;
- (IBAction)downloadAction:(id)sender;
@property(nonatomic,strong)SongModel *song;

@end
