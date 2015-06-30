//
//  ConnectScreenView.m
//  OriginalApp(卒業制作)
//
//  Created by 平山亮 on 2015/02/24.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import "ConnectScreenView.h"


#define BTN_ADVERTIZE 5
#define BTN_BROWSE 6
#define BTN_GAMESTART 7
#define BTN_TITLE 8
#define BTN_RULE 9
#define BTN_SEND 10
#define BTN_DISCONNECT 11
#define SERVICE_TYPE @"MyService"

@interface ConnectScreenView ()
@property (weak, nonatomic) IBOutlet UIButton *createGameRoom;
@property (weak, nonatomic) IBOutlet UIButton *serchGameRoom;


@end

@implementation ConnectScreenView
{
    __weak IBOutlet UILabel *player1;
    __weak IBOutlet UILabel *player2;
    __weak IBOutlet UILabel *player3;
    __weak IBOutlet UILabel *player4;
    __weak IBOutlet UILabel *player5;
    __weak IBOutlet UILabel *player6;
    __weak IBOutlet UILabel *player7;
    
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
    __weak IBOutlet UILabel *gameStartOKLabel;
    __weak IBOutlet UIButton *gameStartOKButton;
    __weak IBOutlet UILabel *gameStartNextScreenButton;
    
    __weak IBOutlet UIButton *sendPlayerStatusButton;
    
    
    
    
    BOOL hostPlayer;
    int playerCount;
    int onlinePlayerCount;
    
    BOOL player1isMe;
    BOOL player2isMe;
    BOOL player3isMe;
    BOOL player4isMe;
    BOOL player5isMe;
    BOOL player6isMe;
    BOOL player7isMe;
    
    int player1_ID;
    int player2_ID;
    int player3_ID;
    int player4_ID;
    int player5_ID;
    int player6_ID;
    int player7_ID;
    
    NSString* receiveName;
    NSString* receiveGender;
    NSString* receiveAge;
    NSString* receiveAvatar;
    
    NSDictionary *receiveAllPlayerData;
    NSTimer *_timer;
    
    FMDatabase *db;
    NSString *nameFromDatabase;
    NSString *ageFromDatabase;
    NSString *genderFromDatabase;
    NSString *avatarFromDatabase;
    int playerIDFromDatabase;
    
    int playerData; //←player総数
    NSMutableArray *randomIDArray; //playerIDの入れ物
    
}


//アラートの表示
-(void)showAlert:(NSString*)title text:(NSString*)text{
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:title message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

//文字列のバイト配列変換
-(NSData*)str2data:(NSString*)str
{
    return [str dataUsingEncoding:NSUTF8StringEncoding];
    
}

//バイト配列の文字列変換
-(NSString*)data2str:(NSData*)data
{
    NSString* test = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"変換したtestの中身は%@",test);
    return test;
}

////バイト配列の書き込み
//-(BOOL)data2file:(NSData*)data fileName:(NSString*)fileName
//{
//    NSString* path = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
//    path = [path stringByAppendingPathComponent:fileName];
//    return [data writeToFile:path atomically:YES];
//}
//
////バイト配列の読み込み
//-(NSData*)file2data:(NSString*)fileName
//{
//    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    path = [path stringByAppendingPathComponent:fileName];
//    return [NSData dataWithContentsOfFile:path];
//}


//ボタンの生成
-(UIButton*)makeButton:(CGRect)rect text:(NSString*)text tag:(int)tag
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:rect];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTag:tag];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//UI状態の指定
-(void)updateUI
{
    UILabel *label = (UILabel*)[self.view viewWithTag:100];
    
    
    //セッション未接続
    if(_state==MCSessionStateNotConnected){
        
        label.text = @"オフラインモード";
    }
    //セッション接続中
    else if (_state ==MCSessionStateConnecting){
        
        label.text =@"接続中・・・";
    }
    //セッション接続
    else if(_state==MCSessionStateConnected){
        
        label.text = @"オンラインモード";
        
        UIButton *button1 = (UIButton*)[self.view viewWithTag:6];
        button1.alpha = 0.0f;
        UIButton *button2 = (UIButton*)[self.view viewWithTag:5];
        button2.alpha = 0.0f;
        sendPlayerStatusButton.hidden = NO;
    }
    
}

//テキストフィールドの更新
-(void)updateTextField:(NSString*)text
{
    _textField.text=text;
}

//初期化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *voiceURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"connectView1" ofType:@"wav"]];
    _voicePlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:voiceURL error:nil];
    self.player.numberOfLoops =  0;
    [self.voicePlayer play];
    
    NSURL *bgmURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Matching" ofType:@"mp3"] ];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:bgmURL error:nil];
    self.player.numberOfLoops = -1;
    [self.player play];
    
    if(self.aloneMode == YES){
        self.createGameRoom.enabled = NO;
        self.serchGameRoom.enabled = NO;
    }
    
    avatarView1.contentMode = UIViewContentModeScaleAspectFit;
    avatarView2.contentMode = UIViewContentModeScaleAspectFit;
    avatarView3.contentMode = UIViewContentModeScaleAspectFit;
    avatarView4.contentMode = UIViewContentModeScaleAspectFit;
    avatarView5.contentMode = UIViewContentModeScaleAspectFit;
    avatarView6.contentMode = UIViewContentModeScaleAspectFit;
    avatarView7.contentMode = UIViewContentModeScaleAspectFit;
    
    //角丸設定
    [self makeRadius_label:gameStartOKLabel];

    
    
    //ピアIDの設定
    _myPeerID = [[MCPeerID alloc]initWithDisplayName:self.player_name];
    
    //セッションの生成
    _session = [[MCSession alloc]initWithPeer:_myPeerID];
    _session.delegate = self;
    
    //送信ボタンの生成
    _btnSend = [self makeButton:CGRectMake(60, 70, 90, 40) text:@"送信" tag:BTN_SEND];
    _btnSend.hidden=YES;
    [self.view addSubview:_btnSend];
    
    //切断ボタンの生成
    _btnDisconnect = [self makeButton:CGRectMake(160, 70, 90, 40) text:@"切断" tag:BTN_DISCONNECT];
    _btnDisconnect.hidden= YES;
    [self.view addSubview:_btnDisconnect];
    
    
    //UIの更新
    _state=MCSessionStateNotConnected;
    [self updateUI];
    
    //プレイヤー識別用の変数&プレイヤーIDの総数を初期化
    playerCount = 0;
    onlinePlayerCount = 1;
    hostPlayer = YES;
    playerData = 7-1; //←要素０も数に含めるため、総人数-1しておく
    randomIDArray = [NSMutableArray arrayWithObjects:@1,@2,@3,@4,@5,@6,@7,nil];
    
    //NSDictionaryに格納する際に、nillだとエラーになるので、最初に初期化しておく
//    name1.text=@"name1";
//    name2.text=@"name2";
//    name3.text=@"name3";
//    name4.text=@"name4";
//    name5.text=@"name5";
//    name6.text=@"name6";
//    name7.text=@"name7";
//    
//    gender1.text=@"gender1";
//    gender2.text=@"gender2";
//    gender3.text=@"gender3";
//    gender4.text=@"gender4";
//    gender5.text=@"gender5";
//    gender6.text=@"gender6";
//    gender7.text=@"gender7";
//    
//    age1.text=@"age1";
//    age2.text=@"age2";
//    age3.text=@"age3";
//    age4.text=@"age4";
//    age5.text=@"age5";
//    age6.text=@"age6";
//    age7.text=@"age7";
//    
    avatar1=@"human.gif";
    avatar2=@"human.gif";
    avatar3=@"human.gif";
    avatar4=@"human.gif";
    avatar5=@"human.gif";
    avatar6=@"human.gif";
    avatar7=@"human.gif";
    
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
    
    //テスト用
    NSLog(@"aloneModeは%dだよ",self.aloneMode);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ボタンクリック時に呼ばれる
-(IBAction)clickButton:(UIButton*)sender
{
    //アドバタイズの開始ボタン
    if(sender.tag==5){
        _assistant = [[MCAdvertiserAssistant alloc]initWithServiceType:SERVICE_TYPE discoveryInfo:nil session:_session];
        [_assistant start];
        
        [self showAlert:@"" text:@"ゲーム部屋を作ります"];
        
        //アドバタイズ、ブラウズボタンを押せないように、ボタンを隠す
        hostPlayer = YES;
        UIButton *button = (UIButton*)[self.view viewWithTag:6];
        button.alpha = 0.0f;
        sender.alpha = 0.0f;
        
        /* ★☆★自分がホストの場合、player1は自分★☆★ */
        [self addGamePlayer:self.player_name gender:self.player_gender age:self.player_age avatar:self.player_avatar playerID:0];
        playerCount = 1;
        onlinePlayerCount = 1;
        
    }
    
    //ブラウズの開始ボタン
    if(sender.tag==6){
        _browseViewController = [[MCBrowserViewController alloc]initWithServiceType:SERVICE_TYPE session:_session];
        _browseViewController.delegate = self;
        [self presentViewController:_browseViewController animated:YES completion:nil];
        
        [self showAlert:@"" text:@"ゲーム部屋を探します"];
        
        hostPlayer = NO; //ホストプレイヤー解除、
        onlinePlayerCount = 0; //オンラインPlayerの番号をリセット
        _btnAdvertise.alpha = 0.0f; //アドバタイズボタンを押せないようにボタンを隠す
        gameStartNextScreenButton.enabled = NO;//ゲームスタートボタンも押せないようにする
    }
    
    //メッセージの送信ボタン
    else if(sender.tag==BTN_SEND){
               
        //セッションの切断ボタン
    } else if(sender.tag==BTN_DISCONNECT){
        [_session disconnect];
        _state=MCSessionStateNotConnected;
        [self updateUI];
    }
    
}

//NSDataオブジェクト受信時に呼ばれる
-(void)session:(MCSession*)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{
    //メッセージの受信
    //    [self performSelectorOnMainThread:@selector(updateTextField:) withObject:[self data2str:data] waitUntilDone:NO];
    
    //NSDataを受信したら、解答してaddPlayerを行う
    //    [self performSelectorOnMainThread:@selector(addGamePlayer:) withObject:[self data2str:data] waitUntilDone:NO];
    
    //ホストが何かを受信したら、受信データを解答して、参加者として登録する
    if(hostPlayer == YES){
        NSDictionary *receiveD = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        receiveName = [receiveD objectForKey:@"name"];
        receiveAge = [receiveD objectForKey:@"age"];
        receiveGender = [receiveD objectForKey:@"gender"];
        receiveAvatar = [receiveD objectForKey:@"avatar"];
        NSLog(@"%@,%@,%@,%@",receiveName,receiveAge,receiveGender,receiveAvatar);
        [self addGamePlayer:receiveName gender:receiveGender age:receiveAge avatar:receiveAvatar playerID:0];
        
        //オンラインプレイヤーが一人追加になる
        onlinePlayerCount = onlinePlayerCount +1;
        
        //その後、全員に対して参加者情報を送信する
        [self sendPlayerData:[NSNumber numberWithBool:NO]];
        
    } else if (hostPlayer==NO){
        //ホストプレイヤーじゃなければ、受け取ったデータを解答して、データを元に参加者を登録する
        receiveAllPlayerData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSLog(@"ホストからplayer1来てるよ%@,%@,%@,%@",[receiveAllPlayerData objectForKey:@"name1"],[receiveAllPlayerData objectForKey:@"gender1"],[receiveAllPlayerData objectForKey:@"age1"],[receiveAllPlayerData objectForKey:@"avatar1"]);
        
                NSLog(@"ホストからplayer2来てるよ%@,%@,%@,%@",[receiveAllPlayerData objectForKey:@"name2"],[receiveAllPlayerData objectForKey:@"gender2"],[receiveAllPlayerData objectForKey:@"age2"],[receiveAllPlayerData objectForKey:@"avatar2"]);
        
                NSLog(@"ホストからplayer3来てるよ%@,%@,%@,%@",[receiveAllPlayerData objectForKey:@"name3"],[receiveAllPlayerData objectForKey:@"gender3"],[receiveAllPlayerData objectForKey:@"age3"],[receiveAllPlayerData objectForKey:@"avatar3"]);
        
                NSLog(@"ホストからplayer4来てるよ%@,%@,%@,%@",[receiveAllPlayerData objectForKey:@"name4"],[receiveAllPlayerData objectForKey:@"gender4"],[receiveAllPlayerData objectForKey:@"age4"],[receiveAllPlayerData objectForKey:@"avatar4"]);
        
                NSLog(@"ホストからplayer5来てるよ%@,%@,%@,%@",[receiveAllPlayerData objectForKey:@"name5"],[receiveAllPlayerData objectForKey:@"gender5"],[receiveAllPlayerData objectForKey:@"age5"],[receiveAllPlayerData objectForKey:@"avatar5"]);
        
                NSLog(@"ホストからplayer6来てるよ%@,%@,%@,%@",[receiveAllPlayerData objectForKey:@"name6"],[receiveAllPlayerData objectForKey:@"gender6"],[receiveAllPlayerData objectForKey:@"age6"],[receiveAllPlayerData objectForKey:@"avatar6"]);
        
                NSLog(@"ホストからplayer7来てるよ%@,%@,%@,%@",[receiveAllPlayerData objectForKey:@"name7"],[receiveAllPlayerData objectForKey:@"gender7"],[receiveAllPlayerData objectForKey:@"age7"],[receiveAllPlayerData objectForKey:@"avatar7"]);
        
        name1.text=[receiveAllPlayerData objectForKey:@"name1"];
        name2.text=[receiveAllPlayerData objectForKey:@"name2"];
        name3.text=[receiveAllPlayerData objectForKey:@"name3"];
        name4.text=[receiveAllPlayerData objectForKey:@"name4"];
        name5.text=[receiveAllPlayerData objectForKey:@"name5"];
        name6.text=[receiveAllPlayerData objectForKey:@"name6"];
        name7.text=[receiveAllPlayerData objectForKey:@"name7"];
        
        gender1.text=[receiveAllPlayerData objectForKey:@"gender1"];
        gender2.text=[receiveAllPlayerData objectForKey:@"gender2"];
        gender3.text=[receiveAllPlayerData objectForKey:@"gender3"];
        gender4.text=[receiveAllPlayerData objectForKey:@"gender4"];
        gender5.text=[receiveAllPlayerData objectForKey:@"gender5"];
        gender6.text=[receiveAllPlayerData objectForKey:@"gender6"];
        gender7.text=[receiveAllPlayerData objectForKey:@"gender7"];
        
        age1.text=[receiveAllPlayerData objectForKey:@"age1"];
        age2.text=[receiveAllPlayerData objectForKey:@"age2"];
        age3.text=[receiveAllPlayerData objectForKey:@"age3"];
        age4.text=[receiveAllPlayerData objectForKey:@"age4"];
        age5.text=[receiveAllPlayerData objectForKey:@"age5"];
        age6.text=[receiveAllPlayerData objectForKey:@"age6"];
        age7.text=[receiveAllPlayerData objectForKey:@"age7"];
        
        avatar1=[receiveAllPlayerData objectForKey:@"avatar1"];
        avatar2=[receiveAllPlayerData objectForKey:@"avatar2"];
        avatar3=[receiveAllPlayerData objectForKey:@"avatar3"];
        avatar4=[receiveAllPlayerData objectForKey:@"avatar4"];
        avatar5=[receiveAllPlayerData objectForKey:@"avatar5"];
        avatar6=[receiveAllPlayerData objectForKey:@"avatar6"];
        avatar7=[receiveAllPlayerData objectForKey:@"avatar7"];
        
        avatarView1.image = [UIImage imageNamed:avatar1];
        avatarView2.image = [UIImage imageNamed:avatar2];
        avatarView3.image = [UIImage imageNamed:avatar3];
        avatarView4.image = [UIImage imageNamed:avatar4];
        avatarView5.image = [UIImage imageNamed:avatar5];
        avatarView6.image = [UIImage imageNamed:avatar6];
        avatarView7.image = [UIImage imageNamed:avatar7];
        
        BOOL gameStartOKorNO =[[receiveAllPlayerData objectForKey:@"gameStartOK"] boolValue];
        
        if(gameStartOKorNO == YES){
            //labelとボタンを表示して、次の画面に遷移させる
//            gameStartOKLabel.hidden = NO;
            gameStartOKButton.enabled = YES;
            NSLog(@"次の画面に遷移する指令がきたよ！！");
        }
        
    }
    
}

//ファイルリソースの受信開始時に呼ばれる
-(void)session:(MCSession*)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
{
    
}

//ファイルリソースの受信終了時に呼ばれる
-(void)session:(MCSession*)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error
{
    
}

//バイトストリームの接続開始時に呼ばれる
-(void)session:(MCSession*)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID
{
    
}

//接続状態変更時に呼ばれる
-(void)session:(MCSession*)session peer:(MCPeerID*)peerID didChangeState:(MCSessionState)state
{
    //UI状態の更新
    _state=state;
    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
}

//ブラウズ終了時に呼ばれる
-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    [_browseViewController dismissViewControllerAnimated:YES completion:nil];
}

//ブラウズキャンセル時に呼ばれる
-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    [_browseViewController dismissViewControllerAnimated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(IBAction)exitSegue:(UIStoryboardSegue*)segue
{
    NSLog(@"接続待機画面に戻ります");
}

- (IBAction)gameStart:(id)sender
{
    /* ★☆★残り人数に応じて、参加者を登録する★☆★ */
    int requiredPlayerCount; //←登録に必要な残り人数
    if(playerCount == 0){
        //まず、自分をplayer1に登録して
        [self addGamePlayer:self.player_name gender:self.player_gender age:self.player_age avatar:self.player_avatar playerID:playerIDFromDatabase];
        NSLog(@"player1を登録するよ,playerCountは%dだよ",playerCount);
        //残り６人を登録
        requiredPlayerCount = 6;
        for(int i=1;i <= requiredPlayerCount;i++){
            [self playerStatusFromDatabase];
            [self addGamePlayer:nameFromDatabase gender:genderFromDatabase age:ageFromDatabase avatar:avatarFromDatabase playerID:playerIDFromDatabase];
            NSLog(@"player%dを登録するよ,playerCountは%dだよ",i+1,playerCount);
        }
    } else if(playerCount == 1){
        requiredPlayerCount = 6;
        for(int i=1;i <= requiredPlayerCount;i++){
            [self playerStatusFromDatabase];
            [self addGamePlayer:nameFromDatabase gender:genderFromDatabase age:ageFromDatabase avatar:avatarFromDatabase playerID:playerIDFromDatabase];
            NSLog(@"player%dを登録するよ,playerCountは%dだよ",i,playerCount);
        }
    } else if(playerCount == 2){
        requiredPlayerCount = 5;
        for(int i=1;i <= requiredPlayerCount;i++){
            [self playerStatusFromDatabase];
            [self addGamePlayer:nameFromDatabase gender:genderFromDatabase age:ageFromDatabase avatar:avatarFromDatabase playerID:playerIDFromDatabase];
            NSLog(@"player%dを登録するよ,playerCountは%dだよ",i,playerCount);
        }
    } else if(playerCount == 3){
        requiredPlayerCount = 4;
        for(int i=1;i <= requiredPlayerCount;i++){
            [self playerStatusFromDatabase];
            [self addGamePlayer:nameFromDatabase gender:genderFromDatabase age:ageFromDatabase avatar:avatarFromDatabase playerID:playerIDFromDatabase];
            NSLog(@"player%dを登録するよ,playerCountは%dだよ",i,playerCount);
        }
    } else if(playerCount == 4){
        requiredPlayerCount = 3;
        for(int i=1;i <= requiredPlayerCount;i++){
            [self playerStatusFromDatabase];
            [self addGamePlayer:nameFromDatabase gender:genderFromDatabase age:ageFromDatabase avatar:avatarFromDatabase playerID:playerIDFromDatabase];
            NSLog(@"player%dを登録するよ,playerCountは%dだよ",i,playerCount);
        }
    } else if(playerCount == 5){
        requiredPlayerCount = 2;
        for(int i=1;i <= requiredPlayerCount;i++){
            [self playerStatusFromDatabase];
            [self addGamePlayer:nameFromDatabase gender:genderFromDatabase age:ageFromDatabase avatar:avatarFromDatabase playerID:playerIDFromDatabase];
            NSLog(@"player%dを登録するよ,playerCountは%dだよ",i,playerCount);
        }
    } else if(playerCount == 6){
        requiredPlayerCount = 1;
        for(int i=1;i <= requiredPlayerCount;i++){
            [self playerStatusFromDatabase];
            [self addGamePlayer:nameFromDatabase gender:genderFromDatabase age:ageFromDatabase avatar:avatarFromDatabase playerID:playerIDFromDatabase];
            NSLog(@"player%dを登録するよ,playerCountは%dだよ",i,playerCount);
        }
    } else if(playerCount == 7){
        requiredPlayerCount = 0;
        for(int i=1;i <= requiredPlayerCount;i++){
            [self playerStatusFromDatabase];
            [self addGamePlayer:nameFromDatabase gender:genderFromDatabase age:ageFromDatabase avatar:avatarFromDatabase playerID:playerIDFromDatabase];
            NSLog(@"player%dを登録するよ,playerCountは%dだよ",i,playerCount);
        }
    } else {
        NSLog(@"参加人数がなんかおかしいよ！");
    }
    
    //一人用モードじゃなかったら皆にデータ送るよ
    if(self.aloneMode == NO){
        [self sendPlayerData:[NSNumber numberWithBool:YES]];

    }
    
    
    /* ★☆★画面遷移の前に、登録済みdataをもっかい整理しよう★☆★ */
    NSLog(@"name1は%@",name1.text);
    NSLog(@"age1は%@",age1.text);
    NSLog(@"gender1は%@",gender1.text);
    NSLog(@"avatarView1は%@",avatarView1.image);
    NSLog(@"name2は%@",name2.text);
    NSLog(@"age2は%@",age2.text);
    NSLog(@"gender2は%@",gender2.text);
    NSLog(@"avatarView2は%@",avatarView2.image);
    NSLog(@"name3は%@",name3.text);
    NSLog(@"age3は%@",age3.text);
    NSLog(@"gender3は%@",gender3.text);
    NSLog(@"avatarView3は%@",avatarView3.image);
    NSLog(@"name4は%@",name4.text);
    NSLog(@"age4は%@",age4.text);
    NSLog(@"gender4は%@",gender4.text);
    NSLog(@"avatarView4は%@",avatarView4.image);
    NSLog(@"name5は%@",name5.text);
    NSLog(@"age5は%@",age5.text);
    NSLog(@"gender5は%@",gender5.text);
    NSLog(@"avatarView5は%@",avatarView5.image);
    NSLog(@"name6は%@",name6.text);
    NSLog(@"age6は%@",age6.text);
    NSLog(@"gender6は%@",gender6.text);
    NSLog(@"avatarView6は%@",avatarView6.image);
    NSLog(@"name7は%@",name7.text);
    NSLog(@"age7は%@",age7.text);
    NSLog(@"gender7は%@",gender7.text);
    NSLog(@"avatarView7は%@",avatarView7.image);
    NSLog(@"player1ID %d",player1_ID);
    NSLog(@"player2ID %d",player2_ID);
    NSLog(@"player3ID %d",player3_ID);
    NSLog(@"player4ID %d",player4_ID);
    NSLog(@"player5ID %d",player5_ID);
    NSLog(@"player6ID %d",player6_ID);
    NSLog(@"player7ID %d",player7_ID);
    
}

//画面遷移する際に、パラメーターを渡す
-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    QuestionScreenView *qsv = (QuestionScreenView*)[segue destinationViewController];
    
    TutorialScreenView *tutoScreenView = (TutorialScreenView*)[segue destinationViewController];
    
    if([segue.identifier isEqualToString:@"MoveToTutorial"]){
        tutoScreenView.fromTitleView = NO;
    } else  if([segue.identifier isEqualToString:@"moveToQuestionScreen"]){
        
        qsv.player1_name = name1.text;
        qsv.player1_gender = gender1.text;
        qsv.player1_age = age1.text;
        qsv.player1_avatar = avatar1;
        qsv.player2_name = name2.text;
        qsv.player2_gender = gender2.text;
        qsv.player2_age = age2.text;
        qsv.player2_avatar = avatar2;
        qsv.player3_name = name3.text;
        qsv.player3_gender = gender3.text;
        qsv.player3_age = age3.text;
        qsv.player3_avatar = avatar3;
        qsv.player4_name = name4.text;
        qsv.player4_gender = gender4.text;
        qsv.player4_age = age4.text;
        qsv.player4_avatar = avatar4;
        qsv.player5_name = name5.text;
        qsv.player5_gender = gender5.text;
        qsv.player5_age = age5.text;
        qsv.player5_avatar = avatar5;
        qsv.player6_name = name6.text;
        qsv.player6_gender = gender6.text;
        qsv.player6_age = age6.text;
        qsv.player6_avatar = avatar6;
        qsv.player7_name = name7.text;
        qsv.player7_gender = gender7.text;
        qsv.player7_age = age7.text;
        qsv.player7_avatar = avatar7;
        
        qsv.player1_ID = player1_ID;
        qsv.player2_ID = player2_ID;
        qsv.player3_ID = player3_ID;
        qsv.player4_ID = player4_ID;
        qsv.player5_ID = player5_ID;
        qsv.player6_ID = player6_ID;
        qsv.player7_ID = player7_ID;
        
        qsv.aloneMode = self.aloneMode;
        qsv.hostPlayer = hostPlayer;
        qsv.selfName = self.player_name;
        
        if(player1isMe == YES){
            qsv.player1 = YES;
        } else if(player2isMe == YES){
            qsv.player2 = YES;
        } else if(player3isMe == YES){
            qsv.player3 = YES;
        } else if(player4isMe == YES){
            qsv.player4 = YES;
        } else if(player5isMe == YES){
            qsv.player5 = YES;
        } else if(player6isMe == YES){
            qsv.player6 = YES;
        } else if(player7isMe == YES){
            qsv.player7 = YES;
        }
        
    } else  if([segue.identifier isEqualToString:@"moveToQuestionViewWithOnline"]){
        
        qsv.player1_name = name1.text;
        qsv.player1_gender = gender1.text;
        qsv.player1_age = age1.text;
        qsv.player1_avatar = avatar1;
        qsv.player2_name = name2.text;
        qsv.player2_gender = gender2.text;
        qsv.player2_age = age2.text;
        qsv.player2_avatar = avatar2;
        qsv.player3_name = name3.text;
        qsv.player3_gender = gender3.text;
        qsv.player3_age = age3.text;
        qsv.player3_avatar = avatar3;
        qsv.player4_name = name4.text;
        qsv.player4_gender = gender4.text;
        qsv.player4_age = age4.text;
        qsv.player4_avatar = avatar4;
        qsv.player5_name = name5.text;
        qsv.player5_gender = gender5.text;
        qsv.player5_age = age5.text;
        qsv.player5_avatar = avatar5;
        qsv.player6_name = name6.text;
        qsv.player6_gender = gender6.text;
        qsv.player6_age = age6.text;
        qsv.player6_avatar = avatar6;
        qsv.player7_name = name7.text;
        qsv.player7_gender = gender7.text;
        qsv.player7_age = age7.text;
        qsv.player7_avatar = avatar7;
        
        qsv.player1_ID = player1_ID;
        qsv.player2_ID = player2_ID;
        qsv.player3_ID = player3_ID;
        qsv.player4_ID = player4_ID;
        qsv.player5_ID = player5_ID;
        qsv.player6_ID = player6_ID;
        qsv.player7_ID = player7_ID;
        
        qsv.aloneMode = self.aloneMode;
                qsv.selfName = self.player_name;
        
        if(player1isMe == YES){
            qsv.player1 = YES;
        } else if(player2isMe == YES){
            qsv.player2 = YES;
        } else if(player3isMe == YES){
            qsv.player3 = YES;
        } else if(player4isMe == YES){
            qsv.player4 = YES;
        } else if(player5isMe == YES){
            qsv.player5 = YES;
        } else if(player6isMe == YES){
            qsv.player6 = YES;
        } else if(player7isMe == YES){
            qsv.player7 = YES;
        }

        
    }else {
        NSLog(@"segueの名前が間違ってるんじゃない？");
    }
}

- (IBAction)firstViewReturnActionForSegue:(UIStoryboardSegue *)segue
{
    NSLog(@"Return to ViewController");
}

//参加者追加メソッド
-(void)addGamePlayer:(NSString*)name gender:(NSString*)gender age:(NSString*)age avatar:(NSString*)avatar playerID:(int)playerID
{
    NSLog(@"登録するやでー");
    if(hostPlayer == YES){
        //ホストプレイヤーだった場合の処理
        player1isMe = YES; //俺がplayer1だ！！
        if(playerCount == 0){
            name1.text = self.player_name;
            age1.text = self.player_age;
            gender1.text = self.player_gender;
            avatar1 = self.player_avatar;
            avatarView1.image = [UIImage imageNamed:avatar1];
            
            
        } else if(playerCount == 1){
            NSLog(@"bbb");
            name2.text = name;
            age2.text = age;
            gender2.text = gender;
            avatar2 = avatar;
            avatarView2.image = [UIImage imageNamed:avatar2];
            player2_ID = playerID;
            
        } else if(playerCount == 2){
            
            name3.text = name;
            age3.text = age;
            gender3.text = gender;
            avatar3 = avatar;
            avatarView3.image = [UIImage imageNamed:avatar3];
            player3_ID = playerID;
            
        } else if(playerCount == 3){
            
            name4.text = name;
            age4.text = age;
            gender4.text = gender;
            avatar4 = avatar;
            avatarView4.image = [UIImage imageNamed:avatar4];
            player4_ID = playerID;
            
        } else if(playerCount == 4){
            
            name5.text = name;
            age5.text = age;
            gender5.text = gender;
            avatar5 = avatar;
            avatarView5.image = [UIImage imageNamed:avatar5];
            player5_ID = playerID;
            
        } else if(playerCount == 5){
            
            name6.text = name;
            age6.text = age;
            gender6.text = gender;
            avatar6 = avatar;
            avatarView6.image = [UIImage imageNamed:avatar6];
            player6_ID = playerID;
            
        } else if(playerCount == 6){
            
            name7.text = name;
            age7.text = age;
            gender7.text = gender;
            avatar7 = avatar;
            avatarView7.image = [UIImage imageNamed:avatar7];
            player7_ID = playerID;
            
        } else if(playerCount == 7){
            
            NSLog(@"もうこれ以上登録できないよ");
            
        } else {
            NSLog(@"参加人数がなんかおかしいよ！");
        }
        
        playerCount = playerCount + 1;
        
    } else if(hostPlayer == NO){
        //ホストプレイヤーじゃない場合の処理
        NSLog(@"ホストじゃないから、player登録権限はないよ");
    }
    [self.view setNeedsDisplay];
    
}

//ホストプレイヤー→他プレイヤーへの参加者情報セット
-(NSData*)allPlayerStatus:(NSNumber*)gameStartOK
{
    
    NSDictionary *allPlayerDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                  
                                  name1.text,@"name1",
                                  name2.text,@"name2",
                                  name3.text,@"name3",
                                  name4.text,@"name4",
                                  name5.text,@"name5",
                                  name6.text,@"name6",
                                  name7.text,@"name7",
                                  
                                  gender1.text,@"gender1",
                                  gender2.text,@"gender2",
                                  gender3.text,@"gender3",
                                  gender4.text,@"gender4",
                                  gender5.text,@"gender5",
                                  gender6.text,@"gender6",
                                  gender7.text,@"gender7",
                                  
                                  age1.text,@"age1",
                                  age2.text,@"age2",
                                  age3.text,@"age3",
                                  age4.text,@"age4",
                                  age5.text,@"age5",
                                  age6.text,@"age6",
                                  age7.text,@"age7",
                                  
                                  avatar1,@"avatar1",
                                  avatar2,@"avatar2",
                                  avatar3,@"avatar3",
                                  avatar4,@"avatar4",
                                  avatar5,@"avatar5",
                                  avatar6,@"avatar6",
                                  avatar7,@"avatar7",
                                  
                                  gameStartOK,@"gameStartOK",
                                  
                                  //
                                  //                                  titleOfHonor1.text,@"titleOfHonor1",
                                  //                                  titleOfHonor2.text,@"titleOfHonor2",
                                  //                                  titleOfHonor3.text,@"titleOfHonor3",
                                  //                                  titleOfHonor4.text,@"titleOfHonor4",
                                  //                                  titleOfHonor5.text,@"titleOfHonor5",
                                  //                                  titleOfHonor6.text,@"titleOfHonor6",
                                  //                                  titleOfHonor7.text,@"titleOfHonor7",
                                  
                                  nil];
    
    return  [NSKeyedArchiver archivedDataWithRootObject:allPlayerDic];
}

//ホストから皆へのデータ送信
-(void)sendPlayerData:(NSNumber*)gameStartOK
{
    NSData* sendAllPlayerData = [self allPlayerStatus:gameStartOK];
    NSArray* peerIDs = [_session connectedPeers];
    NSError* error = nil;
    [_session sendData:sendAllPlayerData toPeers:peerIDs withMode:MCSessionSendDataReliable error:&error];

}


-(void)playerStatusFromDatabase
{
    //ランダムIDを生成し、そのIDをarrayから取り出した後に、使用済みとしてarrayからの削除を行う
    int randomID = (arc4random() % playerData) ;
    NSLog(@"今回のランダムIDは%d",randomID);
    NSString *randomIDtoPlayerID = [randomIDArray objectAtIndex:randomID];
    [randomIDArray removeObject:randomIDtoPlayerID];
    NSLog(@"今回選ばれたplayerIDは%@",randomIDtoPlayerID);
    //playerData要素を削除したので、その分総数から-1する
    playerData = playerData - 1 ;
    
    [db open];
    
    //取り出すためのセレクト文（ランダム処理対応）
    NSString *selectRandomPlayer = [[NSString alloc]initWithFormat:@"select _id,name,age,gender,avatar from player_status where _id = %@",randomIDtoPlayerID];
    FMResultSet *result = [db executeQuery:selectRandomPlayer];
    
    while([result next]){
        //名前の取得
        
        playerIDFromDatabase = [result intForColumnIndex:0];
        nameFromDatabase= [result stringForColumnIndex:1];
        ageFromDatabase=[result stringForColumnIndex:2];
        genderFromDatabase=[result stringForColumnIndex:3];
        avatarFromDatabase= [result stringForColumnIndex:4];
        
        NSLog(@"DBから取り出したのは%@",nameFromDatabase);
        NSLog(@"DBから取り出したのは%@",ageFromDatabase);
        NSLog(@"DBから取り出したのは%@",genderFromDatabase);
        NSLog(@"DBから取り出したのは%@",avatarFromDatabase);
    }
    
    if([avatarFromDatabase isEqualToString:@"1"]){
        avatarFromDatabase = @"tou_reimu_to.gif";
    } else if ([avatarFromDatabase isEqualToString:@"2"]){
        avatarFromDatabase = @"tou_cirno_k.gif";
    } else if ([avatarFromDatabase isEqualToString:@"3"]){
        avatarFromDatabase = @"tou_remilia_k.gif";
    } else if ([avatarFromDatabase isEqualToString:@"4"]){
        avatarFromDatabase = @"tou_sakuya_k.gif";
    } else if ([avatarFromDatabase isEqualToString:@"5"]){
        avatarFromDatabase = @"tou_youmu_mo.gif";
    } else if ([avatarFromDatabase isEqualToString:@"6"]){
        avatarFromDatabase = @"tou_komachi_k.gif";
    } else if ([avatarFromDatabase isEqualToString:@"7"]){
        avatarFromDatabase = @"walk.gif";
    } else if ([avatarFromDatabase isEqualToString:@"8"]){
        avatarFromDatabase = @"μ's1.gif";
    } else if ([avatarFromDatabase isEqualToString:@"9"]){
        avatarFromDatabase = @"neko.gif";
    } else if ([avatarFromDatabase isEqualToString:@"10"]){
        avatarFromDatabase = @"neko2.gif";
    } else if ([avatarFromDatabase isEqualToString:@"11"]){
        avatarFromDatabase = @"penn.gif";
    } else if ([avatarFromDatabase isEqualToString:@"12"]){
        avatarFromDatabase = @"ff7.gif";
    }
    
    [db close];
    
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

//timerの初期化処理
//-(void)myInit
//{
//    if(![_timer isValid]){
//        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
//    } else {
//        NSLog(@"タイマーはもう動いてますが？");
//    }
//}

//-(void)onTimer:(NSTimer*)timer
//{
//    //    NSLog(@"ホストから何か来てるよ%@,%@,%@,%@",[receiveAllPlayerData objectForKey:@"name2"],[receiveAllPlayerData objectForKey:@"gender2"],[receiveAllPlayerData objectForKey:@"age2"],[receiveAllPlayerData objectForKey:@"avatar2"]);
//    
//}

- (IBAction)sendPlayerStatusButton:(id)sender
{
    if(hostPlayer == NO){
        //ホストじゃなかったら、ホストに自分の情報を送信
        NSArray* peerIDs = [_session connectedPeers];
        NSError* error = nil;
        NSDictionary *dicName = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.player_name,@"name",
                                 self.player_age,@"age",
                                 self.player_gender,@"gender",
                                 self.player_avatar,@"avatar",nil];
        
        NSData *sendStatus = [NSKeyedArchiver archivedDataWithRootObject:dicName];
        [_session sendData:sendStatus toPeers:peerIDs withMode:MCSessionSendDataReliable error:&error];
        
        //押した後に押せなくなる
        sendPlayerStatusButton.enabled = NO;

        
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.player stop];
    [self.voicePlayer stop];
}

@end