//
//  TutorialScreenView.h
//  OriginalApp(卒業制作)
//
//  Created by 平山亮 on 2015/02/24.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharaCreateView.h"
#import<AVFoundation/AVFoundation.h>

@interface TutorialScreenView : UIViewController

@property BOOL fromTitleView;
@property AVAudioPlayer *player;
@property AVAudioPlayer *voicePlayer;
@end
