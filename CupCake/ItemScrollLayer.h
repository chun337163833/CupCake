//
//  ItemScrollLayer.h
//  CupCake
//
//  Created by Saif Jamil Khan on 2/8/2014.
//  Copyright (c) 2014 SaifKhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CupcakesAndGoodThings.h"
#import "AnimationUtil.h"
static float itemSize = 20.0f;
static float itemButtonOffsetY = 285.0f;
static float itemButtonOffsetX = 85.0f;
static float itemButtonSeperation = 40.0f;
@interface ItemScrollLayer : CCLayer{
}

-(void) addSpriteObject:(CCSprite *) itemToAdd withScale:(float)customScale usingAlreadyAddedArray:(NSMutableArray *) listOfAddedItems nextToButtonIndex:(int) buttonIndex;
-(void)displayCupcakeIncreasedForItem: (items) purchaseItem withAlreadyIncreasedCount: (int) x withAlreadyAddedArray: (NSMutableArray *) alreadyAddedArray byAmount: (NSNumber *) cupcakes;


@end
