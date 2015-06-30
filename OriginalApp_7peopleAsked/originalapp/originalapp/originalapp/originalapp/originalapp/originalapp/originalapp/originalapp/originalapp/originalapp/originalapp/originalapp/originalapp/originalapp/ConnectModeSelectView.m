//
//  ConnectModeSelectView.m
//  OriginalApp(卒業制作)
//
//  Created by 平山亮 on 2015/03/18.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import "ConnectModeSelectView.h"


@interface ConnectModeSelectView ()

@property (weak, nonatomic) IBOutlet UIButton *aloneModeButton;
@property (weak, nonatomic) IBOutlet UIButton *peerModeButton;
@property (weak, nonatomic) IBOutlet UIButton *charaCreateButton;

@end

@implementation ConnectModeSelectView
{
    BOOL aloneMode;
    
    __weak IBOutlet UIWebView *myImagWebView;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *genderLabel;
    __weak IBOutlet UILabel *ageLabel;
    
}

- (void)viewDidLoad {
//    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *voiceURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"connectModeSelect1" ofType:@"wav"]];
    _voicePlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:voiceURL error:nil];
    self.player.numberOfLoops =  0;
    [self.voicePlayer play];

    NSURL *bgmURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"mario_samui" ofType:@"mp3"] ];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:bgmURL error:nil];
    self.player.numberOfLoops = -1;
    self.player.volume = 0.5;
    [self.player play];

    nameLabel.text = self.player_name;
    genderLabel.text = self.player_gender;
    ageLabel.text = self.player_age;
    
    NSData *gifData = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:self.player_avatar]];
    myImagWebView.scalesPageToFit = YES;
    [myImagWebView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"utf-8" baseURL:nil];
  
    //キャラクターデータのいずれかが空欄だったら、ボタンは押せない
     if((self.player_name == nil)&&(self.player_age == nil)&&(self.player_gender ==nil)&&(self.player_avatar==nil)){
         
         _charaCreateButton.enabled = YES;
         _aloneModeButton.enabled = NO;
         _peerModeButton.enabled = NO;
         
     } else {
         _charaCreateButton.enabled = YES;
         _aloneModeButton.enabled = YES;
         _peerModeButton.enabled = YES;
     }
    
    NSLog(@"%@",self.player_age);

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

- (IBAction)onlineMode:(id)sender
{
    aloneMode = NO;
    
}

- (IBAction)multiPeerMode:(id)sender
{
    aloneMode = NO;
}

- (IBAction)offlineMode:(id)sender
{
    aloneMode = YES;

}

//画面遷移する際に、パラメーターを渡す
-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    //名前が入力されている時のみ、パラメーターを渡して遷移を許可
     if((self.player_name != nil)&&(self.player_age != nil)&&(self.player_gender !=nil)&&(self.player_avatar!=nil)){
        ConnectScreenView *csv = (ConnectScreenView*)[segue destinationViewController];
        
        if([segue.identifier isEqualToString:@"peerGameStart"]){
            csv.player_name = self.player_name;
            csv.player_gender = self.player_gender;
            csv.player_age = self.player_age;
            csv.player_avatar = self.player_avatar;
            
            csv.aloneMode = aloneMode;
            
        } else {
            csv.player_name = self.player_name;
            csv.player_gender = self.player_gender;
            csv.player_age = self.player_age;
            csv.player_avatar = self.player_avatar;
            
            csv.aloneMode = aloneMode;
        }
     } else {
         
     }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.player stop];
    [self.voicePlayer stop];
}

@end
