//
//  CharaCreateView.h
//  OriginalApp(卒業制作)
//
//  Created by 平山亮 on 2015/02/24.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"CharacterStatus.h"
#import"ConnectModeSelectView.h"
#import"TitleScreenView.h"
#import<AVFoundation/AVFoundation.h>

@interface CharaCreateView : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView* _pickerView;
    NSMutableArray* _items;
    NSInteger _selectIdx;
    
//自分のキャラデータを格納する変数
    CharacterStatus *_myStatus;
    
    NSString *test;
    

}

@property AVAudioPlayer *player;
@property AVAudioPlayer *voicePlayer;
@end
