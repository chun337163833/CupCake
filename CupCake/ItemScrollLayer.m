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
    [self setPosition:ccp(0,0)];
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

    int itemsOnLine = alreadyAddedArray.count % 11;
    int animatedItemNumberOnLine = x% 11;
    int lineNumber = ceil((x%alreadyAddedArray.count)/11);
    int maxLineNumber = ceil(alreadyAddedArray.count/11);
    if(lineNumber == maxLineNumber) animatedItemNumberOnLine = animatedItemNumberOnLine% (itemsOnLine+1);
//    [AnimationUtil animateClickerForCupcakes:cupcakes atPostion:CGPointMake(itemButtonOffsetX + animatedItemNumberOnLine * (itemSize + 2), itemButtonOffsetY - itemSize * (lineNumber %2) - itemButtonSeperation * purchaseItem) andAddItToLayer:self];
    [AnimationUtil makeIncreaseLabelForCupcakes:cupcakes atPostion:CGPointMake(itemButtonOffsetX + animatedItemNumberOnLine * (itemSize + 2), itemButtonOffsetY - itemSize * (lineNumber %2) - itemButtonSeperation * purchaseItem) andAddItToLayer:self];
    
}

@end
