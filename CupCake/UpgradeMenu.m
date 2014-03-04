//
//  UpgradeMenu.m
//  CupCakeClicker
//
//  Created by Saif Jamil Khan on 3/3/2014.
//  Copyright (c) 2014 SaifKhan. All rights reserved.
//

#import "UpgradeMenu.h"
#import "cocos2d.h"
#import "CCScrollLayer.h"
@implementation UpgradeMenu
-(id) initWithReference:(id)gameLayer{
    if( (self=[super init]) ) {
        self.gameLayerReference = gameLayer;
        [self setUpBackgroundAndButtons];
        [self addItemSliders];
    }
	return self;
}

-(void) setUpBackgroundAndButtons{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *background = [CCSprite spriteWithFile:@"CloudUpgradesBackground.png"];
    [background setScale:1.05f];
    background.position = ccp(winSize.width/2, -winSize.height/2);
    [self addChild:background];
    
    CCMenuItemFont *closeButton = [CCMenuItemFont itemWithString:@"X" target:self.gameLayerReference selector:@selector(hideUpgradesLayer)];
    [closeButton setFontSize:25];
    [closeButton setColor:ccc3(10, 0, 0)];
    closeButton.position = ccp(0, 0);
    CCMenu *menuForCloseButton = [CCMenu menuWithItems:closeButton, nil];
    menuForCloseButton.position = ccp(winSize.width - 40, -40);
    [self addChild:menuForCloseButton];
}

-(void) addItemSliders{
    NSMutableArray *arrayOfClickerUpgradeLayers = [[NSMutableArray alloc] init];
    for(int x = 0; x < 10; x++){
        CCMenuItemFont *closeButton = [CCMenuItemFont itemWithString:@"X" target:self.gameLayerReference selector:@selector(hideUpgradesLayer)];
        CCLayer *button = [[CCLayer alloc] init];
        [button addChild:[CCSprite spriteWithFile:[NSString stringWithFormat:@"ColoredBox%d", x]]];
         
        [closeButton setFontSize:25];
        [closeButton setColor:ccc3(10, 0, 0)];
        [arrayOfClickerUpgradeLayers addObject:closeButton];
    }
    CCScrollLayer *clickerUpgradesLayer = [[CCScrollLayer alloc] initWithLayers:arrayOfClickerUpgradeLayers widthOffset:0 ];
    [clickerUpgradesLayer setPagesIndicatorNormalColor:ccc4(100, 100, 0, 100)];
    clickerUpgradesLayer.PAGE
    [self addChild:clickerUpgradesLayer];
}

@end
