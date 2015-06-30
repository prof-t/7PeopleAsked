//
//  CharacterStatus.h
//  OriginalApp(卒業制作)
//
//  Created by RYO on 2015/03/01.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>

@interface CharacterStatus : UILabel

-(UIImage*)trimIMG:(int)number;
-(UIWebView*)trimIMGView:(int)number;
-(UIWebView*)makeWebView:(NSString*)image rect:(CGRect)rect;

@property NSString *player_name;
@property NSString *player_age;
@property NSString *player_avatar;
@property NSString *player_gender;
@property NSString *player_totalScore;
@property NSString *player_titleOfHonor;
@property NSInteger player_answer;

//@property NSString *player1_name;
//@property NSString *player1_age;
//@property NSString *player1_avatar;
//@property NSString *player1_gender;
//@property NSString *player1_totalScore;
//@property NSString *player1_titleOfHonor;
//@property NSInteger player1_answer;
//
//@property NSString *player2_name;
//@property NSString *player2_age;
//@property NSString *player2_avatar;
//@property NSString *player2_gender;
//@property NSString *player2_totalScore;
//@property NSString *player2_titleOfHonor;
//@property NSInteger player2_answer;
//
//@property NSString *player3_name;
//@property NSString *player3_age;
//@property NSString *player3_avatar;
//@property NSString *player3_gender;
//@property NSString *player3_totalScore;
//@property NSString *player3_titleOfHonor;
//@property NSInteger player3_answer;
//
//@property NSString *player4_name;
//@property NSString *player4_age;
//@property NSString *player4_avatar;
//@property NSString *player4_gender;
//@property NSString *player4_totalScore;
//@property NSString *player4_titleOfHonor;
//@property NSInteger player4_answer;
//
//@property NSString *player5_name;
//@property NSString *player5_age;
//@property NSString *player5_avatar;
//@property NSString *player5_gender;
//@property NSString *player5_totalScore;
//@property NSString *player5_titleOfHonor;
//@property NSInteger player5_answer;
//
//@property NSString *player6_name;
//@property NSString *player6_age;
//@property NSString *player6_avatar;
//@property NSString *player6_gender;
//@property NSString *player6_totalScore;
//@property NSString *player6_titleOfHonor;
//@property NSInteger player6_answer;
//
//@property NSString *player7_name;
//@property NSString *player7_age;
//@property NSString *player7_avatar;
//@property NSString *player7_gender;
//@property NSString *player7_totalScore;
//@property NSString *player7_titleOfHonor;
//@property NSInteger player7_answer;


@end