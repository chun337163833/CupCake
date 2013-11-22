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

#define IPHONE_SCREEN_CENTER 160.0f
#define CURSOR_RADIUS 90.0f
#define CURSOR_SIZE 25.0f
#define ITEM_SIZE 20.0f
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
        [self setUpMenu];
        [self setUpCupcakeButton];
        [self setUpItemScrollView];
        [self setUpMisc];
    }
	return self;
}

-(void)setUpMenu{
    [CCMenuItemFont setFontSize:15];
    
    CCMenuItem *clickerButton = [CCMenuItemFont itemWithString:@"Clicker" block:^(id sender) {
        [[CupcakesAndGoodThings sharedInstance] incrementClickers];
        [self addCursor];
//        [self.autoclickerPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfClicker]];
        
    }];
    clickerButton.position = ccp(0,200);
    
    
    CCMenuItem *girlScoutButton = [CCMenuItemFont itemWithString:@"GirlScout" block:^(id sender) {
        [[CupcakesAndGoodThings sharedInstance] incrementGirlScout];
//        [self addGirlScout];
        //        [self.mainView.girlScoutPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfGirlScout]];
    }];

    girlScoutButton.position = ccp(0,170);

    
    CCMenuItem *grandmaButton = [CCMenuItemFont itemWithString:@"Grandma" block:^(id sender) {
      
        [[CupcakesAndGoodThings sharedInstance] incrementGrandmas];
//        [self addGrandma];
        //        [self.mainView.grandmaPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfGrandma]];
    }];

    grandmaButton.position = ccp(0,140);
    
    
    CCMenuItem *ninjaButton = [CCMenuItemFont itemWithString:@"Ninja" block:^(id sender) {
        [[CupcakesAndGoodThings sharedInstance] incrementNinjas];
//        [self addNinja];
//        [self.mainView.ninjaPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfNinja]];
    }];
    ninjaButton.position = ccp(0,110);
    
    
    CCMenuItem *factoryButton = [CCMenuItemFont itemWithString:@"Factory" block:^(id sender) {
        
        [[CupcakesAndGoodThings sharedInstance] incrementFactories];
//        [self addFactory];
//        [self.mainView.factoryPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfFactory]];
    }];
    
    factoryButton.position = ccp(0,80);
    
    
    CCMenuItem *planetButton = [CCMenuItemFont itemWithString:@"Planet" block:^(id sender) {
        [[CupcakesAndGoodThings sharedInstance] incrementNation];
//        [self addPlanet];
//        [self.mainView.nationPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfNation]];
    }];
    planetButton.position = ccp(0, 50);
    
    
    self.mainMenu = [CCMenu menuWithItems:clickerButton, girlScoutButton, grandmaButton, ninjaButton, factoryButton, planetButton, nil];
    
    [self.mainMenu setPosition:ccp(40, self.mainMenu.position.y -200)];
    
    [self addChild:self.mainMenu];
}


#pragma mark Cupcake Button
-(void)setUpCupcakeButton{
    
    self.cupcakeButton = [CCMenuItemImage itemWithNormalImage:@"cupCakeClearBitten0.png" selectedImage:@"cupCakeClearBitten0.png" target:self selector:@selector(cupcakeButtonPressed)];
    
    self.cupcakeButton.position = ccp(0, 160);
    [self.cupcakeButton setScale:0.2];
    
    CCMenu *menu = [CCMenu menuWithItems:self.cupcakeButton, nil];
    [self addChild:menu];
}

-(void) cupcakeButtonPressed{
    [[CupcakesAndGoodThings sharedInstance] increaseCupcakesBy:[NSNumber numberWithInt:[[CupcakesAndGoodThings sharedInstance] increaseOfClicker]]asUserClick:YES];
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
    self.itemScrollLayer = [[CCScrollLayer alloc] init];
}

-(void) setUpMisc{
    self.cupcakeCountLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[[CupcakesAndGoodThings sharedInstance] cupcakes] intValue]] fontName:@"Arial" fontSize:30.0f];
    CCLabelTTF *cupcakeIcon = [CCLabelTTF labelWithString:@"🍥" fontName:@"Arial" fontSize:30.0f];

    [cupcakeIcon setColor:(ccc3(255, 105, 180))];
    
    [self.cupcakeCountLabel setPosition:ccp(160,535)];
    [self addChild:self.cupcakeCountLabel];
    [cupcakeIcon setPosition:ccp(110,535)];
    [self addChild:cupcakeIcon];
}
-(void)addCursor{
    if(!self.cursorsAdded){
        self.cursorsAdded= [[NSMutableArray alloc] init];
    }
    
    for(int y = 0; y < self.cursorsAdded.count; y++){
        [self removeChild:[self.cursorsAdded objectAtIndex:y] cleanup:YES];
    }
    
    [self.cursorsAdded removeAllObjects];
    
    float radiansToIncease = (2*M_PI)/[[CupcakesAndGoodThings sharedInstance] clickers];
    
    for(int x = 0; x < [[CupcakesAndGoodThings sharedInstance] clickers]; x++ ){
        
        CCSprite *cursorImage = [[CCSprite alloc] initWithFile:@"cursor.png"];
        
        cursorImage.position = ccp( IPHONE_SCREEN_CENTER + (CURSOR_RADIUS *cos(radiansToIncease *x)),
                                 [self.cupcakeButton convertToWorldSpace:CGPointZero].y + self.cupcakeButton.boundingBox.size.height/2 + CURSOR_RADIUS *sin(radiansToIncease * x));
        cursorImage.rotation = CC_RADIANS_TO_DEGREES(0.409 - (radiansToIncease *x) - M_PI/2);
        [cursorImage setScale:0.1f];
        [self addChild:cursorImage];
        [self.cursorsAdded addObject:cursorImage];
        
    }

}

#pragma mark Cupcake And Good Things Delegate
- (void) CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance didUpdateCupcakesTo:(NSNumber *)newCupcakeValue{
    [self.cupcakeCountLabel setString:[NSString stringWithFormat:@"%d",[[[CupcakesAndGoodThings sharedInstance] cupcakes] intValue]]];
    
//    [self.cupcakeCountLabel setCString:[[NSString stringWithFormat:@"%d",[[[CupcakesAndGoodThings sharedInstance] cupcakes] intValue]] cStringUsingEncoding:NULL]];
}

@end
