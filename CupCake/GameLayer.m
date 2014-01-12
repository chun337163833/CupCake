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

#define ITEM_BUTTON_OFFSET_Y 285.0f
#define ITEM_BUTTON_OFFSET_X 80.0f
#define ITEM_BUTTON_SEPERATION 40.0f

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
        [self setUpMenu];
        [self setUpCupcakeButton];
        [self setUpItemScrollView];
        [self setUpMisc];
    }
	return self;
}

#pragma mark setups
-(void) addBackground{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *background = [CCSprite spriteWithFile:@"sky.jpeg"];
    [background setScale:3.0f];
    background.position = ccp(winSize.width/2, 50+winSize.height/2);
    [self addChild:background];
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
        [self incrementMenuViewItems:girlScout];
        //        [self.mainView.girlScoutPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfGirlScout]];
    }];

    girlScoutButton.position = ccp(0,200 - ITEM_BUTTON_SEPERATION * girlScout);

    
    CCMenuItem *grandmaButton = [CCMenuItemFont itemWithString:@"Grandma" block:^(id sender) {
      
        [[CupcakesAndGoodThings sharedInstance] incrementGrandmas];
        [self incrementMenuViewItems:grandma];
    
        //        [self.mainView.grandmaPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfGrandma]];
    }];

    grandmaButton.position = ccp(0,200 - ITEM_BUTTON_SEPERATION * grandma);
    
    
    CCMenuItem *ninjaButton = [CCMenuItemFont itemWithString:@"Ninja" block:^(id sender) {
        [[CupcakesAndGoodThings sharedInstance] incrementNinjas];
        [self incrementMenuViewItems:ninja];
//        [self.mainView.ninjaPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfNinja]];
    }];
    ninjaButton.position = ccp(0,200 - ITEM_BUTTON_SEPERATION * ninja);
    
    
    CCMenuItem *factoryButton = [CCMenuItemFont itemWithString:@"Factory" block:^(id sender) {
        
        [[CupcakesAndGoodThings sharedInstance] incrementFactories];
        [self incrementMenuViewItems:factory];
//        [self.mainView.factoryPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfFactory]];
    }];
    
    factoryButton.position = ccp(0,200 - ITEM_BUTTON_SEPERATION * factory);
    
    
    CCMenuItem *planetButton = [CCMenuItemFont itemWithString:@"Planet" block:^(id sender) {
        [[CupcakesAndGoodThings sharedInstance] incrementNation];
        [self incrementMenuViewItems:nation];
//        [self.mainView.nationPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfNation]];
    }];
    planetButton.position = ccp(0, 200 - ITEM_BUTTON_SEPERATION * nation);
    
    CCMenuItem *portalButton = [CCMenuItemFont itemWithString:@"Ancient Portal" block:^(id sender) {
        [[CupcakesAndGoodThings sharedInstance] incrementPortal];
        [self incrementMenuViewItems:portal];
        //        [self.mainView.nationPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfNation]];
    }];
    portalButton.position = ccp(0, 200 - ITEM_BUTTON_SEPERATION * portal);
    
    
    
    self.mainMenu = [CCMenu menuWithItems:clickerButton, girlScoutButton, grandmaButton, ninjaButton, factoryButton, planetButton, portalButton, nil];
    
    [self.mainMenu setPosition:ccp(40, self.mainMenu.position.y -200)];
    
    [self addChild:self.mainMenu];
}

-(void)setUpCupcakeButton{
    
    self.cupcakeButton = [CCMenuItemImage itemWithNormalImage:@"cupCakeClearBitten0.png" selectedImage:@"cupCakeClearBitten0.png" target:self selector:@selector(cupcakeButtonPressed)];
    
    self.cupcakeButton.position = ccp(0, 160);
    [self.cupcakeButton setScale:0.2];
    
    CCMenu *menu = [CCMenu menuWithItems:self.cupcakeButton, nil];
    [self addChild:menu];
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

#pragma mark cupcake button

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


#pragma mark adding view items

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

-(void) incrementMenuViewItems:(int) itemIndex {
    NSMutableArray *listOfAlreadyAddedItems;
    int numberOfItems;
    CCSprite *itemSprite;
    float customScale =1;
    switch(itemIndex){
           case girlScout:
            numberOfItems = [[CupcakesAndGoodThings sharedInstance] girlScouts];
            if(!self.girlScoutsAdded) self.girlScoutsAdded = [[NSMutableArray alloc] init];
            listOfAlreadyAddedItems = self.girlScoutsAdded;
            customScale = 0.25f;
            itemSprite = [[CCSprite alloc] initWithFile:@"girlWithCupcake.png"];
            break;
        case grandma:
            numberOfItems = [[CupcakesAndGoodThings sharedInstance] grandmas];
            if(!self.grandmasAdded) self.grandmasAdded = [[NSMutableArray alloc] init];
            listOfAlreadyAddedItems = self.grandmasAdded;
            customScale = 0.125f;
            itemSprite = [[CCSprite alloc] initWithFile:@"grandma.png"];
            break;
        case ninja:
            numberOfItems = [[CupcakesAndGoodThings sharedInstance] ninjas];
            if(!self.ninjasAdded) self.ninjasAdded = [[NSMutableArray alloc] init];
            listOfAlreadyAddedItems = self.ninjasAdded;
            customScale = 1.19f;
            itemSprite = [[CCSprite alloc] initWithFile:@"ninjaDown.png"];
            break;
        case factory:
            numberOfItems = [[CupcakesAndGoodThings sharedInstance] factories];
            if(!self.factoriesAdded) self.factoriesAdded = [[NSMutableArray alloc] init];
            listOfAlreadyAddedItems = self.factoriesAdded;
            customScale = 0.22f;
            itemSprite = [[CCSprite alloc] initWithFile:@"factory.png"];
            break;
        case nation:
            numberOfItems = [[CupcakesAndGoodThings sharedInstance] nations];
            if(!self.nationsAdded) self.nationsAdded = [[NSMutableArray alloc] init];
            listOfAlreadyAddedItems = self.nationsAdded;
            customScale = 0.1f;
            itemSprite = [[CCSprite alloc] initWithFile:@"nationIcon.png"];
            break;
        case portal:
            numberOfItems = [[CupcakesAndGoodThings sharedInstance] portals];
            if(!self.portalsAdded) self.portalsAdded = [[NSMutableArray alloc] init];
            listOfAlreadyAddedItems = self.portalsAdded;
            customScale = 0.06f;
            itemSprite = [[CCSprite alloc] initWithFile:@"portal.png"];
            break;
        default:
            return;
    }
    
    if(numberOfItems <= 0) return;
    [self addSpriteObject:itemSprite withScale: customScale usingAlreadyAddedArray:listOfAlreadyAddedItems nextToButtonIndex:itemIndex];
}

-(void) addSpriteObject:(CCSprite *) itemToAdd withScale:(float)customScale usingAlreadyAddedArray:(NSMutableArray *) listOfAddedItems nextToButtonIndex:(int) buttonIndex{
    
    int lineNumber = floor(((ITEM_SIZE +2) * listOfAddedItems.count)/240);
    int itemsOnLine = listOfAddedItems.count % 11;
    
    itemToAdd.position = ccp(ITEM_BUTTON_OFFSET_X + itemsOnLine * (ITEM_SIZE + 2), ITEM_BUTTON_OFFSET_Y - ITEM_SIZE * (lineNumber %2) - ITEM_BUTTON_SEPERATION * buttonIndex);
    [itemToAdd setScale:customScale];
  
    [self addChild:itemToAdd];
    [listOfAddedItems addObject:itemToAdd];
    NSLog(@"list %d", listOfAddedItems.count);
}


//- (void) addImage: (UIImageView *) itemToAdd usingAlreadyAddedArray: (NSMutableArray *) listOfAddedItems nextToButton: (UIButton *) button{
//    
//    int lineNumber = floor((ITEM_SIZE * listOfAddedItems.count)/self.createdItemsScrollView.frame.size.width);
//    
//    int itemsOnLine = listOfAddedItems.count % 12;
//    int xValueOfNewItem;
//    
//    
//    if(itemsOnLine !=0){
//        xValueOfNewItem = CGRectGetMaxX([(UIView *)[listOfAddedItems lastObject] frame]);
//    }
//    else{
//        xValueOfNewItem = (self.createdItemsScrollView.frame.size.width + ITEM_SIZE) * floor(lineNumber/2) + 6 * (lineNumber%2);
//    }
//    
//    itemToAdd.frame = CGRectMake(xValueOfNewItem,
//                                 
//                                 button.frame.origin.y + ITEM_SIZE * (lineNumber%2),
//                                 
//                                 ITEM_SIZE,
//                                 
//                                 ITEM_SIZE);
//    
//    [self.createdItemsScrollView addSubview:itemToAdd];
//    [listOfAddedItems addObject:itemToAdd];
//    
//    self.createdItemsScrollView.contentSize = CGSizeMake(MAX(self.createdItemsScrollView.contentSize.width, CGRectGetMaxX(itemToAdd.frame)), self.createdItemsScrollView.contentSize.height);
//}
//

#pragma mark Cupcake And Good Things Delegate
- (void) CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance didUpdateCupcakesTo:(NSNumber *)newCupcakeValue{
    [self.cupcakeCountLabel setString:[NSString stringWithFormat:@"%d",[[[CupcakesAndGoodThings sharedInstance] cupcakes] intValue]]];
//    [self.cupcakeCountLabel setCString:[[NSString stringWithFormat:@"%d",[[[CupcakesAndGoodThings sharedInstance] cupcakes] intValue]] cStringUsingEncoding:NULL]];
}

@end
