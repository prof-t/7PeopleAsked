//
//  PAAudioPlayerManager.m
//  originalapp_7peopleasked
//
//  Created by 平山　亮 on 2015/06/30.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import "PAAudioPlayerManager.h"


@implementation PAAudioPlayerManager

//サウンドオブジェクトの生成（URL）
- (AVAudioPlayer *)createPlayerWithURL:(NSURL *)url forKey:(NSString *)key
{
    
}

//サウンドオブジェクトの生成（URL文字列）
- (AVAudioPlayer *)createPlayerWithURLString:(NSString *)urlString forKey:(NSString *)key
{
    
}

//サウンドオブジェクトの生成（ファイル名）
- (AVAudioPlayer *)createPlayerFileName:(NSString *)fileName forKey:(NSString *)key
{
    
}

//サウンドオブジェクトの生成（ファイル名）、ループ指定
- (AVAudioPlayer *)createPlayerWithFileName:(NSString *)fileName forKey:(NSString *)key loop:(NSInteger)loop
{
    
}

//サウンドオブジェクトの取得
- (AVAudioPlayer *)playerWithKey:(NSString *)key
{
    
}

//サウンドオブジェクトの破棄
- (void)delatePlayerWithKey:(NSString *)key
{
    
}

//サウンドオブジェクトの全破棄
- (void)deleteAllPlayer
{
    
}

//サウンドオブジェクトの再生
- (BOOL)playAudioWithKey:(NSString *)key
{
    
}

//サウンドオブジェクトの停止
- (void)stopAudioWithKey:(NSString *)key
{
    
}

//サウンドオブジェクトの音量をフェイドアウトさせて消す
- (void)fadeOutAudioWithKey:(NSString *)key
{
    
}


@end
