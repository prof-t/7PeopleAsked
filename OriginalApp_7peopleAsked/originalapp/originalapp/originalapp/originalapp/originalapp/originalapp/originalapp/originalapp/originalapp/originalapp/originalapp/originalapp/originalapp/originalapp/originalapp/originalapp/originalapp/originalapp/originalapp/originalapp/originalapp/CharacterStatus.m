//
//  CharacterStatus.m
//  OriginalApp(卒業制作)
//
//  Created by RYO on 2015/03/01.
//  Copyright (c) 2015年 平山亮. All rights reserved.
//

#import "CharacterStatus.h"

@implementation CharacterStatus

-(UIImage*)trimIMG:(int)number
{
    // 切り抜き元となる画像を用意する。
    UIImage *srcImage = [UIImage imageNamed:@"μ's1.gif"];
    int imageW = srcImage.size.width;
    int imageH = srcImage.size.height;
    
    NSLog(@"imageW%d",imageW);
    NSLog(@"imageH%d",imageH);
    
    // 切り抜く位置を指定するCGRectを作成する。
    // 今回は、画像の中心部分を320×320で切り取る例。
    // なお簡略化のため、imageW,imageHともに320以上と仮定する。
    CGRect trimArea;
    
    if(number == 1){
        
        int honokaX = (imageW - 580) / 2;
        int honokaY = (imageH - 580) / 2;
        trimArea = CGRectMake(honokaX, honokaY, 200, 200);
        
    } else if (number == 2){
        
        int eriX = (imageW - 190) / 2;
        int eriY = (imageH + 190) / 2;
        trimArea = CGRectMake(eriX, eriY, 200, 200);
        
    } else if (number == 3){
        
        int kotoriX = (imageW - 190) / 2;
        int kotoriY = (imageH - 580) / 2;
        trimArea = CGRectMake(kotoriX, kotoriY, 200, 200);
        
    } else if(number == 4){
        
        int umiX = (imageW + 190) / 2;
        int umiY = (imageH - 580) / 2;
        trimArea = CGRectMake(umiX, umiY, 200, 200);
        
    } else if(number == 5){
        
        int rinX = (imageW - 580) / 2;
        int rinY = (imageH - 180) / 2;
        trimArea = CGRectMake(rinX, rinY, 200, 200);
        
    } else if (number == 6){
        
        int hanayoX = (imageW - 190) / 2;
        int hanayoY = (imageH - 190) / 2;
        trimArea = CGRectMake(hanayoX, hanayoY, 200, 200);
        
    } else if (number == 7){
        
        int makiX = (imageW + 190) / 2;
        int makiY = (imageH - 190) / 2;
        trimArea = CGRectMake(makiX, makiY, 200, 200);
        
    } else if(number == 8){
        
        int nicoX = (imageW - 580) / 2;
        int nicoY = (imageH + 190) / 2;
        trimArea = CGRectMake(nicoX, nicoY, 200, 200);
        
    } else if (number == 9){
        
        int nozomiX = (imageW + 190) / 2;
        int nozomiY = (imageH + 190) / 2;
        trimArea = CGRectMake(nozomiX, nozomiY, 200, 200);
        
    }
    
    

    
    // CoreGraphicsの機能を用いて、
    // 切り抜いた画像を作成する。
    CGImageRef srcImageRef = [srcImage CGImage];
    CGImageRef trimmedImageRef = CGImageCreateWithImageInRect(srcImageRef, trimArea);
    UIImage *trimmedImage = [UIImage imageWithCGImage:trimmedImageRef];
    
    return trimmedImage;
}

-(UIWebView*)makeWebView:(NSString*)image rect:(CGRect)rect
{
    NSData *gifData = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:image]];
    UIWebView *animationGifView = [[UIWebView alloc] initWithFrame:rect];
    animationGifView.scalesPageToFit = YES;
    [animationGifView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"utf-8" baseURL:nil];
    
    return animationGifView;
}


-(UIWebView*)trimIMGView:(int)number
{

    // 切り抜き元となる画像を用意する。
//    UIImage *srcImage = [UIImage imageNamed:@"μ's1.gif"];
        UIImage *srcImage = [UIImage imageNamed:@"tou_komachi_k.gif"];
    int imageW = srcImage.size.width;
    int imageH = srcImage.size.height;
    NSLog(@"%d %d",imageW,imageH);
    
    // 切り抜く位置を指定するCGRectを作成する。
    // 今回は、画像の中心部分を320×320で切り取る例。
    // なお簡略化のため、imageW,imageHともに320以上と仮定する。
    CGRect trimArea;
    
    if(number == 1){
        
        int honokaX = (imageW - 580) / 2;
        int honokaY = (imageH - 580) / 2;
        trimArea = CGRectMake(honokaX, honokaY, 200, 200);
        
    } else if (number == 2){
        
        int eriX = (imageW - 190) / 2;
        int eriY = (imageH + 190) / 2;
        trimArea = CGRectMake(eriX, eriY, 200, 200);
        
    } else if (number == 3){
        
        int kotoriX = (imageW - 190) / 2;
        int kotoriY = (imageH - 580) / 2;
        trimArea = CGRectMake(kotoriX, kotoriY, 200, 200);
        
    } else if(number == 4){
        
        int umiX = (imageW + 190) / 2;
        int umiY = (imageH - 580) / 2;
        trimArea = CGRectMake(umiX, umiY, 200, 200);
        
    } else if(number == 5){
        
        int rinX = (imageW - 580) / 2;
        int rinY = (imageH - 180) / 2;
        trimArea = CGRectMake(rinX, rinY, 200, 200);
        
    } else if (number == 6){
        
        int hanayoX = (imageW - 190) / 2;
        int hanayoY = (imageH - 190) / 2;
        trimArea = CGRectMake(hanayoX, hanayoY, 200, 200);
        
    } else if (number == 7){
        
        int makiX = (imageW + 190) / 2;
        int makiY = (imageH - 190) / 2;
        trimArea = CGRectMake(makiX, makiY, 200, 200);
        
    } else if(number == 8){
        
        int nicoX = (imageW - 580) / 2;
        int nicoY = (imageH + 190) / 2;
        trimArea = CGRectMake(nicoX, nicoY, 200, 200);
        
    } else if (number == 9){
        
        int nozomiX = (imageW + 190) / 2;
        int nozomiY = (imageH + 190) / 2;
        trimArea = CGRectMake(nozomiX, nozomiY, 200, 200);
        
    }
    
    CGImageRef srcImageRef = [srcImage CGImage];
    CGImageRef trimmedImageRef = CGImageCreateWithImageInRect(srcImageRef, trimArea);
    UIImage *trimmedImage = [UIImage imageWithCGImage:trimmedImageRef];

    
    UIWebView *animationGifView = [[UIWebView alloc] initWithFrame:CGRectMake(100, 100, 100, 80)];
    
//    [animationGifView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"utf-8" baseURL:nil];
    

    
    // CoreGraphicsの機能を用いて、
    // 切り抜いた画像を作成する。
//    CGImageRef srcImageRef = [srcImage CGImage];
//    CGImageRef trimmedImageRef = CGImageCreateWithImageInRect(srcImageRef, trimArea);
//    UIImage *trimmedImage = [UIImage imageWithCGImage:trimmedImageRef];
    
    return animationGifView;
}


@end
