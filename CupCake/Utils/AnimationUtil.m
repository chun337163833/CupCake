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

+(void)makeIncreaseLabelForCupcakes:(NSNumber *) cupcakes atPostion: (CGPoint) point andAddItToLayer: (CCLayer *) layer{
    CCLabelTTF *increaseLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+%d",[cupcakes intValue]] fontName:@"Arial" fontSize:10.0f];
    
    increaseLabel.position = ccp(point.x,point.y);
    CCMoveBy* slideUpRight = [CCMoveBy actionWithDuration:1 position:ccp(10,10)];
    [self performSelector:@selector(makeLabelInvisible:) withObject:[NSArray arrayWithObjects:increaseLabel, layer, nil] afterDelay:1.0];
    //    CCSequence* sequence = [CCSequence actions: slideUpRight, nil];
    [layer addChild:increaseLabel];
    CCEaseInOut* ease = [CCEaseInOut actionWithAction:slideUpRight rate:4];
    [increaseLabel runAction:ease];
}

+(void) animateClickerForButton: (CCMenuItemSprite *) button inMenu: (CCMenu *) menu withClicker: (CCSprite *) clicker withCupcakes:(NSNumber *) cupcakes inLayer: (CCLayer *) layer{
    CGPoint cupcakePosition = CGPointMake(menu.position.x + button.position.x, menu.position.y + button.position.y);
    CGPoint cursorHitMovement = CGPointMake((cupcakePosition.x - clicker.position.x) * 0.5, (cupcakePosition.y - clicker.position.y)*0.5);
    
    CCMoveBy *slideToMiddle = [CCMoveBy actionWithDuration:1 position:ccp(cursorHitMovement.x, cursorHitMovement.y)];
    CCMoveBy *slideBack = [CCMoveBy actionWithDuration:1 position:ccp(-cursorHitMovement.x, -cursorHitMovement.y)];
    CCSequence* sequence = [CCSequence actions: slideToMiddle,slideBack, nil];
    CCEaseInOut* ease = [CCEaseInOut actionWithAction:sequence rate:4];
    
    [self performSelector:@selector(shakeButton:) withObject:[NSArray arrayWithObjects:button, [NSArray arrayWithObjects:[NSNumber numberWithFloat:cursorHitMovement.x], [NSNumber numberWithFloat:cursorHitMovement.y],nil], menu, clicker, cupcakes, layer, nil] afterDelay:1.0];
    [clicker runAction:ease];
}

+(void) shakeButton: (NSArray*)arrayOfObjects{
    CCMenuItemSprite * button = arrayOfObjects[0];
    NSArray *positionArray = arrayOfObjects[1];
    
    CGPoint point = CGPointMake([(NSNumber *)positionArray[0] intValue], [(NSNumber *)positionArray[1] intValue]);
   
    CCMoveBy* slideBack = [CCMoveBy actionWithDuration:0.25 position:CGPointMake(point.x *0.05, point.y *0.05)];
    CCEaseInOut* easeBack = [CCEaseInOut actionWithAction:slideBack rate:4];
  
    CCMoveBy* slideForward = [CCMoveBy actionWithDuration:0.25 position:CGPointMake(point.x *-0.05, point.y *-0.05)];
    CCEaseInOut* easeForward = [CCEaseInOut actionWithAction:slideForward rate:4];
    
    CCSequence* sequence = [CCSequence actions: easeBack, easeForward, nil];
    [self makeLabelIncreaseForClickerWith:arrayOfObjects];
    [button runAction:sequence];
}

+(void) makeLabelIncreaseForClickerWith: (NSArray *) arrayOfObjects{
    CCMenuItemSprite * button = arrayOfObjects[0];
    CCMenu *menu = arrayOfObjects[2];
    CCSprite *clicker = arrayOfObjects[3];
    NSNumber *cupcakes = arrayOfObjects[4];
    CCLayer *layer = arrayOfObjects[5];
    CGPoint cupcakePosition = CGPointMake(menu.position.x + button.position.x, menu.position.y + button.position.y);
    CGPoint cursorHitMovement = CGPointMake((cupcakePosition.x - clicker.position.x) * 0.5, (cupcakePosition.y - clicker.position.y)*0.5);
    CGPoint increaseLabelPoint = CGPointMake(cupcakePosition.x - cursorHitMovement.x, cupcakePosition.y - cursorHitMovement.y);
    [AnimationUtil makeIncreaseLabelForCupcakes:cupcakes atPostion:increaseLabelPoint andAddItToLayer:layer];
}
+(void) makeLabelInvisible: (NSArray*)arrayOfObjects{
    CCLabelTTF *increaseLabel = arrayOfObjects[0];
    CCLayer *layer = arrayOfObjects[1];
    [layer removeChild:increaseLabel];
    increaseLabel = nil;
}


@end
