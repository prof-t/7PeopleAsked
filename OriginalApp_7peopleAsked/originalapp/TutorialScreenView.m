//
//  TutorialScreenView.m
//  OriginalApp(卒業制作)
//
//  Created by 平山亮 on 2015/02/24.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import "TutorialScreenView.h"

@interface TutorialScreenView ()
@property (weak, nonatomic) IBOutlet UIButton *returnGameView;
@property (weak, nonatomic) IBOutlet UIButton *returnTitleView;

@end

@implementation TutorialScreenView

#pragma mark - View LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *voiceURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"rule1" ofType:@"wav"]];
    _voicePlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:voiceURL error:nil];
    self.player.numberOfLoops =  0;

    
    NSURL *bgmURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sakura3" ofType:@"mp3"] ];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:bgmURL error:nil];
    self.player.numberOfLoops = -1;
    [self.player play];
    
    
      [self performSelector:@selector(performComplete) withObject:nil afterDelay:9.0];
    
        NSLog(@"タイトルからきた？%d",self.fromTitleView);
    if(self.fromTitleView == YES){
        self.returnGameView.enabled =NO;
        self.returnGameView.alpha = 0.2;
    } else if(self.fromTitleView == NO){
        self.returnGameView.enabled =YES;
        self.returnGameView.alpha = 1.0;
        self.returnTitleView.enabled = NO;
        self.returnTitleView.alpha = 0.2;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.player stop];
    [self.voicePlayer stop];
}

#pragma mark - Public Methods

#pragma mark - Private Methods
-(void)performComplete
{
    [self.voicePlayer play];
    
}

@end
