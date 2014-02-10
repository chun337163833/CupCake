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
+(void) animateClickerForCupcakes:(NSNumber *) cupcakes atPostion: (CGPoint) point andAddItToLayer: (CCLayer *) layer;
+(void) makeLabelInvisible: (NSArray *)arrayOfObjects;
@end
