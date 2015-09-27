//
//  TitleScreenView.m
//  OriginalApp(卒業制作)
//
//  Created by 平山亮 on 2015/02/24.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import "TitleScreenView.h"

@interface TitleScreenView ()

@end

@implementation TitleScreenView
#pragma mark - View LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *voiceURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"title1" ofType:@"wav"]];
    _playerVoice = [[AVAudioPlayer alloc]initWithContentsOfURL:voiceURL error:nil];
    self.player.numberOfLoops =  0;
    [self.playerVoice play];
    
    NSURL *bgmURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"mario_bomb" ofType:@"mp3"] ];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:bgmURL error:nil];
    self.player.numberOfLoops = -1;
    
  [self performSelector:@selector(performComplete) withObject:nil afterDelay:2.5];

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

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - IBAction
- (IBAction)gameStart:(id)sender
{
    //もし、UserDefaultに登録情報があったら、読みこむ
    
    
    //UserDefaultに登録情報が無かったら、強制的にキャラ作成画面に
    
}

-(IBAction)charaCreate:(UIButton*)sender
{

}

-(IBAction)tutorial:(UIButton*)sender
{

    
}

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    
        TutorialScreenView *tutoScreenView = (TutorialScreenView*)[segue destinationViewController];
        
        if([segue.identifier isEqualToString:@"moveToTutorial"]){

            tutoScreenView.fromTitleView = YES;
            NSLog(@"俺はタイトル画面ですよ？%d",tutoScreenView.fromTitleView);
            
              }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.player stop];
    [self.playerVoice stop];
    
}

//ディレイ処理
-(void)performComplete
{
    

    NSLog(@"ディレイ処理したよ!");

    [self.player play];
    
}

@end
