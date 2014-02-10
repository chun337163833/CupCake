//
//  HelloWorldLayer.m
//  CupCake
//
//  Created by Saif Khan on 10/27/2013.
//  Copyright SaifKhan 2013. All rights reserved.
//


// Import the interfaces
#import "GameLayer.h"
#import "CCScrollLayer.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "ItemScrollLayer.h"
#import "AnimationUtil.h"
#define IPHONE_SCREEN_CENTER 160.0f
#define CURSOR_RADIUS 75.0f
#define CURSOR_SIZE 25.0f
#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation GameLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        [CupcakesAndGoodThings initialize];
        [[CupcakesAndGoodThings sharedInstance] setDelegate:self];
        [self addBackground];
        [self setUpItemScrollView];
        [self setUpMenu];
        [self setUpCupcakeButton];
        [self setUpMisc];
        [self setUpArrays];
    }
	return self;
}

#pragma mark setups
-(void) addBackground{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *background = [CCSprite spriteWithFile:@"sky_without_clouds.png"];
    [background setScale:3.0f];
    background.position = ccp(winSize.width/2, 50+winSize.height/2);
    [self addChild:background];
    
    CCSprite *background2 = [CCSprite spriteWithFile:@"sky_background_with_clouds.png"];
    [background2 setScale:3.0f];
    background2.position = ccp(winSize.width/2, 50+winSize.height/2);
    [self addChild:background2];
    
}


-(void)setUpMenu{
    [CCMenuItemFont setFontSize:15];
    
    CCMenuItem *clickerButton = [CCMenuItemFont itemWithString:@"Clicker" target:self selector:@selector(menuButtonClicked:)];
    clickerButton.position = ccp(0,200);
    clickerButton.tag = clicker;
    
    CCMenuItem *girlScoutButton = [CCMenuItemFont itemWithString:@"GirlScout" target:self selector:@selector(menuButtonClicked:)];

    girlScoutButton.position = ccp(0,200 - itemButtonSeperation * girlScout);
    girlScoutButton.tag = girlScout;
    
    CCMenuItem *grandmaButton = [CCMenuItemFont itemWithString:@"Grandma" target:self selector:@selector(menuButtonClicked:)];

    grandmaButton.position = ccp(0,200 - itemButtonSeperation * grandma);
    grandmaButton.tag = grandma;
    
    CCMenuItem *ninjaButton = [CCMenuItemFont itemWithString:@"Ninja" target:self selector:@selector(menuButtonClicked:)];
    ninjaButton.position = ccp(0,200 - itemButtonSeperation * ninja);
    ninjaButton.tag = ninja;
    
    CCMenuItem *factoryButton = [CCMenuItemFont itemWithString:@"Factory" target:self selector:@selector(menuButtonClicked:)];
    
    factoryButton.position = ccp(0,200 - itemButtonSeperation * factory);
    factoryButton.tag = factory;
    
    CCMenuItem *planetButton = [CCMenuItemFont itemWithString:@"Planet" target:self selector:@selector(menuButtonClicked:)];
    planetButton.position = ccp(0, 200 - itemButtonSeperation * nation);
    planetButton.tag = nation;
    
    CCMenuItem *portalButton = [CCMenuItemFont itemWithString:@"Portal" target:self selector:@selector(menuButtonClicked:)];
    portalButton.position = ccp(0, 200 - itemButtonSeperation * portal);
    portalButton.tag = portal;
    
    
    self.mainMenu = [CCMenu menuWithItems:clickerButton, girlScoutButton, grandmaButton, ninjaButton, factoryButton, planetButton, portalButton, nil];
    
    [self.mainMenu setPosition:ccp(40, self.mainMenu.position.y -200)];
    [self addChild:self.mainMenu];
    [self addChild:[self createMenuLabels]];
}

- (void)setCostAndCountValues:(int)item {
    NSNumber *numberOfItems = [[CupcakesAndGoodThings sharedInstance] itemArray][item] ;
    if(numberOfItems == 0) return;
    NSNumber *costOfItems = [[CupcakesAndGoodThings sharedInstance] costArray][item] ;
    
    CCLabelTTF *numberOfItemsLabel  = self.itemCountLabels[item];
    [numberOfItemsLabel setString:[NSString stringWithFormat:@"x%d", numberOfItems.intValue]];
    
    CCLabelTTF *costOfItemsLabels  = self.itemCostLabels[item];
    [costOfItemsLabels setString:[NSString stringWithFormat:@"%d", -1 * costOfItems.intValue]];
}

-(void) menuButtonClicked:(CCMenuItem*)item {
    [[CupcakesAndGoodThings sharedInstance] incrementItem:item.tag];
    [self incrementMenuViewItems:item.tag];
    [self setCostAndCountValues:item.tag];

}

- (CCLayer*) createMenuLabels{
 
    CCLayer* items = [[CCLayer alloc] init];
    self.itemCountLabels= [[NSMutableArray alloc] init];
    self.itemCostLabels= [[NSMutableArray alloc] init];

    for(int x = 0; x < numObjects; x ++){
        NSNumber *costOfItem = [[CupcakesAndGoodThings sharedInstance] costArray][x] ;
        
        CCLabelTTF *itemLabel  = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",-1 * costOfItem.intValue] fontName:@"Arial" fontSize:13.0f];
        [itemLabel setPosition:ccp(40,260 - itemButtonSeperation * x)];
        [itemLabel setColor:(ccc3(255, 105, 180))];
        [self.itemCostLabels addObject:itemLabel];
        [items addChild:itemLabel];
        
        NSNumber *numberOfItems = [[CupcakesAndGoodThings sharedInstance] itemArray][x];
        NSString *countString = @"";
        if(numberOfItems.intValue > 0)[NSString stringWithFormat:@"x%d", numberOfItems.intValue];
        CCLabelTTF *numberOfItemsLabel  = [CCLabelTTF labelWithString:countString fontName:@"Arial" fontSize:13.0f];
        [numberOfItemsLabel setPosition:ccp(65,280 - itemButtonSeperation * x)];
        [numberOfItemsLabel setColor:(ccc3(45, 136, 206))];
        [self.itemCountLabels addObject:numberOfItemsLabel];
        [items addChild:numberOfItemsLabel];
    }
    return items;
}

-(void)setUpCupcakeButton{
    
    self.cupcakeButton = [CCMenuItemImage itemWithNormalImage:@"cupCakeClearBitten0.png" selectedImage:@"cupCakeClearBitten0.png" target:self selector:@selector(cupcakeButtonPressed)];
    
    self.cupcakeButton.position = ccp(0, 160);
    [self.cupcakeButton setScale:0.18];
    
    self.cupcakeMenu = [CCMenu menuWithItems:self.cupcakeButton, nil];
    [self addChild:self.cupcakeMenu];
}

-(void) setUpMisc{
    self.cupcakeCountLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[[CupcakesAndGoodThings sharedInstance] cupcakes] intValue]] fontName:@"Arial" fontSize:30.0f];
    CCLabelTTF *cupcakeIcon = [CCLabelTTF labelWithString:@"🍥" fontName:@"Arial" fontSize:30.0f];
    
    [cupcakeIcon setColor:(ccc3(255, 105, 180))];
    
    [self.cupcakeCountLabel setPosition:ccp(160,535)];
    [self addChild:self.cupcakeCountLabel];
    [cupcakeIcon setPosition:ccp(110,535)];
//    [self addChild:cupcakeIcon];
}

-(void) setUpArrays{
    
    if(!self.cursorsAdded) self.cursorsAdded = [[NSMutableArray alloc] init];
    if(!self.grandmasAdded) self.grandmasAdded = [[NSMutableArray alloc] init];
    if(!self.girlScoutsAdded) self.girlScoutsAdded = [[NSMutableArray alloc] init];
    if(!self.ninjasAdded) self.ninjasAdded = [[NSMutableArray alloc] init];
    if(!self.factoriesAdded) self.factoriesAdded = [[NSMutableArray alloc] init];
    if(!self.nationsAdded) self.nationsAdded = [[NSMutableArray alloc] init];
    if(!self.portalsAdded) self.portalsAdded = [[NSMutableArray alloc] init];
    if(!self.itemsAddedArray) self.itemsAddedArray = [[NSMutableArray alloc] init];
    [self.itemsAddedArray addObjectsFromArray:[NSArray arrayWithObjects:self.cursorsAdded,self.girlScoutsAdded,self.grandmasAdded,self.ninjasAdded,self.factoriesAdded, self.nationsAdded, self.portalsAdded, nil]];
}

#pragma mark cupcake button

-(void) cupcakeButtonPressed{
    NSNumber *clickerIncrease =[[CupcakesAndGoodThings sharedInstance] increaseArray][clicker];
    
    [[CupcakesAndGoodThings sharedInstance] increaseCupcakesBy:[NSNumber numberWithInt: clickerIncrease.intValue] asUserClick:YES];
    NSLog(@"%d", [[[CupcakesAndGoodThings sharedInstance] cupcakes]intValue]);
    [self cycleCupcakeButton];
}
-(void) cycleCupcakeButton{
    
    numberOfTimesCupcakeButtonWasPressed++;
    CCSprite *normalImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"cupCakeClearBitten%d.png",(int)floor((numberOfTimesCupcakeButtonWasPressed%40)/10)]];
    CCSprite *selectedImage = [CCSprite spriteWithFile:[NSString stringWithFormat:@"cupCakeClearBitten%d.png",(int)floor((numberOfTimesCupcakeButtonWasPressed%40)/10)] ];
    [selectedImage setScale:0.8f];
    
    [self.cupcakeButton setNormalImage:normalImage];
    [self.cupcakeButton setSelectedImage:selectedImage];
    [selectedImage setPosition:normalImage.position];
    
    [selectedImage setPosition:ccp(selectedImage.boundingBox.size.width/10, selectedImage.boundingBox.size.width/10)];

}

#pragma mark Item Scroll View
-(void) setUpItemScrollView{
    self.itemScrollLayer = [[ItemScrollLayer alloc] init];
    [self addChild:self.itemScrollLayer];
}


#pragma mark adding view items

-(void)addCursor{
    if(!self.cursorsAdded){
        self.cursorsAdded= [[NSMutableArray alloc] init];
    }
    
    for(int y = 0; y < self.cursorsAdded.count; y++){
        [self removeChild:[self.cursorsAdded objectAtIndex:y] cleanup:YES];
    }
    
    [self.cursorsAdded removeAllObjects];
    NSNumber *clickers = [[CupcakesAndGoodThings sharedInstance] itemArray][clicker];
    float radiansToIncease = (2*M_PI)/clickers.floatValue;
    
    for(int x = 0; x < clickers.intValue; x++ ){
        
        CCSprite *cursorImage = [[CCSprite alloc] initWithFile:@"cursor.png"];
        
        cursorImage.position = ccp( IPHONE_SCREEN_CENTER + (CURSOR_RADIUS *cos(radiansToIncease *x)),
                                 [self.cupcakeButton convertToWorldSpace:CGPointZero].y + self.cupcakeButton.boundingBox.size.height/2 + CURSOR_RADIUS *sin(radiansToIncease * x));
        cursorImage.rotation = CC_RADIANS_TO_DEGREES(0.409 - (radiansToIncease *x) - M_PI/2);
        [cursorImage setScale:0.1f];
        [self addChild:cursorImage];
        [self.cursorsAdded addObject:cursorImage];
    }
}

-(void) incrementMenuViewItems:(int) itemIndex {
    if(itemIndex == clicker) {
        [self addCursor];
        return;
    }
    
    NSMutableArray *listOfAlreadyAddedItems;
    NSNumber *numberOfItems;
    CCSprite *itemSprite;
    float customScale =1;
    
    numberOfItems = [[CupcakesAndGoodThings sharedInstance] itemArray][itemIndex];
    if(numberOfItems.intValue <= 0) return;
    
    switch(itemIndex){
           case girlScout:
            customScale = 0.25f;
            itemSprite = [[CCSprite alloc] initWithFile:@"girlWithCupcake.png"];
            break;
        case grandma:
            customScale = 0.125f;
            itemSprite = [[CCSprite alloc] initWithFile:@"grandma.png"];
            break;
        case ninja:
            customScale = 1.19f;
            itemSprite = [[CCSprite alloc] initWithFile:@"ninjaDown.png"];
            break;
        case factory:
            customScale = 0.22f;
            itemSprite = [[CCSprite alloc] initWithFile:@"factory.png"];
            break;
        case nation:
            customScale = 0.1f;
            itemSprite = [[CCSprite alloc] initWithFile:@"nationIcon.png"];
            break;
        case portal:
            customScale = 0.06f;
            itemSprite = [[CCSprite alloc] initWithFile:@"portal.png"];
            break;
        default:
            return;
    }
    listOfAlreadyAddedItems = self.itemsAddedArray[itemIndex];
    [self.itemScrollLayer addSpriteObject:itemSprite withScale: customScale usingAlreadyAddedArray:listOfAlreadyAddedItems nextToButtonIndex:itemIndex];
}
#pragma mark Animations
-(void) animateClickerWithAlreadyIncreasedCount:(int)x withIncreaseAmount: (NSNumber *)cupcakes{
    CCSprite *cursor = self.cursorsAdded[x%self.cursorsAdded.count];
    CGPoint cupcakePosition = CGPointMake(self.cupcakeMenu.position.x + self.cupcakeButton.position.x, self.cupcakeMenu.position.y + self.cupcakeButton.position.y);
    CGPoint cursorHitMovement = CGPointMake((cupcakePosition.x - cursor.position.x) * 0.5, (cupcakePosition.y - cursor.position.y)*0.5);
    
    CCMoveBy *slideToMiddle = [CCMoveBy actionWithDuration:1 position:ccp(cursorHitMovement.x, cursorHitMovement.y)];
    CCMoveBy *slideBack = [CCMoveBy actionWithDuration:1 position:ccp(-cursorHitMovement.x, -cursorHitMovement.y)];
    
    CCSequence* sequence = [CCSequence actions: slideToMiddle,slideBack, nil];
    
    CCEaseInOut* ease = [CCEaseInOut actionWithAction:sequence rate:4];
    [cursor runAction:ease];
    
    CGPoint increaseLabelPoint = CGPointMake(cupcakePosition.x - cursorHitMovement.x, cupcakePosition.y - cursorHitMovement.y);
    [AnimationUtil animateClickerForCupcakes:cupcakes atPostion:increaseLabelPoint andAddItToLayer:self];
}

#pragma mark Cupcake And Good Things Delegate
- (void) CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance didUpdateCupcakesTo:(NSNumber *)newCupcakeValue{
    [self.cupcakeCountLabel setString:[NSString stringWithFormat:@"%d",[[[CupcakesAndGoodThings sharedInstance] cupcakes] intValue]]];
//    [self.cupcakeCountLabel setCString:[[NSString stringWithFormat:@"%d",[[[CupcakesAndGoodThings sharedInstance] cupcakes] intValue]] cStringUsingEncoding:NULL]];
}
-(void) CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance item:(items)purchaseItem didCreateTheseManyCupcakes:(NSNumber *)cupcakes theseManyTimes:(int)x{
    if(purchaseItem == clicker){
        [self animateClickerWithAlreadyIncreasedCount:x withIncreaseAmount: cupcakes];
        return;
    }
    [self.itemScrollLayer displayCupcakeIncreasedForItem:purchaseItem withAlreadyIncreasedCount:x withAlreadyAddedArray:self.itemsAddedArray[purchaseItem] byAmount:cupcakes];
    return;
    
}

-(void)CupcakesAndGoodThingsdidLoadState:(CupcakesAndGoodThings *)instance{
    [self.cupcakeCountLabel setString:[NSString stringWithFormat:@"%d",[[[CupcakesAndGoodThings sharedInstance] cupcakes] intValue]]];
    
    for(int x = 0; x < numObjects; x ++){
        NSNumber * items = [[CupcakesAndGoodThings sharedInstance] itemArray][x];
        [self setCostAndCountValues:x];
        for(int y = 0; y < items.intValue; y++){
            [self incrementMenuViewItems:x];
        }
    }
}

@end
