//
//  YagiView.m
//  YImage
//
//  Created by Genki Ishibashi on 13/09/07.
//  Copyright (c) 2013年 Genki Ishibashi. All rights reserved.
//

#import "YagiView.h"

@implementation YagiView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGPoint fakePoint = CGPointZero;
        yagi_type = @"normal";
        imgFace = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[yagi_type stringByAppendingString:@"_kao.png"]]];
        
        imgBody = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[yagi_type stringByAppendingString:@"_doutai.png"]]];
        imgFrntLeftLeg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[yagi_type stringByAppendingString:@"_maeashi.png"]]];
        imgFrntRightLeg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[yagi_type stringByAppendingString:@"_maeashi2.png"]]];
        imgBackLeftLeg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[yagi_type stringByAppendingString:@"_ushiroashi.png"]]];
        imgBackRightLeg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[yagi_type stringByAppendingString:@"_ushiroashi2.png"]]];
        imgTarai = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tarai.png"]];
        imgKamikuzu = [[UIImageView alloc] initWithFrame:CGRectMake(fakePoint.x, fakePoint.y, 20, 20)];
        imgKamikuzu.image = [UIImage imageNamed:@"kamikuzu.png"];
        
        imgYokoFace = [UIImage imageNamed:[yagi_type stringByAppendingString:@"_yoko.png"]];
        imgMaeFace = [UIImage imageNamed:[yagi_type stringByAppendingString:@"_kao.png"]];
        imgGakkariFace = [UIImage imageNamed:[yagi_type stringByAppendingString:@"_hukigen.png"]];
        imgMgmg = [UIImage imageNamed:[yagi_type stringByAppendingString:@"_mgmg.png"]];
        imgPaku = [UIImage imageNamed:[yagi_type stringByAppendingString:@"_a.png"]];
        imgKaoTrai = [UIImage imageNamed:[yagi_type stringByAppendingString:@"_tarai.png"]];
        
        CGRect setRect;
        if ([yagi_type isEqualToString:@"real"]) {
            setRect = CGRectMake(0, 0, 29, 223);
            imgFrntRightLeg.contentMode = UIViewContentModeBottom ;
            imgFrntLeftLeg.contentMode = UIViewContentModeBottom ;
            imgBackRightLeg.contentMode = UIViewContentModeBottom ;
            imgBackLeftLeg.contentMode = UIViewContentModeBottom ;
        } else {
            setRect = CGRectMake(0, 0, 29, 113);
        }

        imgFrntRightLeg.frame = setRect;
        imgFrntLeftLeg.frame = setRect;
        imgBackRightLeg.frame = setRect;
        imgBackLeftLeg.frame = setRect;

        
    
        
        if ([yagi_type isEqualToString:@"normal"]){
            imgFace.center = CGPointMake(62, 74);
            imgBody.center = CGPointMake(144, 120);
            imgFrntRightLeg.center = CGPointMake(108, 153);
            imgFrntLeftLeg.center = CGPointMake(130, 157);
            imgBackRightLeg.center = CGPointMake(170, 154);
            imgBackLeftLeg.center = CGPointMake(190, 152);
            imgKamikuzu.center = CGPointMake(200, 150);
            imgTarai.center = CGPointMake(57.5, -104);
        } else if ([yagi_type isEqualToString:@"real"]) {
            imgFace.center = CGPointMake(62, 74);
            imgBody.center = CGPointMake(144, 120);
            imgFrntRightLeg.center = CGPointMake(108, 113);
            imgFrntLeftLeg.center = CGPointMake(130, 127);
            imgBackRightLeg.center = CGPointMake(170, 104);
            imgBackLeftLeg.center = CGPointMake(205, 132);
            imgKamikuzu.center = CGPointMake(200, 150);
            imgTarai.center = CGPointMake(57.5, -104);

        }

        imgTarai.alpha = 0.0;
        
        //最初にどっちに動かすかの設定
        imgFrntRightLeg.tag = 1;
        imgBackRightLeg.tag = 1;
        
        //顔のフラグ
        kaoFlag = 0;
        kaisuu = 0;
        
        [self addSubview:imgKamikuzu];
        [self addSubview:imgBackRightLeg];
        [self addSubview:imgFrntRightLeg];
        [self addSubview:imgBody];
        [self addSubview:imgBackLeftLeg];
        [self addSubview:imgFrntLeftLeg];
        [self addSubview:imgFace];
        [self addSubview:imgTarai];
        
        //音の準備
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tarai" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)url, &soudID);
        
        NSString *path2 = [[NSBundle mainBundle] pathForResource:@"paper" ofType:@"wav"];
        NSURL *url2 = [NSURL fileURLWithPath:path2];
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)url2, &paperSound);
        
        NSString *path3 = [[NSBundle mainBundle] pathForResource:@"yagi" ofType:@"wav"];
        NSURL *url3 = [NSURL fileURLWithPath:path3];
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)url3, &yagiSound);
    }
    return self;
}
- (void)walk
{
    [self walkRotation:imgFrntRightLeg];
    [self walkRotation:imgFrntLeftLeg];
    [self walkRotation:imgBackLeftLeg];
    [self walkRotation:imgBackRightLeg];
    
}

- (void)stopWalk:(BOOL)hukigen
{
    imgFrntRightLeg.tag = 2;
    imgFrntLeftLeg.tag = 2;
    imgBackLeftLeg.tag = 2;
    imgBackRightLeg.tag = 2;
    

    AudioServicesPlaySystemSound(yagiSound);
    if (hukigen == YES) {
        imgFace.image = imgGakkariFace;
    }else{
        imgFace.image = imgMaeFace;
    }
}

- (void)walkRestart
{
    imgFrntRightLeg.tag = 0;
    imgFrntLeftLeg.tag = 1;
    imgBackLeftLeg.tag = 0;
    imgBackRightLeg.tag = 1;
    imgFace.image = imgYokoFace;
    [self walk];
    
}



#pragma mark - 食べる

#define kutiakeruTime 1
#define mogKurikaesi 7
#define mogKankaku 0.5
- (void)eatFood
{
    imgFace.image = imgPaku;
    [self performSelector:@selector(mogmog) withObject:nil afterDelay:kutiakeruTime];
    AudioServicesPlaySystemSound(paperSound);
    
}

- (void)mogmog
{
    [timer invalidate];
    kaisuu = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:mogKankaku
                                             target:self
                                           selector:@selector(repeatMog)
                                           userInfo:nil
                                            repeats:YES];
    
    
             
}

- (void)repeatMog
{
    switch (kaoFlag) {
        case 0:
            imgFace.image = imgMgmg;
            kaoFlag = 1;
            kaisuu++;
            break;
            
        case 1:
            
            imgFace.image = imgMaeFace;
            kaoFlag = 0;
            kaisuu++;
            break;
            
        default:
            break;
    }
    
    if (kaisuu == mogKurikaesi)
    {
        [timer invalidate];
        imgFace.image = imgYokoFace;
        kaisuu = 0;
    }
    
}


             
#pragma mark -
#define rad M_PI/180
- (void)walkRotation:(UIImageView *)imgView
{
    if (imgView.tag == 0) {
        [UIView animateWithDuration:2
                              delay:0.2
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             imgView.transform = CGAffineTransformMakeRotation(10 * rad);
                         }
                         completion:^(BOOL finished){
                             
                             if (imgView.tag == 2) return ;
                             imgView.tag = 1;
                             [self walkRotation:imgView];
                             
                         }];
    }else if(imgView.tag == 1){
        [UIView animateWithDuration:2
                              delay:0.2
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void){
                             imgView.transform = CGAffineTransformMakeRotation(-10 * rad);
                         }
                         completion:^(BOOL finished){
                             if (imgView.tag == 2) return ;
                             imgView.tag = 0;
                             [self walkRotation:imgView];
                         }];
    }
}

- (void)dischargeWord
{
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:0.5 animations:^(void){
        CGPoint fallPoint = imgKamikuzu.center;
        fallPoint.y += 40;
        imgKamikuzu.center = fallPoint;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:2.0
                         animations:^(void){
                             CGPoint movePoint = imgKamikuzu.center;
                             movePoint.x += 100;
                             imgKamikuzu.center = movePoint;
                         } completion:^(BOOL finished){
                             imgKamikuzu.center = CGPointMake(200, 150);
                         }];
    }];
}

- (void)allFoget
{
    imgTarai.alpha = 1.0;
    [UIView animateWithDuration:0.4 animations:^(void){
        imgTarai.center = CGPointMake(imgFace.center.x , imgFace.center.y - 50);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.4 animations:^(void){
            AudioServicesPlaySystemSound(soudID);
            imgFace.image = imgKaoTrai;
            CGPoint endPoint = imgTarai.center;
            endPoint.x += 60;
            endPoint.y -= 20;
            imgTarai.center = endPoint;
            imgTarai.transform = CGAffineTransformMakeRotation(45 * M_PI / 180);
            [UIView animateWithDuration:1.0 animations:^(void){
                imgTarai.alpha = 0.0;
            }completion:^(BOOL finished){                
                imgTarai.transform = CGAffineTransformIdentity;
                imgTarai.center = CGPointMake(57.5, -104);
                imgFace.image = imgYokoFace;
            }];
        } completion:^(BOOL finished){

        }];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
