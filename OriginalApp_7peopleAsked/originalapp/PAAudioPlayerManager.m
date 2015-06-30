//
//  PAAudioPlayerManager.m
//  originalapp_7peopleasked
//
//  Created by 平山　亮 on 2015/06/30.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import "PAAudioPlayerManager.h"

@interface PAAudioPlayerManager()

//サウンドオブジェクトのコンテナを用意
@property (nonatomic,strong) NSMutableDictionary *players;

@end

@implementation PAAudioPlayerManager

#pragma mark - Public Methods
+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class]alloc]init];
    });
    return sharedInstance;
}

//サウンドオブジェクトの生成（URL）
- (AVAudioPlayer *)createPlayerWithURL:(NSURL *)url forKey:(NSString *)key
{
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    
    //コンテナにセット
    if (key){
        self.players[key] = player;
    }
    return player;
}

//サウンドオブジェクトの生成（URL文字列）
- (AVAudioPlayer *)createPlayerWithURLString:(NSString *)urlString forKey:(NSString *)key
{
    NSURL *url = [NSURL fileURLWithPath:urlString];
    return [self createPlayerWithURL:url forKey:key];
}

//サウンドオブジェクトの生成（ファイル名）
- (AVAudioPlayer *)createPlayerWithFileName:(NSString *)fileName forKey:(NSString *)key
{
    NSString *pathString = [[NSBundle mainBundle]pathForResource:fileName ofType:nil];
    return [self createPlayerWithURLString:pathString forKey:key];
}

//サウンドオブジェクトの生成（ファイル名）、ループ指定
- (AVAudioPlayer *)createPlayerWithFileName:(NSString *)fileName forKey:(NSString *)key loop:(NSInteger)loop
{
    AVAudioPlayer *player = [self createPlayerWithFileName:fileName forKey:key];
    player.numberOfLoops = loop;
    return player;
}

//サウンドオブジェクトの取得
- (AVAudioPlayer *)playerWithKey:(NSString *)key
{
    if (!key){
        return nil;
    }
    return self.players[key];
}

//サウンドオブジェクトの破棄
- (void)deletePlayerWithKey:(NSString *)key
{
    if (!key) {
        return;
    }
    //サウンドを停止
    AVAudioPlayer *player = self.players[key];
    if ([player isPlaying]) {
        [player stop];
        //再生位置を頭から
        player.currentTime = 0;
    }
    [self.players removeObjectForKey:key];
}

//サウンドオブジェクトの全破棄
- (void)deleteAllPlayer
{
    //すべてのサウンドを停止する
    for (AVAudioPlayer *player in self.players){
        if ([player isPlaying]) {
            [player stop];
            //再生位置を頭から
            player.currentTime = 0;
        }
    }
    [self.players removeAllObjects];
}

//サウンドオブジェクトの再生
- (BOOL)playAudioWithKey:(NSString *)key
{
    AVAudioPlayer *player = [self playerWithKey:key];
    return [player play];
}

//サウンドオブジェクトの停止
- (void)stopAudioWithKey:(NSString *)key
{
    AVAudioPlayer *
}

//サウンドオブジェクトの音量をフェイドアウトさせて消す
- (void)fadeOutAudioWithKey:(NSString *)key
{
    
}

#pragma mark - Private Methods
//playerコンテナの取得

@end
