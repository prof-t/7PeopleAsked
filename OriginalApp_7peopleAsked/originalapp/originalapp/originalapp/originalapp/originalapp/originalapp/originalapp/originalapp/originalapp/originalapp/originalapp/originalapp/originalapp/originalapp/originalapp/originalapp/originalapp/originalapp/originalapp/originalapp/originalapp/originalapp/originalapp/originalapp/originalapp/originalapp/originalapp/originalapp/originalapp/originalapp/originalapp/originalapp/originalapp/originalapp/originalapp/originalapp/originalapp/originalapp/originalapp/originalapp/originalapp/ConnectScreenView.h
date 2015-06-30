//
//  ConnectScreenView.h
//  OriginalApp(卒業制作)
//
//  Created by 平山亮 on 2015/02/24.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<GameKit/GameKit.h>
#import<MultipeerConnectivity/MultipeerConnectivity.h>
#import"CharacterStatus.h"
#import "QuestionScreenView.h"
#import "FMDB.h"
#import"ConnectModeSelectView.h"
#import<AVFoundation/AVFoundation.h>

@interface ConnectScreenView : UIViewController
<UITextFieldDelegate,MCAdvertiserAssistantDelegate,MCSessionDelegate,MCBrowserViewControllerDelegate>
{
    //UI
    UITextField* _textField;
    UIButton* _btnAdvertise;
    UIButton* _btnBrowse;
    UIButton* _btnSend;
    UIButton* _btnDisconnect;
    
    //MultipeerConnectivity
    MCSessionState _state;
    MCPeerID* _myPeerID;
    MCSession* _session;
    MCAdvertiserAssistant* _assistant;
    MCBrowserViewController* _browseViewController;
    
    //各ユーザーの情報を格納する変数
    CharacterStatus *_user1;
    CharacterStatus *_user2;
    CharacterStatus *_user3;
    CharacterStatus *_user4;
    CharacterStatus *_user5;
    CharacterStatus *_user6;
    CharacterStatus *_user7;
    
}

@property NSString *player_age;
@property NSString *player_name;
@property NSString *player_avatar;
@property NSString *player_gender;
@property AVAudioPlayer *player;
@property AVAudioPlayer *voicePlayer;
@property BOOL aloneMode;

@end
