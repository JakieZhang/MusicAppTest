//
//  PalyingBottomView.h
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/17.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PalyingBottomView : UIView
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *artworkIV;
- (IBAction)tapAction:(id)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)PlayBtnAction:(id)sender;





@end
