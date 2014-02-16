//
//  AnimationUtil.h
//  CupCake
//
//  Created by Saif Jamil Khan on 2/9/2014.
//  Copyright (c) 2014 SaifKhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class AnimationUtil;

@interface AnimationUtil : NSObject;
+(void)makeIncreaseLabelForCupcakes:(NSNumber *) cupcakes atPostion: (CGPoint) point andAddItToLayer: (CCLayer *) layer;
+(void) animateClickerForButton: (CCMenuItemSprite *) button inMenu: (CCMenu *) menu withClicker: (CCSprite *) clicker withCupcakes:(NSNumber *) cupcakes inLayer: (CCLayer *) layer;
+(void) makeLabelInvisible: (NSArray *)arrayOfObjects;
+(void) shakeButton: (NSArray*)arrayOfObjects;
+(void) makeLabelIncreaseForClickerWith: (NSArray *) arrayOfObjects;
@end
