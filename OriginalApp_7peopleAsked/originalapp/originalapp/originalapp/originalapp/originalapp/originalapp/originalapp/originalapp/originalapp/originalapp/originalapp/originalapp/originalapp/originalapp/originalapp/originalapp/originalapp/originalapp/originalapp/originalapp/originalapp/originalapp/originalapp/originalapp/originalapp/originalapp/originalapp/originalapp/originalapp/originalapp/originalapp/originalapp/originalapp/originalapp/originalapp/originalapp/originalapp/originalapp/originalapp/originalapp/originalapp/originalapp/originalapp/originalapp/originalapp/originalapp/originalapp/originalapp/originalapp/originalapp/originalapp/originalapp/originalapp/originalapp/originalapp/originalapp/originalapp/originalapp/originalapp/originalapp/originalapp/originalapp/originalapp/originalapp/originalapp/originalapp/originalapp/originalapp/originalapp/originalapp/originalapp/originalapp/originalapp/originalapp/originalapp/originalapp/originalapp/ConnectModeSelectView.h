//
//  ConnectModeSelectView.h
//  OriginalApp(卒業制作)
//
//  Created by 平山亮 on 2015/03/18.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterStatus.h"
#import"CharaCreateView.h"
#import"ConnectScreenView.h"
#import<AVFoundation/AVFoundation.h>

@interface ConnectModeSelectView : UIViewController

@property NSString *player_age;
@property NSString *player_name;
@property NSString *player_avatar;
@property NSString *player_gender;

@property NSNumber* player1_totalScore;
@property NSNumber* player2_totalScore;
@property NSNumber* player3_totalScore;
@property NSNumber* player4_totalScore;
@property NSNumber* player5_totalScore;
@property NSNumber* player6_totalScore;
@property NSNumber* player7_totalScore;

@property NSString *connectModeSelectViewTest;

@property AVAudioPlayer *player;
@property AVAudioPlayer *voicePlayer;

@end
