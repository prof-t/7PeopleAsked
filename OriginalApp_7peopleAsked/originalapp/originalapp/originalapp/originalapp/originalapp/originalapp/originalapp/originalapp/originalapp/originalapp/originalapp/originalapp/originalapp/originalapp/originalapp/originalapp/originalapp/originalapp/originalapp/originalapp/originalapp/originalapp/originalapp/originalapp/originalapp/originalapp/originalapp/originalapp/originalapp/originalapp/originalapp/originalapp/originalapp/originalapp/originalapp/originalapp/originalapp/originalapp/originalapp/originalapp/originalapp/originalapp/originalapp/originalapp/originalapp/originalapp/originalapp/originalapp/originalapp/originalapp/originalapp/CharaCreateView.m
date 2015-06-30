//
//  CharaCreateView.m
//  OriginalApp(卒業制作)
//
//  Created by 平山亮 on 2015/02/24.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import "CharaCreateView.h"
#import "FMDatabase.h"

#define BTN_SHOW 0

@interface CharaCreateView ()

@end

@implementation CharaCreateView
{
    
    __weak IBOutlet UITextField *nameTextField;
    UIImageView *_myImage;
    
    int genderValue;
    int ageValue;
    int avatarValue;
    
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *genderLabel;
    __weak IBOutlet UILabel *ageLabel;
    
    //DB
    FMDatabase *db;
    
        UIWebView *animationGifView;
    CharacterStatus *characterStatus;
}

-(void)showAlert:(NSString*)title text:(NSString*)text
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:title message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

// テキストボタンの生成
- (UIButton*)makeButton:(CGRect)rect text:(NSString*)text tag:(int)tag {
    UIButton* button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:rect];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTag:tag];
    [button addTarget:self action:@selector(clickButton:)
     forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//初期化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *voiceURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"charaCreate1" ofType:@"wav"]];
    _voicePlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:voiceURL error:nil];
    self.player.numberOfLoops =  0;
    [self.voicePlayer play];
    
    NSURL *bgmURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"nameScene" ofType:@"mp3"] ];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:bgmURL error:nil];
    self.player.numberOfLoops = -1;
    [self.player play];
    
    //ピッカービューに入れる文字列
    _items = [[NSMutableArray alloc]initWithObjects:@"東方（霊夢）",@"東方（チルノ）",@"東方（レミリア）",@"東方（咲夜）",@"東方（妖夢）",@"東方（小町）",@"縦ロール",@"ラブライブ！",@"猫１",@"猫２",@"ペンギン",@"セフィロス",nil];

    //ピッカービューの生成
    _pickerView = [[UIPickerView alloc]init];
    [_pickerView setFrame:CGRectMake(400,30,200,250)];
    [_pickerView setDelegate:self];
    [_pickerView setDataSource:self];
    [_pickerView setShowsSelectionIndicator:YES];
    [self.view addSubview:_pickerView];
    [_pickerView setTag:9];
    _selectIdx=0;
    
    //webビュー用の別クラスのインスタンスを作成
    characterStatus = [[CharacterStatus alloc]init];
    
    // ボタンの生成
    UIButton* btnShow=[self makeButton:CGRectMake(500,300,100,40) text:@"決定" tag:BTN_SHOW];
    btnShow.hidden = YES;
    [self.view addSubview:btnShow];
    
    //　キャラステータスの初期化
    _myStatus = [CharacterStatus alloc];
    
    /* ★☆★DBへのアクセス★☆★ */
    NSString *databaseName = @"7peopleAsked.db";
    NSString *workPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *databasePath = [workPath stringByAppendingPathComponent:databaseName];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //文書フォルダにデータベースファイルが存在しているかチェック
    if(![manager fileExistsAtPath:databasePath]){
        NSError *error = nil;
        NSString *templatePath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:databaseName];
        if(![manager copyItemAtPath:templatePath toPath:databasePath error:&error]){
            NSLog(@"コピー失敗しました");
        }
    }

    //データベースのオープン
    db = [FMDatabase databaseWithPath:databasePath];
    [db open];

}

//行数の取得
-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
//    return _items.count;
    return 12;
}

//行のセルの取得
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //セルの生成
    UIView* cell = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    
    //ラベルの生成
    NSString* avatarName = [_items objectAtIndex:row];
    UILabel* label =[[UILabel alloc]init];
    [label setFrame:CGRectMake(0,0,200,100)];
    [label setFont:[UIFont systemFontOfSize:18]];
    [label setBackgroundColor:[UIColor whiteColor]];
    [label setText:avatarName];
    [cell addSubview:label];
    
    return cell;
}

//行の高さの取得
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 20;
}

//ドラム数（componentの数）
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//ピッカービュー選択時に呼ばれる
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectIdx=row;
    
    /* GIFアニメ */

    CGRect webviewRect = CGRectMake(400, 210, 150, 120);


    if(_selectIdx == 0){
        _myStatus.player_avatar =@"tou_reimu_to.gif";
        avatarValue = 0;
        animationGifView = [characterStatus makeWebView:_myStatus.player_avatar rect:webviewRect];
    } else if(_selectIdx == 1){
        _myStatus.player_avatar =@"tou_cirno_k.gif";
        avatarValue = 1;
        animationGifView = [characterStatus makeWebView:_myStatus.player_avatar rect:webviewRect];
    } else if(_selectIdx == 2){
        _myStatus.player_avatar =@"tou_remilia_k.gif";
        avatarValue = 2;
        animationGifView = [characterStatus makeWebView:_myStatus.player_avatar rect:webviewRect];
    } else if(_selectIdx == 3){
        _myStatus.player_avatar =@"tou_sakuya_k.gif";
        avatarValue = 3;
        animationGifView = [characterStatus makeWebView:_myStatus.player_avatar rect:webviewRect];
    } else if(_selectIdx == 4){
        _myStatus.player_avatar =@"tou_youmu_mo.gif";
        avatarValue = 4;
        animationGifView = [characterStatus makeWebView:_myStatus.player_avatar rect:webviewRect];
    } else if(_selectIdx == 5){
        _myStatus.player_avatar =@"tou_komachi_k.gif";
        avatarValue = 5;
        animationGifView = [characterStatus makeWebView:_myStatus.player_avatar rect:webviewRect];
    } else if(_selectIdx == 6){
        _myStatus.player_avatar =@"walk.gif";
        avatarValue = 6;
        animationGifView = [characterStatus makeWebView:_myStatus.player_avatar rect:webviewRect];
    } else if(_selectIdx == 7){
        _myStatus.player_avatar =@"μ's1.gif";
        avatarValue = 7;
        animationGifView = [characterStatus makeWebView:_myStatus.player_avatar rect:webviewRect];
    } else if(_selectIdx == 8){
        _myStatus.player_avatar =@"neko.gif";
        avatarValue = 8;
        animationGifView = [characterStatus makeWebView:_myStatus.player_avatar rect:webviewRect];
    } else if(_selectIdx == 9){
        _myStatus.player_avatar =@"neko2.gif";
        avatarValue = 9;
        animationGifView = [characterStatus makeWebView:_myStatus.player_avatar rect:webviewRect];
    } else if(_selectIdx == 10){
        _myStatus.player_avatar =@"penn.gif";
        avatarValue = 10;
        animationGifView = [characterStatus makeWebView:_myStatus.player_avatar rect:webviewRect];
    } else if(_selectIdx == 11){
        _myStatus.player_avatar =@"ff7.gif";
        avatarValue = 11;
        animationGifView = [characterStatus makeWebView:_myStatus.player_avatar rect:webviewRect];
    } else {
        NSLog(@"アバター設定に不具合あり");
    }

        [self.view addSubview: animationGifView];
    
//    if(_selectIdx == 0){
//        _myStatus.player_avatar =@"eto_ca_025.png";
//        avatarValue = 0;
//    } else if(_selectIdx == 1){
//        _myStatus.player_avatar =@"eto_ca_026.png";
//        avatarValue = 1;
//    } else if(_selectIdx == 2){
//        _myStatus.player_avatar =@"eto_ca_027.png";
//        avatarValue = 2;
//    } else if(_selectIdx == 3){
//        _myStatus.player_avatar =@"eto_ca_028.png";
//        avatarValue = 3;
//    } else if(_selectIdx == 4){
//        _myStatus.player_avatar =@"eto_ca_029.png";
//        avatarValue = 4;
//    } else if(_selectIdx == 5){
//        _myStatus.player_avatar =@"eto_ca_030.png";
//        avatarValue = 5;
//    } else if(_selectIdx == 6){
//        _myStatus.player_avatar =@"eto_ca_031.png";
//        avatarValue = 6;
//    } else if(_selectIdx == 7){
//        _myStatus.player_avatar =@"eto_ca_032.png";
//        avatarValue = 7;
//    } else if(_selectIdx == 8){
//        _myStatus.player_avatar =@"eto_ca_033.png";
//        avatarValue = 8;
//    } else {
//        NSLog(@"アバター設定に不具合あり");
//    }
    
        NSLog(@"アバターは%@",_myStatus.player_avatar);
//    [_myImage setImage:[UIImage imageNamed:_myStatus.player_avatar]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ボタンクリック時に呼ばれる
- (IBAction)clickButton:(UIButton*)sender {
    if (sender.tag==BTN_SHOW) {
        NSString* name=[_items objectAtIndex:_selectIdx];
        [self showAlert:@"" text:[NSString stringWithFormat:
                                  @" ピッカーの選択 \n%@",name]];   
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)makeName:(UITextField *)sender
{

    //プロパティに入っている名前を表示ラベルに表示させる
    nameLabel.text = _myStatus.player_name;
    
    //プロパティに名前を登録
    _myStatus.player_name = sender.text;
    
}

- (IBAction)makeGender:(UISegmentedControl*)sender
{
    if(sender.selectedSegmentIndex == 0){
        _myStatus.player_gender = @"男性";
        genderValue = 0;
    } else if (sender.selectedSegmentIndex == 1){
        _myStatus.player_gender = @"女性";
        genderValue = 1;
    } else {
        NSLog(@"性別ボタンに不具合があるよ");
    }
    
    //プロパティに入っている性別を表示ラベルに表示させる
    genderLabel.text = _myStatus.player_gender;
}


- (IBAction)makeAge:(UISegmentedControl *)sender
{
    if(sender.selectedSegmentIndex == 0){
        _myStatus.player_age = @"〜10才";
        ageValue = 0;
    } else if (sender.selectedSegmentIndex == 1){
        _myStatus.player_age = @"10代";
        ageValue = 1;
    } else if (sender.selectedSegmentIndex == 2){
        _myStatus.player_age = @"20代";
        ageValue = 2;
    } else if (sender.selectedSegmentIndex == 3){
        _myStatus.player_age = @"30代";
        ageValue = 3;
    } else if (sender.selectedSegmentIndex == 4){
        _myStatus.player_age = @"40代";
        ageValue = 4;
    } else if (sender.selectedSegmentIndex == 5){
        _myStatus.player_age = @"50代";
        ageValue = 5;
    } else if (sender.selectedSegmentIndex == 6){
        _myStatus.player_age = @"60才〜";
        ageValue = 6;
    } else {
        NSLog(@"年齢ボタンに不具合があるよ");
    }
    
//    NSLog(@"年齢は%@",_myStatus.player_age);
    
    //プロパティに入っている年齢を表示ラベルに表示させる
    ageLabel.text = _myStatus.player_age;
    
}

- (IBAction)saveToFile:(UIButton *)sender
{
    /* ★☆★SQLに保存★☆★ */
//    BOOL success = [db executeUpdate:@"insert into player_status(player_name,player_gender,player_age,player_avatar) values(?,?,?,?)",_myStatus.player_name,_myStatus.player_gender,_myStatus.player_age,_myStatus.player_avatar];
//    
//    NSLog(@"セーブしたプロフィールは、%@ %@ %@ %@",_myStatus.player_name,_myStatus.player_gender,_myStatus.player_age,_myStatus.player_avatar);
//    
//    if(success == NO){
//        NSLog(@"INSERT失敗 %@",[db lastError]);
//    }
//    
//    //SQLのSELECT文実行とデータの取得
//    FMResultSet *result = [db executeQuery:@"select * from player_status"];
//    
//    //SELECT文の結果の入れ物
//    NSMutableString *mstr = [NSMutableString string];
//    while ([result next]){
//        NSString *name = [result stringForColumnIndex:1];
//        NSString *gender = [result stringForColumnIndex:2];
//        NSString *age = [result stringForColumnIndex:3];
//        NSString *avatar = [result stringForColumnIndex:4];
//        [mstr appendFormat:@"%@ %@ %@ %@\n",name,gender,age,avatar];
//    }
//    [db close];
//    NSLog(@"セーブしたプロフィールは、%@",mstr);
    
    UITextField *name = (UITextField*)[self.view viewWithTag:5];
    
    /* ★☆★UserDefaultの設定★☆★ */
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:ageValue forKey:@"age"];
    [ud setObject:name.text forKey:@"name"];
    [ud setInteger:genderValue forKey:@"gender"];
    [ud setInteger:avatarValue forKey:@"avatar"];
    
    NSLog(@"%d",genderValue);
}

- (IBAction)loadToFile:(UIButton *)sender
{
    /* ★☆★UserDefaultの読み込み★☆★ */
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    UITextField *name = (UITextField*)[self.view viewWithTag:5];
    UISegmentedControl *gender = (UISegmentedControl*)[self.view viewWithTag:6];
    UISegmentedControl *age = (UISegmentedControl*)[self.view viewWithTag:7];
    UIImageView *avatar = (UIImageView*)[self.view viewWithTag:8];
    UIPickerView *pView = (UIPickerView*)[self.view viewWithTag:9];
    
    name.text = [NSString stringWithFormat:@"%@",(NSString*)[ud objectForKey:@"name"]];
    gender.selectedSegmentIndex = [ud integerForKey:@"gender"];
    age.selectedSegmentIndex = [ud integerForKey:@"age"];

    
    //myStatus変数にも値を設定
    _myStatus.player_name = name.text;
    
    if(age.selectedSegmentIndex == 0){
        _myStatus.player_age = @"〜10才";
    } else if (age.selectedSegmentIndex == 1){
        _myStatus.player_age = @"10代";
    } else if (age.selectedSegmentIndex == 2){
        _myStatus.player_age = @"20代";
    } else if (age.selectedSegmentIndex == 3){
        _myStatus.player_age = @"30代";
    } else if (age.selectedSegmentIndex == 4){
        _myStatus.player_age = @"40代";
    } else if (age.selectedSegmentIndex == 5){
        _myStatus.player_age = @"50代";
    } else if (age.selectedSegmentIndex == 6){
        _myStatus.player_age = @"60才〜";
    } else {
        NSLog(@"ロード時の年齢ボタン設定に不具合があるよ");
    }

    NSLog(@"%@",_myStatus.player_age);
    
    if(gender.selectedSegmentIndex == 0){
        _myStatus.player_gender = @"男性";
    } else if (gender.selectedSegmentIndex == 1){
        _myStatus.player_gender = @"女性";
    } else {
        NSLog(@"ロード時の性別ボタン設定に不具合があるよ");
    }

    
    if([ud integerForKey:@"avatar"]==0){
        _myStatus.player_avatar =@"tou_reimu_k.gif";
    }else if ([ud integerForKey:@"avatar"] ==1){
        _myStatus.player_avatar =@"tou_cirno_k.gif";
    }else if ([ud integerForKey:@"avatar"] ==2){
        _myStatus.player_avatar =@"tou_remilia_k.gif";
    }else if ([ud integerForKey:@"avatar"] ==3){
        _myStatus.player_avatar =@"tou_sakuya_k.gif";
    }else if ([ud integerForKey:@"avatar"] ==4){
        _myStatus.player_avatar =@"tou_youmu_mo.gif";
    }else if ([ud integerForKey:@"avatar"] ==5){
        _myStatus.player_avatar =@"tou_komachi_k.gif";
    }else if ([ud integerForKey:@"avatar"] ==6){
        _myStatus.player_avatar =@"walk.gif";
    }else if ([ud integerForKey:@"avatar"] ==7){
        _myStatus.player_avatar =@"μ's1.gif";
    }else if ([ud integerForKey:@"avatar"] ==8){
        _myStatus.player_avatar =@"neko.gif";
    } else {
        NSLog(@"ロード時のアバター設定に不具合があるよ");
    }
    
    nameLabel.text = _myStatus.player_name;
    ageLabel.text = _myStatus.player_age;
    genderLabel.text = _myStatus.player_gender;
  animationGifView = [[UIWebView alloc] initWithFrame:CGRectMake(400, 210, 150, 120)];
    NSData *gifData = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:_myStatus.player_avatar]];
    [animationGifView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"utf-8" baseURL:nil];
        [self.view addSubview: animationGifView];

    //    [pView selectRow:0 inComponent:[ud integerForKey:@"avatar"] animated:NO];
}

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event
{
    //タッチしたらキーボード閉じる
    [nameTextField resignFirstResponder];
    

   

}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.player stop];
    [self.voicePlayer stop];
}

- (IBAction)gameStart:(id)sender
{
    
}

//画面遷移する際に、パラメーターを渡す
-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"gameStart"]){
        ConnectModeSelectView *cmsv = (ConnectModeSelectView*)[segue destinationViewController];
        cmsv.player_name = _myStatus.player_name;
        cmsv.player_gender = _myStatus.player_gender;
        cmsv.player_age = _myStatus.player_age;
        cmsv.player_avatar = _myStatus.player_avatar;
        
    }
        
}

@end
