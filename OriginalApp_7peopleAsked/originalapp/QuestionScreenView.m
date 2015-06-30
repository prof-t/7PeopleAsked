//
//  QuestionScreenView.m
//  OriginalApp(卒業制作)
//
//  Created by 平山亮 on 2015/02/24.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import "QuestionScreenView.h"
#define TIME_TO_MEASURE 60

@interface QuestionScreenView ()

@end


@implementation QuestionScreenView
{
    
    __weak IBOutlet UILabel *name1;
    __weak IBOutlet UILabel *name2;
    __weak IBOutlet UILabel *name3;
    __weak IBOutlet UILabel *name4;
    __weak IBOutlet UILabel *name5;
    __weak IBOutlet UILabel *name6;
    __weak IBOutlet UILabel *name7;
    
    __weak IBOutlet UILabel *gender1;
    __weak IBOutlet UILabel *gender2;
    __weak IBOutlet UILabel *gender3;
    __weak IBOutlet UILabel *gender4;
    __weak IBOutlet UILabel *gender5;
    __weak IBOutlet UILabel *gender6;
    __weak IBOutlet UILabel *gender7;
    
    __weak IBOutlet UILabel *age1;
    __weak IBOutlet UILabel *age2;
    __weak IBOutlet UILabel *age3;
    __weak IBOutlet UILabel *age4;
    __weak IBOutlet UILabel *age5;
    __weak IBOutlet UILabel *age6;
    __weak IBOutlet UILabel *age7;
    
    NSString *avatar1;
    NSString *avatar2;
    NSString *avatar3;
    NSString *avatar4;
    NSString *avatar5;
    NSString *avatar6;
    NSString *avatar7;
    
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
    
    __weak IBOutlet UILabel *titleOfHonor1;
    __weak IBOutlet UILabel *titleOfHonor2;
    __weak IBOutlet UILabel *titleOfHonor3;
    __weak IBOutlet UILabel *titleOfHonor4;
    __weak IBOutlet UILabel *titleOfHonor5;
    __weak IBOutlet UILabel *titleOfHonor6;
    __weak IBOutlet UILabel *titleOfHonor7;
    
    __weak IBOutlet UILabel *questionLabel1;
    __weak IBOutlet UILabel *questionLabel2;
    __weak IBOutlet UILabel *questionLabel3;
    __weak IBOutlet UILabel *decideQuestionLabel;
    __weak IBOutlet UILabel *questionTitleLabel;
    __weak IBOutlet UILabel *questionTitleNumber;
    __weak IBOutlet UIImageView *questionImage;
    __weak IBOutlet UILabel *timeLabel;
    
    __weak IBOutlet UITextField *answerField;
    __weak IBOutlet UILabel *questionUnitLabel;
    __weak IBOutlet UIButton *deceiveButton;
    __weak IBOutlet UILabel *pleaseSelectPlayerLabel;
    __weak IBOutlet UILabel *nowQuestionPlayer;
    __weak IBOutlet UIImageView *QuestionImageView;
    __weak IBOutlet UILabel *firstRuleLabel;
    __weak IBOutlet UILabel *secondRuleLabel;
    
    
    BOOL player1answerCompleted;
    BOOL player2answerCompleted;
    BOOL player3answerCompleted;
    BOOL player4answerCompleted;
    BOOL player5answerCompleted;
    BOOL player6answerCompleted;
    BOOL player7answerCompleted;
    
    int player1_Answer;
    int player2_Answer;
    int player3_Answer;
    int player4_Answer;
    int player5_Answer;
    int player6_Answer;
    int player7_Answer;
    
    int startPlayer;
    int quizRound;
    
    FMDatabase *db;
    
    //タイマー用変数
    NSTimer *_timer;
    float timeCount;
    float secondsOfTimer;
    NSDate *timeInFuture;
    NSString *timeStr;
    
    int questionData;
    NSMutableArray *randomIDArray;
    
    int q_idFromDatabase;
    NSString *q_textFromDatabase;
    NSString *q_unitFromDatabase;
    BOOL q_playerFromDatabase;
    NSString *q_imageFromDatabase;
    NSString *q_genreFromDatabase;
    
    BOOL q_playerFromDatabase_q1;
    BOOL q_playerFromDatabase_q2;
    BOOL q_playerFromDatabase_q3;
    BOOL selected_q_playerFromDatabase;
    NSString *selected_q_player_str;
    
    int questionCandidate1ID;
    int questionCandidate2ID;
    int questionCandidate3ID;
    int selected_questionID;
    
    NSString* q_unitFromDatabase_q1;
    NSString* q_unitFromDatabase_q2;
    NSString* q_unitFromDatabase_q3;
    NSString* selected_q_unitFromDatabase;
    
    NSString* q_imageFromDatabase_q1;
    NSString* q_imageFromDatabase_q2;
    NSString* q_imageFromDatabase_q3;
    NSString* selected_q_imageFromDatabase;
    
        CharacterStatus *characterStatus;
    
    
    BOOL labelTouchYESorNO;
    
    NSString *voiceStr;
    
    CGRect bigImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    voiceStr = @"questionView1" ;
    
    NSURL *voiceURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:voiceStr ofType:@"wav"]];
    _voicePlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:voiceURL error:nil];
    self.player.numberOfLoops =  0;
    [self.voicePlayer play];
    
    NSURL *bgmURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"KOF99" ofType:@"mp3"] ];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:bgmURL error:nil];
    self.player.numberOfLoops = -1;
    [self.player play];

    bigImage = CGRectMake(11,15,300,300);
    
    name1.text=self.player1_name;
    name2.text=self.player2_name;
    name3.text=self.player3_name;
    name4.text=self.player4_name;
    name5.text=self.player5_name;
    name6.text=self.player6_name;
    name7.text=self.player7_name;
    
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
    
    avatarView1.image = [UIImage imageNamed:avatar1];
    avatarView2.image = [UIImage imageNamed:avatar2];
    avatarView3.image = [UIImage imageNamed:avatar3];
    avatarView4.image = [UIImage imageNamed:avatar4];
    avatarView5.image = [UIImage imageNamed:avatar5];
    avatarView6.image = [UIImage imageNamed:avatar6];
    avatarView7.image = [UIImage imageNamed:avatar7];
    
    NSString *questionNumberStr = [[NSString alloc]initWithFormat:@"%d",self.questionNumber];
    questionTitleNumber.text = questionNumberStr;
    
    //得点の初期化
    if(self.player1_totalScore == nil){
        totalScore1.text=@"0点";
        totalScore2.text=@"0点";
        totalScore3.text=@"0点";
        totalScore4.text=@"0点";
        totalScore5.text=@"0点";
        totalScore6.text=@"0点";
        totalScore7.text=@"0点";
        self.player1_totalScore = [NSNumber numberWithInt:0];
        self.player2_totalScore = [NSNumber numberWithInt:0];
        self.player3_totalScore = [NSNumber numberWithInt:0];
        self.player4_totalScore = [NSNumber numberWithInt:0];
        self.player5_totalScore = [NSNumber numberWithInt:0];
        self.player6_totalScore = [NSNumber numberWithInt:0];
        self.player7_totalScore = [NSNumber numberWithInt:0];
        
    } else {
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
    }
    
    ///ラベルの角丸
    [self makeRadius_label:questionLabel1];
    [self makeRadius_label:questionLabel2];
    [self makeRadius_label:questionLabel3];
    [self makeRadius_label:decideQuestionLabel];
    [self makeRadius_label:firstRuleLabel];
    [self makeRadius_label:secondRuleLabel];
    
    QuestionImageView.userInteractionEnabled = YES;
    questionLabel1.userInteractionEnabled = NO;
    questionLabel2.userInteractionEnabled = NO;
    questionLabel3.userInteractionEnabled = NO;
    
    answerField.hidden = YES;
    questionUnitLabel.hidden = YES;
    deceiveButton.hidden = YES;
    
    questionData = 21 -(self.questionNumber*3)-1; //←要素０も数に含めるため、総人数-1しておく
    randomIDArray = [NSMutableArray arrayWithObjects:@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@21,nil];
    
    //皆の回答状況を初期化する
    [self playerAnswerConmpleted];
    
    //周回数を確認する
    if(quizRound == 0){
        quizRound = 1;
    }
    NSLog(@"このラウンドの周回数は%d",quizRound);
    
    //ユーザーのティフィケーションの許可を得る
    if( [[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
        
        //ピアIDの設定
        _myPeerID = [[MCPeerID alloc]initWithDisplayName:self.selfName];
        
        //セッションの生成
        _session = [[MCSession alloc]initWithPeer:_myPeerID];
        _session.delegate = self;
        
        
        //ディレイ処理を行い、２秒経ったらラベルを消す
        firstRuleLabel.hidden = NO;
        secondRuleLabel.hidden = YES;
        [self performSelector:@selector(performComplete:) withObject:firstRuleLabel afterDelay:3.0];
    }
    
    //DB関連
    NSString *databaseName = @"7peopleAsked.db";
    NSString *workPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *databasePath = [workPath stringByAppendingPathComponent:databaseName];
    NSFileManager *manager = [NSFileManager defaultManager];
    if(![manager fileExistsAtPath:databasePath]){
        NSError *error = nil;
        // 文書フォルダが存在しない場合は、データベースの複製元をリソースから取得する
        NSString *templatePath = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:databaseName];
        // リソースから取得したデータベースファイルを文書フォルダにコピーします
        // リソースにあるファイルにはデータの書き込みができないためこのファイルをそのまま使うとデータの追加が行えません
        if(![manager copyItemAtPath:templatePath toPath:databasePath error:&error]){
            // データベースファイルのコピーに失敗したときの処理
            NSLog(@"コピー失敗しました");
        }
    }
    NSLog(@"データベースファイルのありか%@", databasePath);
    db = [FMDatabase databaseWithPath:databasePath];
    
    NSLog(@"aloneModeは%d",self.aloneMode);
    NSLog(@"player1は%d",self.player1);
    
    NSLog(@"player1ID %d",self.player1_ID);
    NSLog(@"player2ID %d",self.player2_ID);
    NSLog(@"player3ID %d",self.player3_ID);
    NSLog(@"player4ID %d",self.player4_ID);
    NSLog(@"player5ID %d",self.player5_ID);
    NSLog(@"player6ID %d",self.player6_ID);
    NSLog(@"player7ID %d",self.player7_ID);
    
    //もしhostplayerかalonModeならquestionStart！！
    if ((self.hostPlayer == YES)||(self.aloneMode==YES)){
        [self questionStart];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//問題文生成メソッド
-(void)questionFromDatabase
{
    //ランダムIDを生成し、そのIDをarrayから取り出した後に、使用済みとしてarrayからの削除を行う
    int randomID = (arc4random() % questionData) ;
    NSLog(@"今回のランダムIDは%d",randomID);
    NSString *questionID = [randomIDArray objectAtIndex:randomID];
    [randomIDArray removeObject:questionID];
    NSLog(@"今回選ばれたquestionIDは%@",questionID);
    //questionData要素を削除したので、その分総数から-1する
    questionData = questionData - 1 ;
    
    [db open];
    
    //取り出すためのセレクト文（ランダム処理対応）
    NSString *selectRandomQuestion = [[NSString alloc]initWithFormat:@"select q_id,q_text,q_unit,q_player,q_image,q_genre from question where q_id = %@",questionID];
    FMResultSet *result = [db executeQuery:selectRandomQuestion];
    
    while([result next]){
        //名前の取得
        q_idFromDatabase=[result intForColumnIndex:0];
        q_textFromDatabase= [result stringForColumnIndex:1];
        q_unitFromDatabase=[result stringForColumnIndex:2];
        q_playerFromDatabase=[result boolForColumnIndex:3];
        q_imageFromDatabase= [result stringForColumnIndex:4];
        q_genreFromDatabase=[result stringForColumnIndex:5];
        
        NSLog(@"DBから取り出した問題文は%@",q_textFromDatabase);
        NSLog(@"DBから取り出した単位は%@",q_unitFromDatabase);
        NSLog(@"DBから取り出したプレイヤー問題？は%d",q_playerFromDatabase);
        NSLog(@"DBから取り出したimageは%@",q_imageFromDatabase);
        NSLog(@"DBから取り出したジャンルは%@",q_genreFromDatabase);
    }
    [db close];
}


-(void)questionStart
{
    /* ★☆★hostplayerは開幕操作→問題文を３問生成、labelに表示する。その際、DBから取り出した各種データも専用の変数に保存する★☆★ */
    if ((self.hostPlayer == YES)||(self.aloneMode==YES)){
        
        timeCount=30;
        [self timerStart];
        
        [self questionFromDatabase];
        questionLabel1.text = q_textFromDatabase;
        q_playerFromDatabase_q1 = q_playerFromDatabase;
        questionCandidate1ID = q_idFromDatabase;
        q_unitFromDatabase_q1 = q_unitFromDatabase;
        q_imageFromDatabase_q1 = q_imageFromDatabase;
        
        [self questionFromDatabase];
        questionLabel2.text = q_textFromDatabase;
        q_playerFromDatabase_q2= q_playerFromDatabase;
        questionCandidate2ID = q_idFromDatabase;
        q_unitFromDatabase_q2 = q_unitFromDatabase;
        q_imageFromDatabase_q2 = q_imageFromDatabase;
        
        [self questionFromDatabase];
        questionLabel3.text = q_textFromDatabase;
        q_playerFromDatabase_q3 = q_playerFromDatabase;
        questionCandidate3ID = q_idFromDatabase;
        q_unitFromDatabase_q3 = q_unitFromDatabase;
        q_imageFromDatabase_q3 = q_imageFromDatabase;
        
        //labelのタッチイベントを許可
        questionLabel1.userInteractionEnabled = YES;
        questionLabel2.userInteractionEnabled = YES;
        questionLabel3.userInteractionEnabled = YES;
        
        /* ★☆★
         もし親だったら他プレイヤーに問題を通知する
         ★☆★ */
        
        
    } else if(_hostPlayer == NO){
        
        /* ★☆★
         
         親じゃなかったら
         　　　「親が問題選んでますよ」告知ラベル
         
         問題スタート
         　　　問題文を表示
         　　　回答フィールドを表示
         　　　単位ラベルを表示
         　　　タイマー起動
         
         入力終わったら
         　　　タイマーストップ
         answerCompletedをイエスに
         　　　キャラに回答完了マーク
         　　　（aloneModeの時は、自動的に完了）
         
         
         ★☆★ */
    }
}

-(void)timerStart
{
    if(_timer==nil){
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.1
                                                target:self selector:@selector(timerMetod:) userInfo:nil repeats:YES];
    }else{
        
    }
}

-(void)timerMetod:(NSTimer*)timer
{
    if(timeCount <= 0.0){
        [_timer invalidate];
        timeLabel.text = @"00";
        _timer=nil;
    } else if(timeCount > 0){
        
        timeCount = timeCount - 0.1;
        timeLabel.text = [[NSString alloc]initWithFormat:@"%.1f",timeCount];
    }
    
    //    NSLog(@"%f",timeCount);
}

-(void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch *touch = [[event allTouches]anyObject];
    
    if(touch.view.tag == 100){
        CGRect smallImage = CGRectMake(11,15,142,133);
        QuestionImageView.frame = smallImage;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches]anyObject];

    if(touch.view.tag == 100){
        
        NSLog(@"questionImageをタッチしたよ");
        

        QuestionImageView.frame=bigImage;
        QuestionImageView.contentMode = UIViewContentModeScaleAspectFit;
    }

    
}

//labelタッチイベント
-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches]anyObject];
    
    
    //問題選択ラベルのタッチイベント
    if(touch.view.tag == 10){
        selected_questionID = questionCandidate1ID;
        selected_q_playerFromDatabase = q_playerFromDatabase_q1;
        selected_q_unitFromDatabase = q_unitFromDatabase_q1;
        selected_q_imageFromDatabase = q_imageFromDatabase_q1;
        [self clickCommand:questionLabel1];
    } else if (touch.view.tag == 11){
        selected_questionID = questionCandidate2ID;
        selected_q_playerFromDatabase = q_playerFromDatabase_q2;
        selected_q_unitFromDatabase = q_unitFromDatabase_q2;
        selected_q_imageFromDatabase = q_imageFromDatabase_q2;
        [self clickCommand:questionLabel2];
    } else if (touch.view.tag == 12){
        selected_questionID = questionCandidate3ID;
        selected_q_playerFromDatabase = q_playerFromDatabase_q3;
        selected_q_unitFromDatabase = q_unitFromDatabase_q3;
        selected_q_imageFromDatabase = q_imageFromDatabase_q3;
        [self clickCommand:questionLabel3];
    }
    
    //    NSLog(@"選ばれたlabelのq_IDは%d",selected_questionID);
    //    NSLog(@"playerYESNOは%d",selected_q_playerFromDatabase);
    
    //もし、player選択問題がYESだったら
    if(selected_q_playerFromDatabase==YES){
        
        if(touch.view.tag==20){
            [self clickPlayerImage:avatarView1 name:name1.text];
        } else if(touch.view.tag==21){
            [self clickPlayerImage:avatarView2 name:name2.text];
        } else if(touch.view.tag==22){
            [self clickPlayerImage:avatarView3 name:name3.text];
        } else if(touch.view.tag==23){
            [self clickPlayerImage:avatarView4 name:name4.text];
        } else if(touch.view.tag==24){
            [self clickPlayerImage:avatarView5 name:name5.text];
        } else if(touch.view.tag==25){
            [self clickPlayerImage:avatarView6 name:name6.text];
        } else if(touch.view.tag==26){
            [self clickPlayerImage:avatarView7 name:name7.text];
        }
        
    }else{
        NSLog(@"今、画像をタッチしても何も起こらないよ");
    }
    
    //タッチしたらキーボード閉じる
    [answerField resignFirstResponder];
    
}

//labelタッチイベントの中身
-(IBAction)clickCommand:(UILabel*)label
{
    labelTouchYESorNO = YES;
    NSLog(@"labelのテキストは%@",label.text);
    CGRect rect = CGRectInset(label.frame,5,5);
    label.frame = rect;
    decideQuestionLabel.text = label.text;
    
    //タイマーの停止
    [_timer invalidate];
    timeLabel.text = @"00";
    _timer=nil;
    
    questionLabel1.userInteractionEnabled = NO;
    questionLabel2.userInteractionEnabled = NO;
    questionLabel3.userInteractionEnabled = NO;
    
    //もしplayerYESNO問題がYESであれば、「画像を選んでください」labelを表示する
    if(selected_q_playerFromDatabase == YES){
        
        NSURL *voiceURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"questionView3" ofType:@"wav"]];
        _voicePlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:voiceURL error:nil];
        self.player.numberOfLoops =  0;
        [self.voicePlayer play];
        
        pleaseSelectPlayerLabel.hidden=NO;
        NSLog(@"player問題はYESだよ");
        avatarView1.userInteractionEnabled = YES;
        avatarView2.userInteractionEnabled = YES;
        avatarView3.userInteractionEnabled = YES;
        avatarView4.userInteractionEnabled = YES;
        avatarView5.userInteractionEnabled = YES;
        avatarView6.userInteractionEnabled = YES;
        avatarView7.userInteractionEnabled = YES;
        

        
    }
    
    //次の問題表示メソッドへ移行
    [self selectedQuestionShow];
    
}

//問題文の○○さんを決めるメソッド
-(IBAction)clickPlayerImage:(UIImageView*)imageView name:(NSString*)name
{
    
    NSString* nowPlayerStr= [[NSString alloc]initWithFormat:@"問題文の○○さんは、「%@」さんです",name];
    NSLog(@"%@",nowPlayerStr);
    nowQuestionPlayer.text = nowPlayerStr;
    
    //選ばれたら、選んでくださいラベルは非表示に
    pleaseSelectPlayerLabel.hidden = YES;
    
    //imageViewのタッチイベントも、以降発生しないように設定
    avatarView1.userInteractionEnabled = NO;
    avatarView2.userInteractionEnabled = NO;
    avatarView3.userInteractionEnabled = NO;
    avatarView4.userInteractionEnabled = NO;
    avatarView5.userInteractionEnabled = NO;
    avatarView6.userInteractionEnabled = NO;
    avatarView7.userInteractionEnabled = NO;
}

//問題表示メソッド
-(void)selectedQuestionShow
{
    /* ★☆★ホストなら、全員に問題文を通知する★☆★ */
    if(_hostPlayer == YES){
        
//        [self sendQuestionData];
        
    }
    
    NSURL *voiceURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"questionView2" ofType:@"wav"]];
    _voicePlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:voiceURL error:nil];
    self.player.numberOfLoops =  0;
    [self.voicePlayer play];
    secondRuleLabel.hidden = NO;
    [self performSelector:@selector(performComplete:) withObject:secondRuleLabel afterDelay:2.0];
    
    
    //問題選択ラベルを非表示にし、
    questionLabel1.hidden = YES;
    questionLabel2.hidden = YES;
    questionLabel3.hidden = YES;
    
    //ヴォイスコマンド発動！！
    [self questionTextVoice:selected_questionID];
    
    
    if(selected_q_playerFromDatabase == YES)
    {
        nowQuestionPlayer.hidden =NO;
    }
    
    if(![selected_q_imageFromDatabase isEqualToString:@"no"]){
        QuestionImageView.image = [UIImage imageNamed:selected_q_imageFromDatabase];
        QuestionImageView.hidden = NO;
        
    }
    
    timeCount=60;
    [self timerStart];
    
    //各種出題メソッドを出す
    answerField.hidden = NO;
    questionUnitLabel.hidden = NO;
    questionUnitLabel.text = selected_q_unitFromDatabase;
    deceiveButton.hidden = NO;
    

    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)decieveButton:(id)sender
{
    [self otherPlayerAnswer];
    
    //自分の回答済み変数をYESにする（自分がplayerいくつかによって分岐）
    if((self.player1 == YES)||(self.aloneMode==YES)){
        player1answerCompleted = YES;
    } else if(self.player2 == YES){
        player2answerCompleted = YES;
    } else if(self.player3 == YES){
        player3answerCompleted = YES;
    } else if(self.player4 == YES){
        player4answerCompleted = YES;
    } else if(self.player5 == YES){
        player5answerCompleted = YES;
    } else if(self.player6 == YES){
        player6answerCompleted = YES;
    } else if(self.player7 == YES){
        player7answerCompleted = YES;
    }
    
    //回答を変数に記憶する
    if(self.player1 == YES){
        player1_Answer = [answerField.text intValue];
    } else if (self.player2 == YES){
        player2_Answer = [answerField.text intValue];
    } else if (self.player3 == YES){
        player3_Answer = [answerField.text intValue];
    } else if (self.player4 == YES){
        player4_Answer = [answerField.text intValue];
    } else if (self.player5 == YES){
        player5_Answer = [answerField.text intValue];
    } else if (self.player6 == YES){
        player6_Answer = [answerField.text intValue];
    } else if (self.player7 == YES){
        player7_Answer = [answerField.text intValue];
        
    }
    
    NSLog(@"回答は%dですね？",(int)player1_Answer);
    
}

//segueの条件を指定
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
    if([identifier isEqualToString:@"answerScreen"]){
        
        if(player1answerCompleted == NO || player2answerCompleted == NO ||player3answerCompleted == NO || player4answerCompleted == NO || player5answerCompleted == NO || player6answerCompleted == NO || player7answerCompleted == NO ){
            NSLog(@"segueの判定したけどNOだったよ");
            return NO;
        }
    }else {
        
    }
    NSLog(@"segueの判定したらYESだね");
    [NSThread sleepForTimeInterval:0.5];
    return YES;
}

//画面遷移する際に、パラメーターを渡す
-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    AnswerScreenView *asv = (AnswerScreenView*)[segue destinationViewController];
    
    if([segue.identifier isEqualToString:@"answerScreen"]){
        
        asv.player1_name = name1.text;
        asv.player1_gender = gender1.text;
        asv.player1_age = age1.text;
        asv.player1_avatar = avatar1;
        asv.player2_name = name2.text;
        asv.player2_gender = gender2.text;
        asv.player2_age = age2.text;
        asv.player2_avatar = avatar2;
        asv.player3_name = name3.text;
        asv.player3_gender = gender3.text;
        asv.player3_age = age3.text;
        asv.player3_avatar = avatar3;
        asv.player4_name = name4.text;
        asv.player4_gender = gender4.text;
        asv.player4_age = age4.text;
        asv.player4_avatar = avatar4;
        asv.player5_name = name5.text;
        asv.player5_gender = gender5.text;
        asv.player5_age = age5.text;
        asv.player5_avatar = avatar5;
        asv.player6_name = name6.text;
        asv.player6_gender = gender6.text;
        asv.player6_age = age6.text;
        asv.player6_avatar = avatar6;
        asv.player7_name = name7.text;
        asv.player7_gender = gender7.text;
        asv.player7_age = age7.text;
        asv.player7_avatar = avatar7;
        
        asv.player1_Answer = [NSNumber numberWithInt:player1_Answer];
        asv.player2_Answer = [NSNumber numberWithInt:player2_Answer];
        asv.player3_Answer = [NSNumber numberWithInt:player3_Answer];
        asv.player4_Answer = [NSNumber numberWithInt:player4_Answer];
        asv.player5_Answer = [NSNumber numberWithInt:player5_Answer];
        asv.player6_Answer = [NSNumber numberWithInt:player6_Answer];
        asv.player7_Answer = [NSNumber numberWithInt:player7_Answer];
        
        asv.player1_totalScore = self.player1_totalScore;
        asv.player2_totalScore = self.player2_totalScore;
        asv.player3_totalScore = self.player3_totalScore;
        asv.player4_totalScore = self.player4_totalScore;
        asv.player5_totalScore = self.player5_totalScore;
        asv.player6_totalScore = self.player6_totalScore;
        asv.player7_totalScore = self.player7_totalScore;
        
        asv.player1_ID = self.player1_ID;
                asv.player2_ID = self.player2_ID;
                asv.player3_ID = self.player3_ID;
                asv.player4_ID = self.player4_ID;
                asv.player5_ID = self.player5_ID;
                asv.player6_ID = self.player6_ID;
                asv.player7_ID = self.player7_ID;
        
        asv.aloneMode = self.aloneMode;
        asv.quizRound = quizRound;
        
        if(self.player1 == YES){
            asv.player1 = YES;
        } else if(self.player2 == YES){
            asv.player2 = YES;
        } else if(self.player3 == YES){
            asv.player3 = YES;
        } else if(self.player4 == YES){
            asv.player4 = YES;
        } else if(self.player5 == YES){
            asv.player5 = YES;
        } else if(self.player6 == YES){
            asv.player6 = YES;
        } else if(self.player7 == YES){
            asv.player7 = YES;
        }
        
        
    } else {
        NSLog(@"segueの名前が間違ってるんじゃない？");
    }
    
}


//回答状況初期化メソッド
-(void)playerAnswerConmpleted
{
    if(self.aloneMode==YES){
        player1answerCompleted=NO;
        player2answerCompleted=YES;
        player3answerCompleted=YES;
        player4answerCompleted=YES;
        player5answerCompleted=YES;
        player6answerCompleted=YES;
        player7answerCompleted=YES;
    } else {
        player1answerCompleted=NO;
        player2answerCompleted=NO;
        player3answerCompleted=NO;
        player4answerCompleted=NO;
        player5answerCompleted=NO;
        player6answerCompleted=NO;
        player7answerCompleted=NO;
    }
}

//ホストが行う処理として、他者の回答を集めて皆に配る
-(void)otherPlayerAnswer
{
    if(self.aloneMode == YES){
        
        [db open];
        
        NSLog(@"otherPlayerAnswerメソッドに入ったよ");
        NSLog(@"selected_questionIDは%d",selected_questionID);
        
        //取り出すためのセレクト文（ランダム処理対応）
        NSString *selectQuestionID = [[NSString alloc]initWithFormat:@"select score%d,score%d,score%d,score%d,score%d,score%d from question where q_id = %d",self.player2_ID,self.player3_ID,self.player4_ID,self.player5_ID,self.player6_ID,self.player7_ID,selected_questionID];
        FMResultSet *result = [db executeQuery:selectQuestionID];
        
        NSLog(@"%@",selectQuestionID);
        
        while([result next]){
            //名前の取得
            player2_Answer= [result intForColumnIndex:0];
            player3_Answer=[result intForColumnIndex:1];
            player4_Answer=[result intForColumnIndex:2];
            player5_Answer= [result intForColumnIndex:3];
            player6_Answer=[result intForColumnIndex:4];
            player7_Answer=[result intForColumnIndex:5];
            
            NSLog(@"DBから取り出したplayer2の答えは%d",player2_Answer);
            NSLog(@"DBから取り出したplayer3の答えは%d",player3_Answer);
            NSLog(@"DBから取り出したplayer4の答えは%d",player4_Answer);
            NSLog(@"DBから取り出したplayer5の答えは%d",player5_Answer);
            NSLog(@"DBから取り出したplayer6の答えは%d",player6_Answer);
            NSLog(@"DBから取り出したplayer7の答えは%d",player7_Answer);
            
            NSLog(@"更にotherPlayerAnswerメソッドの奥に入ったよ");
        }
        [db close];
        
    } else if(self.aloneMode == NO){
        
    }
    
}

//ディレイ処理
-(void)performComplete:(UILabel*)label
{

    label.hidden = YES;
    NSLog(@"ディレイ処理したよ!");
    

}

//角丸枠線を作るメソッド
-(void)makeRadius_label:(UILabel*)label
{
    [[label layer] setCornerRadius:10.0];
    [label setClipsToBounds:YES];
    
}

//枠線追加メソッド
-(void)makeBorder_label:(UILabel*)label
{
    [[label layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[label layer] setBorderWidth:1.0];
}

/* ★☆★ネットワーク接続関係のメソッド★☆★ */
//文字列のバイト配列変換
//-(NSData*)str2data:(NSString*)str
//{
//    return [str dataUsingEncoding:NSUTF8StringEncoding];
//    
//}
//
////バイト配列の文字列変換
//-(NSString*)data2str:(NSData*)data
//{
//    NSString* test = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"変換したtestの中身は%@",test);
//    return test;
//}
//
//-(void)updateUI
//{
//    
//}
//
//
//// テキストフィールドの更新
//-(void)updateAnswer:(NSString*)text
//{
//    NSLog(@"answerを更新するよ");
//    
//    
//    
//    
//}
//
//
//-(void)session:(MCSession*)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
//{
//    NSLog(@"受け取ったよ");
//    
//    //メッセージの受信
//    [self performSelectorOnMainThread:@selector(updateAnswer:) withObject:[self data2str:data] waitUntilDone:NO];
//    
//    if (_hostPlayer==NO){
//        //ホストプレイヤーじゃなければ、受け取ったデータを解答して、出題メソッドを走らせる
//        NSDictionary *received = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//        NSString *receiveQuestionImage = [received objectForKey:@"image"];
//        NSString *receiveselectedPlayer = [received objectForKey:@"selectedPlayer"];
//        NSString *receiveUnit = [received objectForKey:@"unit"];
//        NSString *receiveQuestionText = [received objectForKey:@"questionText"];
//        BOOL receivePlayerYESorNO = [[received objectForKey:@"playerYESorNO"] boolValue];
//
//        NSLog(@"受け取ったデータは%@,%@,%@,%@,%d",receiveQuestionImage,receiveselectedPlayer,receiveUnit,receiveQuestionText,receivePlayerYESorNO);
//
//
//        
//    }
//    
//    //ホストが何かを受信したら、受信データを解凍して、端末名と比較して一致するplayerのanswerに格納する
//    if(_hostPlayer == YES){
//        NSDictionary *receiveD = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//        NSString *receiveName = [receiveD objectForKey:@"name"];
//        NSNumber *receiveAnswer = [receiveD objectForKey:@"answer"];
//        
//        if([receiveName isEqualToString:self.player2_name]){
//            player2_Answer = [receiveAnswer intValue];
//        }  else if([receiveName isEqualToString:self.player3_name]){
//            player3_Answer = [receiveAnswer intValue];
//        }  else if([receiveName isEqualToString:self.player4_name]){
//            player4_Answer = [receiveAnswer intValue];
//        }  else if([receiveName isEqualToString:self.player5_name]){
//            player5_Answer = [receiveAnswer intValue];
//        }  else if([receiveName isEqualToString:self.player6_name]){
//            player6_Answer = [receiveAnswer intValue];
//        }  else if([receiveName isEqualToString:self.player7_name]){
//            player7_Answer = [receiveAnswer intValue];
//        }
//        
//        
//        
//        
//        
//    }
//}
//
////ファイルリソースの受信開始時に呼ばれる
//-(void)session:(MCSession*)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
//{
//    
//}
//
////ファイルリソースの受信終了時に呼ばれる
//-(void)session:(MCSession*)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error
//{
//    
//}
//
////バイトストリームの接続開始時に呼ばれる
//-(void)session:(MCSession*)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID
//{
//    
//}
//
////接続状態変更時に呼ばれる
//-(void)session:(MCSession*)session peer:(MCPeerID*)peerID didChangeState:(MCSessionState)state
//{
//    //UI状態の更新
//    _state=state;
//    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
//}
//
////ブラウズ終了時に呼ばれる
//-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
//{
//    [_browseViewController dismissViewControllerAnimated:YES completion:nil];
//}
//
////ブラウズキャンセル時に呼ばれる
//-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
//{
//    [_browseViewController dismissViewControllerAnimated:YES completion:nil];
//}
//
//-(void)sendAnswerData
//{
//    NSArray *peerID = [_session connectedPeers];
//    NSError* error = nil;
//    NSDictionary *dicAnswer = [NSDictionary dictionaryWithObjectsAndKeys:
//                             answerField.text,@"answer",
//                             self.selfName,@"name",
//                             nil];
//    NSData *sendStatus = [NSKeyedArchiver archivedDataWithRootObject:dicAnswer];
//    [_session sendData:sendStatus toPeers:peerID withMode:MCSessionSendDataReliable error:&error];
//
//}
//
//-(void)sendQuestionData
//{
//    NSLog(@"送るよ");
//    NSArray *peerID = [_session connectedPeers];
//    NSError* error = nil;
//    
//    NSNumber* selected_q_playerYESorNO = [[NSNumber  alloc]initWithBool:selected_q_playerFromDatabase];
//    
//    NSDictionary *dicQuestion = [NSDictionary dictionaryWithObjectsAndKeys:
//                             selected_q_imageFromDatabase,@"image",
//                             selected_q_player_str,@"selectedPlayer",
//                             selected_q_playerYESorNO,@"playerYESorNO",
//                             selected_q_unitFromDatabase,@"unit",
//                             decideQuestionLabel.text,@"questionText",
//                             nil];
//    
//    NSData *sendStatus = [NSKeyedArchiver archivedDataWithRootObject:dicQuestion];
//    [_session sendData:sendStatus toPeers:peerID withMode:MCSessionSendDataReliable error:&error];
//    
//}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.player stop];
}

-(void)questionTextVoice:(int)ID
{
    NSString* voiceName;
    NSString* voiceName2;
    
    
    if(ID == 1){
        voiceName=@"q1_1";
        voiceName2=@"q1_2";
    } else if(ID == 2){
        voiceName=@"q2_1";
        voiceName2=@"q2_2";
    } else if(ID == 3){
        voiceName=@"q_3";
    } else if(ID == 4){
        voiceName=@"q4_1";
        voiceName2=@"q4_2";
    } else if(ID == 5){
        voiceName=@"q5";
    } else if(ID == 6){
        voiceName=@"q6";
    } else if(ID == 7){
        voiceName=@"q7";
    } else if(ID == 8){
        voiceName=@"q8";
    } else if(ID == 9){
        voiceName=@"q9";
    } else if(ID == 10){
        voiceName=@"q10";
    } else if(ID == 11){
        voiceName=@"q11";
    } else if(ID == 12){
        voiceName=@"q12";
    } else if(ID == 13){
        voiceName=@"q13";
    } else if(ID == 14){
        voiceName=@"q14";
    } else if(ID == 15){
        voiceName=@"q15";
    } else if(ID == 16){
        voiceName=@"q16";
    } else if(ID == 17){
        voiceName=@"q17";
    } else if(ID == 18){
        voiceName=@"q18";
    } else if(ID == 19){
        voiceName=@"q19";
    } else if(ID == 20){
        voiceName=@"q20";
    } else if(ID == 21){
        voiceName=@"q20";
    }

    
    NSURL *voiceURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:voiceName ofType:@"wav"]];
    _voicePlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:voiceURL error:nil];
    self.voicePlayer.numberOfLoops =  0;
    [self.voicePlayer play];
    
        [self performSelector:@selector(performCompleteVoice:) withObject:voiceName2 afterDelay:3.0];
        
}

//ディレイメソッド
-(void)performCompleteVoice:(NSString*)voice
{
    NSURL *voice2URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:voice ofType:@"wav"]];
    _voice2Player = [[AVAudioPlayer alloc]initWithContentsOfURL:voice2URL error:nil];
    self.voicePlayer.numberOfLoops =  0;
    [self.voicePlayer play];

}


    @end