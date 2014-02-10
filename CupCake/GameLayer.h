//
//  HelloWorldLayer.h
//  CupCake
//
//  Created by Saif Khan on 10/27/2013.
//  Copyright SaifKhan 2013. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "CupcakesAndGoodThings.h"
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CCScrollLayer.h"
#import "ItemScrollLayer.h"
#import "AnimationUtil.h"
// HelloWorldLayer

@interface GameLayer : CCLayer <CupcakesAndGoodThingsDelegate>
{
    int numberOfTimesCupcakeButtonWasPressed;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
@property (nonatomic, weak) CCMenuItemSprite *cupcakeButton;
@property (nonatomic, weak) CCMenu *cupcakeMenu;
@property (nonatomic, weak) CCMenu *mainMenu;
@property (nonatomic, strong) ItemScrollLayer *itemScrollLayer;
@property (nonatomic, weak) CCLabelBMFont *cupcakeCountLabel;;


@property (strong, nonatomic) NSMutableArray *cursorsAdded;
@property (strong, nonatomic) NSMutableArray *grandmasAdded;
@property (strong, nonatomic) NSMutableArray *factoriesAdded;
@property (strong, nonatomic) NSMutableArray *girlScoutsAdded;
@property (strong, nonatomic) NSMutableArray *ninjasAdded;
@property (strong, nonatomic) NSMutableArray *nationsAdded;
@property (strong, nonatomic) NSMutableArray *portalsAdded;

@property (strong, nonatomic) NSMutableArray *itemsAddedArray;

@property (strong, nonatomic) NSMutableArray *itemCostLabels;
@property (strong, nonatomic) NSMutableArray *itemCountLabels;






@end
