//
//  AnswerScreenView.h
//  OriginalApp(卒業制作)
//
//  Created by 平山亮 on 2015/02/24.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"ConnectScreenView.h"
#import<AVFoundation/AVFoundation.h>

@interface AnswerScreenView : UIViewController

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

@property NSNumber* player1_Answer;
//@property int player1_1stAnswer;
//@property int player1_2stAnswer;
//@property int player1_3stAnswer;
//@property int player1_4stAnswer;
//@property int player1_5stAnswer;
//@property int player1_6stAnswer;
//@property int player1_7stAnswer;

@property NSNumber* player2_Answer;
//@property int player2_1stAnswer;
//@property int player2_2stAnswer;
//@property int player2_3stAnswer;
//@property int player2_4stAnswer;
//@property int player2_5stAnswer;
//@property int player2_6stAnswer;
//@property int player2_7stAnswer;

@property NSNumber* player3_Answer;
//@property int player3_1stAnswer;
//@property int player3_2stAnswer;
//@property int player3_3stAnswer;
//@property int player3_4stAnswer;
//@property int player3_5stAnswer;
//@property int player3_6stAnswer;
//@property int player3_7stAnswer;

@property NSNumber* player4_Answer;
//@property int player4_1stAnswer;
//@property int player4_2stAnswer;
//@property int player4_3stAnswer;
//@property int player4_4stAnswer;
//@property int player4_5stAnswer;
//@property int player4_6stAnswer;
//@property int player4_7stAnswer;

@property NSNumber* player5_Answer;
//@property int player5_1stAnswer;
//@property int player5_2stAnswer;
//@property int player5_3stAnswer;
//@property int player5_4stAnswer;
//@property int player5_5stAnswer;
//@property int player5_6stAnswer;
//@property int player5_7stAnswer;

@property NSNumber* player6_Answer;
//@property int player6_1stAnswer;
//@property int player6_2stAnswer;
//@property int player6_3stAnswer;
//@property int player6_4stAnswer;
//@property int player6_5stAnswer;
//@property int player6_6stAnswer;
//@property int player6_7stAnswer;

@property NSNumber* player7_Answer;
//@property int player7_1stAnswer;
//@property int player7_2stAnswer;
//@property int player7_3stAnswer;
//@property int player7_4stAnswer;
//@property int player7_5stAnswer;
//@property int player7_6stAnswer;
//@property int player7_7stAnswer;

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

@property int player1_ID;
@property int player2_ID;
@property int player3_ID;
@property int player4_ID;
@property int player5_ID;
@property int player6_ID;
@property int player7_ID;

@property BOOL aloneMode;

@property int questionNumber;

@property int quizRound;
@property AVAudioPlayer *player;
@property AVAudioPlayer *voicePlayer;

@end
