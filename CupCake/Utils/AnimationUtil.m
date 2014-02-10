//
//  AnimationUtil.m
//  CupCake
//
//  Created by Saif Jamil Khan on 2/9/2014.
//  Copyright (c) 2014 SaifKhan. All rights reserved.
//

#import "AnimationUtil.h"
#import "cocos2d.h"
@implementation AnimationUtil

+(void) animateClickerForCupcakes:(NSNumber *) cupcakes atPostion: (CGPoint) point andAddItToLayer: (CCLayer *) layer{
    CCLabelTTF *increaseLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+%d",[cupcakes intValue]] fontName:@"Arial" fontSize:10.0f];
    
    increaseLabel.position = ccp(point.x,point.y);
    CCMoveBy* slideUpRight = [CCMoveBy actionWithDuration:1 position:ccp(10,10)];
    [self performSelector:@selector(makeLabelInvisible:) withObject:[NSArray arrayWithObjects:increaseLabel, layer, nil] afterDelay:1.0];
    //    CCSequence* sequence = [CCSequence actions: slideUpRight, nil];
    [layer addChild:increaseLabel];
    CCEaseInOut* ease = [CCEaseInOut actionWithAction:slideUpRight rate:4];
    [increaseLabel runAction:ease];
}

+(void) makeLabelInvisible: (NSArray*)arrayOfObjects{
    CCLabelTTF *increaseLabel = arrayOfObjects[0];
    CCLayer *layer = arrayOfObjects[1];
    [layer removeChild:increaseLabel];
    increaseLabel = nil;
}

@end
