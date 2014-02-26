//
//  ItemScrollLayer.m
//  CupCake
//
//  Created by Saif Jamil Khan on 2/8/2014.
//  Copyright (c) 2014 SaifKhan. All rights reserved.
//

#import "ItemScrollLayer.h"

@implementation ItemScrollLayer

-(void) addSpriteObject:(CCSprite *) itemToAdd withScale:(float)customScale usingAlreadyAddedArray:(NSMutableArray *) listOfAddedItems nextToButtonIndex:(int) buttonIndex{
    
    int lineNumber = floor(((itemSize +2) * listOfAddedItems.count)/240);
    int itemsOnLine = listOfAddedItems.count % 11;
    
    itemToAdd.position = ccp(itemButtonOffsetX + itemsOnLine * (itemSize + 2), itemButtonOffsetY - itemSize * (lineNumber %2) - itemButtonSeperation * buttonIndex);
    [itemToAdd setScale:customScale];
    
    [self addChild:itemToAdd];
//    [self setPosition:ccp(0,0)];
    [listOfAddedItems addObject:itemToAdd];
    NSLog(@"list %d", listOfAddedItems.count);
    //    CGRect worldBoundary = CGRectMake(0, 0, 360, 360);
    //    [self.itemScrollLayer runAction:[CCFollow actionWithTarget:itemToAdd worldBoundary:worldBoundary]];
}
-(void) makeLabelInvisible: (id)label{
    CCLabelTTF *increaseLabel = label;
    [self removeChild:increaseLabel];
    increaseLabel = nil;
}

-(void)displayCupcakeIncreasedForItem: (items) purchaseItem withAlreadyIncreasedCount: (int) x withAlreadyAddedArray: (NSMutableArray *) alreadyAddedArray byAmount: (NSNumber *) cupcakes{

    int displayedItems = MIN(alreadyAddedArray.count, 22);
    int animatedItemNumberOnLine = x % (displayedItems); //0-21
    int isSecondLine = (animatedItemNumberOnLine >= 11)? 1:0; // 0 -10, 11 - 21
    animatedItemNumberOnLine = animatedItemNumberOnLine - 11 * (isSecondLine);
    [AnimationUtil makeIncreaseLabelForCupcakes:cupcakes atPostion:CGPointMake(itemButtonOffsetX + animatedItemNumberOnLine * (itemSize + 2), itemButtonOffsetY - itemSize * (isSecondLine) - itemButtonSeperation * purchaseItem) andAddItToLayer:self];
    
}

@end
