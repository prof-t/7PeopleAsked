//
//  QuestionScreenView.h
//  OriginalApp(卒業制作)
//
//  Created by 平山亮 on 2015/02/24.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectScreenView.h"
#import"AnswerScreenView.h"
#import<AVFoundation/AVFoundation.h>

@interface QuestionScreenView : UIViewController<UITextFieldDelegate,MCSessionDelegate>
{
    //MultipeerConnectivity
    MCSessionState _state;
    MCPeerID* _myPeerID;
    MCSession* _session;
    MCAdvertiserAssistant* _assistant;
    MCBrowserViewController* _browseViewController;
    
}
@property NSString *player1_age;
@property NSString *player1_name;
@property NSString *player1_avatar;
@property NSString *player1_gender;
@property NSString *player2_age;
@property NSString *player2_name;
@property NSString *player2_avatar;
@property NSString *player2_gender;
@property NSString *player3_age;
@property NSString *player3_name;
@property NSString *player3_avatar;
@property NSString *player3_gender;
@property NSString *player4_age;
@property NSString *player4_name;
@property NSString *player4_avatar;
@property NSString *player4_gender;
@property NSString *player5_age;
@property NSString *player5_name;
@property NSString *player5_avatar;
@property NSString *player5_gender;
@property NSString *player6_age;
@property NSString *player6_name;
@property NSString *player6_avatar;
@property NSString *player6_gender;
@property NSString *player7_age;
@property NSString *player7_name;
@property NSString *player7_avatar;
@property NSString *player7_gender;
@property int player1_ID;
@property int player2_ID;
@property int player3_ID;
@property int player4_ID;
@property int player5_ID;
@property int player6_ID;
@property int player7_ID;

@property BOOL player1;
@property BOOL player2;
@property BOOL player3;
@property BOOL player4;
@property BOOL player5;
@property BOOL player6;
@property BOOL player7;

@property NSNumber* player1_totalScore;
@property NSNumber* player2_totalScore;
@property NSNumber* player3_totalScore;
@property NSNumber* player4_totalScore;
@property NSNumber* player5_totalScore;
@property NSNumber* player6_totalScore;
@property NSNumber* player7_totalScore;

@property BOOL aloneMode;
@property BOOL hostPlayer;

@property AVAudioPlayer *player;
@property AVAudioPlayer *voicePlayer;
@property AVAudioPlayer *voice2Player;
@property NSString* selfName;

@property int questionNumber;

@end
