//
//  AnswerScreenView.m
//  OriginalApp(卒業制作)
//
//  Created by 平山亮 on 2015/02/24.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import "AnswerScreenView.h"

@interface AnswerScreenView ()

@end

@implementation AnswerScreenView
{
    
    __weak IBOutlet UILabel *nameLabel1;
    __weak IBOutlet UILabel *nameLabel2;
    __weak IBOutlet UILabel *nameLabel3;
    __weak IBOutlet UILabel *nameLabel4;
    __weak IBOutlet UILabel *nameLabel5;
    __weak IBOutlet UILabel *nameLabel6;
    __weak IBOutlet UILabel *nameLabel7;
    __weak IBOutlet UILabel *age1;
    __weak IBOutlet UILabel *age2;
    __weak IBOutlet UILabel *age3;
    __weak IBOutlet UILabel *age4;
    __weak IBOutlet UILabel *age5;
    __weak IBOutlet UILabel *age6;
    __weak IBOutlet UILabel *age7;
    __weak IBOutlet UILabel *gender1;
    __weak IBOutlet UILabel *gender2;
    __weak IBOutlet UILabel *gender3;
    __weak IBOutlet UILabel *gender4;
    __weak IBOutlet UILabel *gender5;
    __weak IBOutlet UILabel *gender6;
    __weak IBOutlet UILabel *gender7;
    __weak IBOutlet UILabel *titleOfHonor1;
    __weak IBOutlet UILabel *titleOfHonor2;
    __weak IBOutlet UILabel *titleOfHonor3;
    __weak IBOutlet UILabel *titleOfHonor4;
    __weak IBOutlet UILabel *titleOfHonor5;
    __weak IBOutlet UILabel *titleOfHonor6;
    __weak IBOutlet UILabel *titleOfHonor7;
    __weak IBOutlet UIImageView *avatarView1;
    __weak IBOutlet UIImageView *avatarView2;
    __weak IBOutlet UIImageView *avatarView3;
    __weak IBOutlet UIImageView *avatarView4;
    __weak IBOutlet UIImageView *avatarView5;
    __weak IBOutlet UIImageView *avatarView6;
    __weak IBOutlet UIImageView *avatarView7;
    __weak IBOutlet UILabel *totalScore1;
    __weak IBOutlet UILabel *totalScore2;
    __weak IBOutlet UILabel *totalScore3;
    __weak IBOutlet UILabel *totalScore4;
    __weak IBOutlet UILabel *totalScore5;
    __weak IBOutlet UILabel *totalScore6;
    __weak IBOutlet UILabel *totalScore7;
    __weak IBOutlet UIImageView *gakubuti1;
    __weak IBOutlet UIImageView *gakubuti2;
    __weak IBOutlet UIImageView *gakubuti3;
    __weak IBOutlet UIImageView *gakubuti4;
    __weak IBOutlet UIImageView *gakubuti5;
    __weak IBOutlet UIImageView *gakubuti6;
    __weak IBOutlet UIImageView *gakubuti7;
    __weak IBOutlet UILabel *player1_AnswerLabel;
    __weak IBOutlet UILabel *player2_AnswerLabel;
    __weak IBOutlet UILabel *player3_AnswerLabel;
    __weak IBOutlet UILabel *player4_AnswerLabel;
    __weak IBOutlet UILabel *player5_AnswerLabel;
    __weak IBOutlet UILabel *player6_AnswerLabel;
    __weak IBOutlet UILabel *player7_AnswerLabel;
    
    __weak IBOutlet UIView *scoreAnnounceView;
    __weak IBOutlet UIImageView *gakubuti;
    __weak IBOutlet UILabel *scoreAnnounceLabel;
    
    __weak IBOutlet UILabel *questionLabel_test;
    
    __weak IBOutlet UIButton *nextQuestion;
    
    __weak IBOutlet UIWebView *webview1;
    __weak IBOutlet UIWebView *webview2;
    
    __weak IBOutlet UIWebView *webview3;
    __weak IBOutlet UIWebView *webview4;
    __weak IBOutlet UIWebView *webview5;
    
    __weak IBOutlet UIWebView *webview6;
    __weak IBOutlet UIWebView *webview7;
    __weak IBOutlet UIButton *resultButton;
    
    
    NSString *avatar1;
    NSString *avatar2;
    NSString *avatar3;
    NSString *avatar4;
    NSString *avatar5;
    NSString *avatar6;
    NSString *avatar7;
    
    __weak IBOutlet UIView *player1baseView;
    __weak IBOutlet UIView *player2baseView;
    __weak IBOutlet UIView *player3baseView;
    __weak IBOutlet UIView *player4baseView;
    __weak IBOutlet UIView *player5baseView;
    __weak IBOutlet UIView *player6baseView;
    __weak IBOutlet UIView *player7baseView;
    
    
    
    NSString *averageScoreDistance_player1;
    NSString *averageScoreDistance_player2;
    NSString *averageScoreDistance_player3;
    NSString *averageScoreDistance_player4;
    NSString *averageScoreDistance_player5;
    NSString *averageScoreDistance_player6;
    NSString *averageScoreDistance_player7;
    
    NSMutableArray *array;
    
    NSNumber* minScore;
    NSNumber* maxScore;
    NSNumber *avgScore;
    NSNumber *centerScore;
    NSNumber* minScore_plusGroup;
    NSNumber* maxScore_plusGroup;
    
    UIWebView *animationGifView;
    CharacterStatus *characterStatus;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *voiceURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"answerView1" ofType:@"wav"]];
    _voicePlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:voiceURL error:nil];
    self.player.numberOfLoops =  0;
    [self.voicePlayer play];
    
    NSURL *bgmURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"TV" ofType:@"mp3"] ];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:bgmURL error:nil];
    self.player.numberOfLoops = -1;
    [self.player play];
    
    //webビュー用の別クラスのインスタンスを作成
    characterStatus = [[CharacterStatus alloc]init];
    
    nameLabel1.text=self.player1_name;
    nameLabel2.text=self.player2_name;
    nameLabel3.text=self.player3_name;
    nameLabel4.text=self.player4_name;
    nameLabel5.text=self.player5_name;
    nameLabel6.text=self.player6_name;
    nameLabel7.text=self.player7_name;
    
    gender1.text=self.player1_gender;
    gender2.text=self.player2_gender;
    gender3.text=self.player3_gender;
    gender4.text=self.player4_gender;
    gender5.text=self.player5_gender;
    gender6.text=self.player6_gender;
    gender7.text=self.player7_gender;
    
    age1.text=self.player1_age;
    age2.text=self.player2_age;
    age3.text=self.player3_age;
    age4.text=self.player4_age;
    age5.text=self.player5_age;
    age6.text=self.player6_age;
    age7.text=self.player7_age;
    
    avatar1=self.player1_avatar;
    avatar2=self.player2_avatar;
    avatar3=self.player3_avatar;
    avatar4=self.player4_avatar;
    avatar5=self.player5_avatar;
    avatar6=self.player6_avatar;
    avatar7=self.player7_avatar;
    
//    if(self.player1_totalScore == nil){
//        totalScore1.text=@"0点";
//        totalScore2.text=@"0点";
//        totalScore3.text=@"0点";
//        totalScore4.text=@"0点";
//        totalScore5.text=@"0点";
//        totalScore6.text=@"0点";
//        totalScore7.text=@"0点";
//
//    } else {
    NSString *totalScore;
    totalScore= [[NSString alloc]initWithFormat:@"%@点",self.player1_totalScore];
    totalScore1.text = totalScore;
    totalScore= [[NSString alloc]initWithFormat:@"%@点",self.player2_totalScore];
    totalScore2.text = totalScore;
    totalScore= [[NSString alloc]initWithFormat:@"%@点",self.player3_totalScore];
    totalScore3.text = totalScore;
    totalScore= [[NSString alloc]initWithFormat:@"%@点",self.player4_totalScore];
    totalScore4.text = totalScore;
    totalScore= [[NSString alloc]initWithFormat:@"%@点",self.player5_totalScore];
    totalScore5.text = totalScore;
    totalScore= [[NSString alloc]initWithFormat:@"%@点",self.player6_totalScore];
    totalScore6.text = totalScore;
    totalScore= [[NSString alloc]initWithFormat:@"%@点",self.player7_totalScore];
    totalScore7.text = totalScore;
//    }
    
    
    avatarView1.image = [UIImage imageNamed:avatar1];
    avatarView2.image = [UIImage imageNamed:avatar2];
    avatarView3.image = [UIImage imageNamed:avatar3];
    avatarView4.image = [UIImage imageNamed:avatar4];
    avatarView5.image = [UIImage imageNamed:avatar5];
    avatarView6.image = [UIImage imageNamed:avatar6];
    avatarView7.image = [UIImage imageNamed:avatar7];
    
    player1_AnswerLabel.text = [[NSString alloc]initWithFormat:@"%@",self.player1_Answer];
    player2_AnswerLabel.text = [[NSString alloc]initWithFormat:@"%@",self.player2_Answer];
    player3_AnswerLabel.text = [[NSString alloc]initWithFormat:@"%@",self.player3_Answer];
    player4_AnswerLabel.text = [[NSString alloc]initWithFormat:@"%@",self.player4_Answer];
    player5_AnswerLabel.text = [[NSString alloc]initWithFormat:@"%@",self.player5_Answer];
    player6_AnswerLabel.text = [[NSString alloc]initWithFormat:@"%@",self.player6_Answer];
    player7_AnswerLabel.text = [[NSString alloc]initWithFormat:@"%@",self.player7_Answer];
    
    player1baseView.userInteractionEnabled = YES;
    player2baseView.userInteractionEnabled = YES;
    player3baseView.userInteractionEnabled = YES;
    player4baseView.userInteractionEnabled = YES;
    player5baseView.userInteractionEnabled = YES;
    player6baseView.userInteractionEnabled = YES;
    player7baseView.userInteractionEnabled = YES;
    
    

    
    NSData *gifData1 = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:avatar1]];
    webview1.scalesPageToFit = YES;
    [webview1 loadData:gifData1 MIMEType:@"image/gif" textEncodingName:@"utf-8" baseURL:nil];
    
    NSData *gifData2 = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:avatar2]];
    webview2.scalesPageToFit = YES;
    [webview2 loadData:gifData2 MIMEType:@"image/gif" textEncodingName:@"utf-8" baseURL:nil];
    
    NSData *gifData3 = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:avatar3]];
    webview3.scalesPageToFit = YES;
    [webview3 loadData:gifData3 MIMEType:@"image/gif" textEncodingName:@"utf-8" baseURL:nil];
    
    NSData *gifData4 = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:avatar4]];
    webview4.scalesPageToFit = YES;
    [webview4 loadData:gifData4 MIMEType:@"image/gif" textEncodingName:@"utf-8" baseURL:nil];
    
    NSData *gifData5 = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:avatar5]];
    webview5.scalesPageToFit = YES;
    [webview5 loadData:gifData5 MIMEType:@"image/gif" textEncodingName:@"utf-8" baseURL:nil];
    
    NSData *gifData6 = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:avatar6]];
    webview6.scalesPageToFit = YES;
    [webview6 loadData:gifData6 MIMEType:@"image/gif" textEncodingName:@"utf-8" baseURL:nil];
    
    NSData *gifData7 = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:avatar7]];
    webview7.scalesPageToFit = YES;
    [webview7 loadData:gifData7 MIMEType:@"image/gif" textEncodingName:@"utf-8" baseURL:nil];


    //ソートできるけど、同じ数値だとひとまとめにされてしまうバグがあるよ
    NSDictionary *myDic =[NSDictionary dictionaryWithObjectsAndKeys:
                          @"player1",self.player1_Answer,
                          @"player2",self.player2_Answer,
                          @"player3",self.player3_Answer,
                          @"player4",self.player4_Answer,
                          @"player5",self.player5_Answer,
                          @"player6",self.player6_Answer,
                          @"player7",self.player7_Answer,
                          nil];
    
    NSArray *allScore = [myDic allKeys]; //keyだけのarrayを取得
    
    NSArray *rankingScore = [allScore sortedArrayUsingSelector:@selector(compare:)]; //要素だけのarrayを並び替え
    NSMutableArray *rankingScoreMutableArray = [NSMutableArray array];
    [rankingScoreMutableArray addObjectsFromArray:rankingScore];
    NSLog(@"Dictionaryで要素だけ並び替えたよ%@",rankingScoreMutableArray);
    
    
    
    //最小値
    minScore = [rankingScoreMutableArray valueForKeyPath:@"@min.self"];
    NSLog(@"最小値は%@",minScore);
    
    //最小値と等しい要素を全て取り除く
    for (int i = 0;i < [rankingScoreMutableArray count];i++){
        
        NSNumber* arrayValue = [rankingScoreMutableArray objectAtIndex:i];
        NSComparisonResult arrayToScoreMin = [arrayValue compare:minScore];
        
        if(arrayToScoreMin == NSOrderedSame){
            [rankingScoreMutableArray removeObjectAtIndex:i];
            NSLog(@"%d番目の要素を消したよ！",i);
        }
    }
    
    
    //最大値
    maxScore = [rankingScoreMutableArray valueForKeyPath:@"@max.self"];
    NSLog(@"最大値は%@",maxScore);
    
    for (int i = 0;i <= [rankingScoreMutableArray count];i++){
        
        NSNumber* arrayValue = [rankingScoreMutableArray objectAtIndex:i];
        NSComparisonResult arrayToScoreMax = [arrayValue compare:maxScore];
        
        if(arrayToScoreMax == NSOrderedSame){
            [rankingScoreMutableArray removeObjectAtIndex:i];
            NSLog(@"%d番目の要素を消したよ！",i);
        }
    }
    
    NSLog(@"残った要素は%@",rankingScoreMutableArray);
    
    //平均値
    avgScore = [rankingScoreMutableArray valueForKeyPath:@"@avg.self"];
    NSLog(@"平均値は%@",avgScore);
    
    //    //ソート
    [rankingScoreMutableArray sortUsingSelector:@selector(compare:)];
    
    
    
    // 一旦NSDictionaryのキーを取得
    NSArray *keys = [myDic allKeys];
    //        NSArray *values = [myDic allValues];
    array = [[NSMutableArray alloc]initWithObjects:@"playerなし", nil];
    
    // sortedArrayUsingComparatorを使ってソート
    keys = [keys sortedArrayUsingComparator:^(id o1, id o2) {
        return [o1 compare:o2];
    }];
    
    NSLog(@"%@",keys);
    
    // 順番通りに値を取得
    for (id key in keys) {
        [array addObject:[myDic objectForKey:key]];
        NSLog(@"%@",key);
    }
    
    
    int averageScoreInt = [avgScore intValue];
    int minScoreInt = [minScore intValue];
    int maxScoreInt = [maxScore intValue];
    
    averageScoreDistance_player1 = [self scoringRule:averageScoreInt min:minScoreInt max:maxScoreInt score:[self.player1_Answer intValue]];
    averageScoreDistance_player2 = [self scoringRule:averageScoreInt min:minScoreInt max:maxScoreInt score:[self.player2_Answer intValue]];
    averageScoreDistance_player3 = [self scoringRule:averageScoreInt min:minScoreInt max:maxScoreInt score:[self.player3_Answer intValue]];
    averageScoreDistance_player4 = [self scoringRule:averageScoreInt min:minScoreInt max:maxScoreInt score:[self.player4_Answer intValue]];
    averageScoreDistance_player5 = [self scoringRule:averageScoreInt min:minScoreInt max:maxScoreInt score:[self.player5_Answer intValue]];
    averageScoreDistance_player6 = [self scoringRule:averageScoreInt min:minScoreInt max:maxScoreInt score:[self.player6_Answer intValue]];
    averageScoreDistance_player7 = [self scoringRule:averageScoreInt min:minScoreInt max:maxScoreInt score:[self.player7_Answer intValue]];
    
    NSLog(@"皆の平均からの距離は%@,%@,%@,%@,%@,%@,%@",averageScoreDistance_player1,averageScoreDistance_player2,averageScoreDistance_player3,averageScoreDistance_player4,averageScoreDistance_player5,averageScoreDistance_player6,averageScoreDistance_player7);
    
    //中央値及び、残った要素の中での最大値、最小値の計算
    if(([rankingScoreMutableArray count] == 5)||([rankingScoreMutableArray count] == 4 )){
        centerScore = [rankingScoreMutableArray objectAtIndex:2];
    } else if(([rankingScoreMutableArray count] == 3)||([rankingScoreMutableArray count] ==2)){
        centerScore = [rankingScoreMutableArray objectAtIndex:1];
    } else if([rankingScoreMutableArray count] == 1){
        centerScore = [rankingScoreMutableArray objectAtIndex:0];
    }
    minScore_plusGroup = [rankingScoreMutableArray valueForKeyPath:@"@min.self"];
    NSLog(@"プラスグループの最小値は%@",minScore_plusGroup);
    maxScore_plusGroup = [rankingScoreMutableArray valueForKeyPath:@"@max.self"];
    NSLog(@"プラスグループの最大値は%@",maxScore_plusGroup);
    
    scoreAnnounceView.hidden=YES;
    gakubuti.hidden=YES;
    scoreAnnounceLabel.hidden=YES;
    
    resultButton.enabled = YES;
    
    [self announceScore];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)announceScore
{
    //3秒経過したら表示する
    [self performSelector:@selector(performComplete:) withObject:self.player1_Answer afterDelay:1.0];
    
    [self performSelector:@selector(performComplete) withObject:nil afterDelay:4.0];
    
    
    [self performSelector:@selector(performComplete:) withObject:self.player2_Answer afterDelay:7.0];
    
    [self performSelector:@selector(performComplete) withObject:nil afterDelay:10.0];
    
    
    [self performSelector:@selector(performComplete:) withObject:self.player3_Answer afterDelay:11.0];
    
    [self performSelector:@selector(performComplete) withObject:nil afterDelay:14.0];
    
    
    [self performSelector:@selector(performComplete:) withObject:self.player4_Answer afterDelay:15.0];
    
    [self performSelector:@selector(performComplete) withObject:nil afterDelay:18.0];
    
    
    [self performSelector:@selector(performComplete:) withObject:self.player5_Answer afterDelay:19.0];
    
    [self performSelector:@selector(performComplete) withObject:nil afterDelay:22.0];
    
    
    [self performSelector:@selector(performComplete:) withObject:self.player6_Answer afterDelay:23.0];
    
    [self performSelector:@selector(performComplete) withObject:nil afterDelay:26.0];
    
    
    [self performSelector:@selector(performComplete:) withObject:self.player7_Answer afterDelay:27.0];
    
    [self performSelector:@selector(performComplete) withObject:nil afterDelay:30.0];


    
    if(self.quizRound == 1){
        
        //player1から順に発表

        
        
    } else if(self.quizRound == 2){
        
    } else if(self.quizRound == 3){
        
    } else if(self.quizRound == 4){
        
    } else if(self.quizRound == 5){
        
    } else if(self.quizRound == 6){
        
    } else if(self.quizRound == 7){
        
    }
    
    
}

-(void)moveTest
{
    
}

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches]anyObject];
    //    [self moveTest];
    
    //回答発表メソッドを実行
    //    [self announceScore];
    
}

- (IBAction)resultButton:(id)sender
{

    int player1Lank = [self scoringFromDistancePlus:averageScoreDistance_player1 score:self.player1_Answer];
    int player2Lank = [self scoringFromDistancePlus:averageScoreDistance_player2 score:self.player2_Answer];
    int player3Lank = [self scoringFromDistancePlus:averageScoreDistance_player3 score:self.player3_Answer];
    int player4Lank = [self scoringFromDistancePlus:averageScoreDistance_player4 score:self.player4_Answer];
    int player5Lank = [self scoringFromDistancePlus:averageScoreDistance_player5 score:self.player5_Answer];
    int player6Lank = [self scoringFromDistancePlus:averageScoreDistance_player6 score:self.player6_Answer];
    int player7Lank = [self scoringFromDistancePlus:averageScoreDistance_player7 score:self.player7_Answer];
    
    NSLog(@"%d,%d,%d,%d,%d,%d,%d", player1Lank, player2Lank, player3Lank, player4Lank, player5Lank, player6Lank, player7Lank);
    
    self.player1_totalScore = [self scoreingPlusMinus:player1Lank totalScore:self.player1_totalScore];
        self.player2_totalScore = [self scoreingPlusMinus:player2Lank totalScore:self.player2_totalScore];
        self.player3_totalScore = [self scoreingPlusMinus:player3Lank totalScore:self.player3_totalScore];
        self.player4_totalScore = [self scoreingPlusMinus:player4Lank totalScore:self.player4_totalScore];
        self.player5_totalScore = [self scoreingPlusMinus:player5Lank totalScore:self.player5_totalScore];
        self.player6_totalScore = [self scoreingPlusMinus:player6Lank totalScore:self.player6_totalScore];
        self.player7_totalScore = [self scoreingPlusMinus:player7Lank totalScore:self.player7_totalScore];
    
    NSString *totalScoreGameEnd;
    totalScoreGameEnd= [[NSString alloc]initWithFormat:@"%@点",self.player1_totalScore];
    totalScore1.text = totalScoreGameEnd;
    totalScoreGameEnd= [[NSString alloc]initWithFormat:@"%@点",self.player2_totalScore];
    totalScore2.text = totalScoreGameEnd;
    totalScoreGameEnd= [[NSString alloc]initWithFormat:@"%@点",self.player3_totalScore];
    totalScore3.text = totalScoreGameEnd;
    totalScoreGameEnd= [[NSString alloc]initWithFormat:@"%@点",self.player4_totalScore];
    totalScore4.text = totalScoreGameEnd;
    totalScoreGameEnd= [[NSString alloc]initWithFormat:@"%@点",self.player5_totalScore];
    totalScore5.text = totalScoreGameEnd;
    totalScoreGameEnd= [[NSString alloc]initWithFormat:@"%@点",self.player6_totalScore];
    totalScore6.text = totalScoreGameEnd;
    totalScoreGameEnd= [[NSString alloc]initWithFormat:@"%@点",self.player7_totalScore];
    totalScore7.text = totalScoreGameEnd;
    
    self.quizRound = self.quizRound + 1;
    
    //一度押したら、ボタンを押せなくする
    resultButton.enabled = NO;
}

//距離から、各々の順位を決めるメソッド
-(int)scoringFromDistancePlus:(NSString*)distance score:(NSNumber*)score
{
    BOOL minusScore =[distance hasPrefix:@"6位"];
    if (minusScore == YES){
        return 6;
    }
    
    //中央値と同じなら１位、最大値と最小値と同じなら同率４位、それ以外は同率２位
    if(score == centerScore){
        return 1;
    } else if ((score == minScore_plusGroup)||(score == minScore_plusGroup)){
        return 4;
    } else {
        return 2;
    }
    
}


//最終的な得点を加算減算するメソッド
-(NSNumber*)scoreingPlusMinus:(int)playerRank totalScore:(NSNumber*)totalScore
{
    int totalScoreInt = [totalScore intValue];
    
    if(playerRank == 1){
        totalScoreInt = totalScoreInt + 100;
    } else if(playerRank == 2){
                totalScoreInt = totalScoreInt + 50;
    } else if(playerRank == 4){
        totalScoreInt = totalScoreInt + 20;
    } else if(playerRank == 6){
        totalScoreInt = totalScoreInt - 100;
    }
    
    NSNumber *num = [NSNumber numberWithInt:totalScoreInt];
    return num;
    
}

//平均値からの距離を算出するメソッド
-(NSString*)scoringRule:(int)average min:(int)min max:(int)max score:(int)score
{
    NSString *averageScoreDistanceStr;
    int averageScoreDistance;
    
    //最小値プレイヤーですか？
    if(min == score){
        
        averageScoreDistanceStr =[[NSString alloc]initWithFormat:@"6位"];
        
        //最大値プレイヤーですか？
    } else if(max == score){
        
        averageScoreDistanceStr =[[NSString alloc]initWithFormat:@"6位"];
        
        //それ以外の場合は、平均値からの近さを算出してreturnするよ
    } else {
        
        if(average < score){
            averageScoreDistance =  score - average ;
            
        } else if( average >=  score){
            averageScoreDistance =  average - score ;
            
        }
        averageScoreDistanceStr = [[NSString alloc]initWithFormat:@"%d",averageScoreDistance];
        
    }
    return averageScoreDistanceStr;
}

//ディレイ処理
-(void)performComplete:(NSNumber*)score
{
    NSString* scoreText = [[NSString alloc] initWithFormat:@"%@",score];

    
    scoreAnnounceView.hidden=NO;;
    gakubuti.hidden=NO;
    scoreAnnounceLabel.hidden=NO;
    scoreAnnounceLabel.text = scoreText;
    
    NSLog(@"scoreは%@だよー",scoreAnnounceLabel.text);

    
}

//一瞬ラベルを隠す
-(void)performComplete
{
    scoreAnnounceView.hidden=YES;
    gakubuti.hidden=YES;
    scoreAnnounceLabel.hidden=YES;
}

- (IBAction)nextQuestion:(id)sender
{
}

//画面遷移する際に、パラメーターを渡す
-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    QuestionScreenView *qsv2 = (QuestionScreenView*)[segue destinationViewController];
    
    if([segue.identifier isEqualToString:@"nextQuestion"]){
        
        qsv2.player1_name = nameLabel1.text;
        qsv2.player1_gender = gender1.text;
        qsv2.player1_age = age1.text;
        qsv2.player1_avatar = avatar1;
        qsv2.player2_name = nameLabel2.text;
        qsv2.player2_gender = gender2.text;
        qsv2.player2_age = age2.text;
        qsv2.player2_avatar = avatar2;
        qsv2.player3_name = nameLabel3.text;
        qsv2.player3_gender = gender3.text;
        qsv2.player3_age = age3.text;
        qsv2.player3_avatar = avatar3;
        qsv2.player4_name = nameLabel4.text;
        qsv2.player4_gender = gender4.text;
        qsv2.player4_age = age4.text;
        qsv2.player4_avatar = avatar4;
        qsv2.player5_name = nameLabel5.text;
        qsv2.player5_gender = gender5.text;
        qsv2.player5_age = age5.text;
        qsv2.player5_avatar = avatar5;
        qsv2.player6_name = nameLabel6.text;
        qsv2.player6_gender = gender6.text;
        qsv2.player6_age = age6.text;
        qsv2.player6_avatar = avatar6;
        qsv2.player7_name = nameLabel7.text;
        qsv2.player7_gender = gender7.text;
        qsv2.player7_age = age7.text;
        qsv2.player7_avatar = avatar7;
        
        qsv2.player1_ID = self.player1_ID;
                qsv2.player2_ID = self.player2_ID;
                qsv2.player3_ID = self.player3_ID;
                qsv2.player4_ID = self.player4_ID;
                qsv2.player5_ID = self.player5_ID;
                qsv2.player6_ID = self.player6_ID;
                qsv2.player7_ID = self.player7_ID;
        
        
        qsv2.player1_totalScore = self.player1_totalScore;
        qsv2.player2_totalScore = self.player2_totalScore;
        qsv2.player3_totalScore = self.player3_totalScore;
        qsv2.player4_totalScore = self.player4_totalScore;
        qsv2.player5_totalScore = self.player5_totalScore;
        qsv2.player6_totalScore = self.player6_totalScore;
        qsv2.player7_totalScore = self.player7_totalScore;
        
        qsv2.aloneMode = self.aloneMode;
        qsv2.questionNumber = self.quizRound;
        qsv2.selfName = nameLabel1.text;
        
        if(self.player1 == YES){
            qsv2.player1 = YES;
        } else if(self.player2 == YES){
            qsv2.player2 = YES;
        } else if(self.player3 == YES){
            qsv2.player3 = YES;
        } else if(self.player4 == YES){
            qsv2.player4 = YES;
        } else if(self.player5 == YES){
            qsv2.player5 = YES;
        } else if(self.player6 == YES){
            qsv2.player6 = YES;
        } else if(self.player7 == YES){
            qsv2.player7 = YES;
        }
        
        
    } else {
        NSLog(@"segueの名前が間違ってるんじゃない？");
    }
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.player stop];
    [self.voicePlayer stop];
}
/* ★☆★やること
 ・誰から発表？
 ・○○さんの回答は・・・
 ・表示！
 ・player○●さんの回答を
 
 
 CGRect *point1 = CGRectMake(41,167,77,188);
 CGRect *point2 = CGRectMake(125,167,77,188);
 CGRect *point3 = CGRectMake(212,167,77,188);
 CGRect *point4 = CGRectMake(292,167,77,188);
 CGRect *point5 = CGRectMake(382,167,77,188);
 CGRect *point6 = CGRectMake(464,167,77,188);
 CGRect *point7 = CGRectMake(548,167,77,188);
 
 
 距離を取得したら、それをNSArrayに格納して比較
 中央値、最小値、最大値を取得して、それぞれの数値と＝のデータを持つプレイヤーを
 ５位、４位、
 
 
 ★☆★ */



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
