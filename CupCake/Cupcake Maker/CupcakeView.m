//
//  CupcakeView.m
//  Cupcake Maker
//
//  Created by DEVFLOATER79-XL on 2013-09-22.
//  Copyright (c) 2013 DEVFLOATER79-XL. All rights reserved.
//

#import "CupcakeView.h"
#define IPHONE_SCREEN_CENTER 160.0f
#define CURSOR_RADIUS 75.0f
#define CURSOR_SIZE 25.0f
#define ITEM_SIZE 20.0f
#import "math.h"


@implementation CupcakeView


@synthesize cupcakeCount;

#pragma mark Neccessities

-(id)init{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    cupcakeButtonCenter = CGPointMake(self.cupcakeButton.frame.origin.x  +  self.cupcakeButton.frame.size.width/2,self.cupcakeButton.frame.origin.y  +  self.cupcakeButton.frame.size.height/2);
    [[CupcakesAndGoodThings sharedInstance] setDelegate:self];
    self.progressMultiplier = [self setUpProgressMultiplier:self.progressMultiplier atXValue:screenWidth -90];
    //self.progressMultiplier2 = [self setUpProgressMultiplier:self.progressMultiplier2 atXValue:screenWidth - 88];
    self.progressMultiplier.progressImage = [UIImage imageNamed:@"candycane.png"];
    
    return self;
}

-(UIProgressView *) setUpProgressMultiplier: (UIProgressView * ) progressView atXValue: (int) x{
    progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(x, 130, 80, 8)];
//    CGAffineTransform transform = CGAffineTransformMakeScale(4.0f, 3.0f);
//    progressView.transform = transform;
    progressView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0f, 3.0f), CGAffineTransformMakeRotation(-M_PI/2));//CGAffineTransformMakeRotation(-M_PI/2);
    progressView.progressViewStyle = UIProgressViewStyleBar;
    progressView.progressTintColor = [UIColor redColor];
    progressView.progress = 0.2f;
    [self addSubview:progressView];
    return progressView;
}

#pragma mark Adders

-(void)addCursor{
    if(!self.cursorsAdded){
        self.cursorsAdded= [[NSMutableArray alloc] init];
    }
    
    for(int y = 0; y < self.cursorsAdded.count; y++){
        [[self.cursorsAdded objectAtIndex:y] removeFromSuperview];
        
    }
    
    [self.cursorsAdded removeAllObjects];
    
    float radiansToIncease = (2*M_PI)/[[CupcakesAndGoodThings sharedInstance] clickers];

    for(int x = 0; x < [[CupcakesAndGoodThings sharedInstance] clickers]; x++ ){

            UIImageView *cursorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cursor.png"]];
            cursorImage.contentMode = UIViewContentModeScaleAspectFit;
        
            cursorImage.frame = CGRectMake(
                                           IPHONE_SCREEN_CENTER + (CURSOR_RADIUS *cos(radiansToIncease *x)) - CURSOR_SIZE/2,
                                           
                                           cupcakeButtonCenter.y + (CURSOR_RADIUS *sin(radiansToIncease *x)) - CURSOR_SIZE/2,
                                           
                                                CURSOR_SIZE,
                                           
                                                CURSOR_SIZE);
            cursorImage.transform = CGAffineTransformMakeRotation(0.409 + (radiansToIncease *x) - M_PI/2);
            [self addSubview:cursorImage];
            [self.cursorsAdded addObject:cursorImage];
        
    }
}


-(void)addGrandma{
    
    if(!self.grandmasAdded){
        self.grandmasAdded= [[NSMutableArray alloc] init];
    }
    
    
    if([[CupcakesAndGoodThings sharedInstance] grandmas] > 0){
        UIImageView *grandmaImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grandma.png"]];

        grandmaImage.contentMode = UIViewContentModeScaleToFill;
        
        [self addImage:grandmaImage usingAlreadyAddedArray:self.grandmasAdded nextToButton:self.addGrandmaButton];
    }
}

-(void)addFactory{
    
    if(!self.factoriesAdded){
        self.factoriesAdded= [[NSMutableArray alloc] init];
    }
    
    if([[CupcakesAndGoodThings sharedInstance] factories] > 0){
        UIImageView *factoryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"factory.png"]];
        
        factoryImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addImage:factoryImage usingAlreadyAddedArray:self.factoriesAdded nextToButton:self.addFactoryButton];
    }
}

-(void)addGirlScout{
    
    if(!self.girlScoutsAdded){
        self.girlScoutsAdded= [[NSMutableArray alloc] init];
    }
    
    if([[CupcakesAndGoodThings sharedInstance] girlScouts] > 0){
        UIImageView *girlScoutImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"girlWithCupcake.png"]];
        
        girlScoutImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addImage:girlScoutImage  usingAlreadyAddedArray:self.girlScoutsAdded nextToButton:self.addGirlScoutButton];
    }
}

-(void)addNinja{
    
    if(!self.ninjasAdded){
        self.ninjasAdded= [[NSMutableArray alloc] init];
    }
    
    if([[CupcakesAndGoodThings sharedInstance] ninjas] > 0){
        UIImageView *ninjaImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ninjaDown.png"]];
        
        ninjaImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addImage:ninjaImage  usingAlreadyAddedArray:self.ninjasAdded nextToButton:self.addNinjaButton];
    }
}

-(void)addNation{
    
    if(!self.nationsAdded){
        self.nationsAdded= [[NSMutableArray alloc] init];
    }
    
    if([[CupcakesAndGoodThings sharedInstance] nations] > 0){
        UIImageView *nationImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nationIcon.png"]];
        
        nationImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addImage:nationImage  usingAlreadyAddedArray:self.nationsAdded nextToButton:self.addNationButton];
    }
}

- (void) addImage: (UIImageView *) itemToAdd usingAlreadyAddedArray: (NSMutableArray *) listOfAddedItems nextToButton: (UIButton *) button{
    
    int lineNumber = floor((ITEM_SIZE * listOfAddedItems.count)/self.createdItemsScrollView.frame.size.width);
    
    int itemsOnLine = listOfAddedItems.count % 12;
    int xValueOfNewItem;
    
    
    if(itemsOnLine !=0){
        xValueOfNewItem = CGRectGetMaxX([(UIView *)[listOfAddedItems lastObject] frame]);
    }
    else{
        xValueOfNewItem = (self.createdItemsScrollView.frame.size.width + ITEM_SIZE) * floor(lineNumber/2) + 6 * (lineNumber%2);
    }
    
    itemToAdd.frame = CGRectMake(xValueOfNewItem,
                                  
                                  button.frame.origin.y + ITEM_SIZE * (lineNumber%2),
                                  
                                  ITEM_SIZE,
                                  
                                  ITEM_SIZE);
    
    [self.createdItemsScrollView addSubview:itemToAdd];
    [listOfAddedItems addObject:itemToAdd];
    
    self.createdItemsScrollView.contentSize = CGSizeMake(MAX(self.createdItemsScrollView.contentSize.width, CGRectGetMaxX(itemToAdd.frame)), self.createdItemsScrollView.contentSize.height);
}


#pragma mark Animators

-(void)animateAClicker:(NSNumber *) clickerNumber withTheseManyCupcakes: (NSNumber *) cupcakes{
   
    clickerNumber = [NSNumber numberWithInt:clickerNumber.intValue % [[CupcakesAndGoodThings sharedInstance] clickers]];
    UIView *clicker = [self.cursorsAdded objectAtIndex:clickerNumber.integerValue];
    CGPoint originalCenter = clicker.center;
    
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         
                         clicker.center = CGPointMake(cupcakeButtonCenter.x +(originalCenter.x - cupcakeButtonCenter.x)*0.9 , cupcakeButtonCenter.y +(originalCenter.y - cupcakeButtonCenter.y)*0.9);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.2
                                          animations:^{
                                              
                                              clicker.center = originalCenter;
                                          }
                                          completion:^(BOOL finished){
                                          }
                          ];
                    }
     ];
    
    [self makeIncreaseAnimationFromRect:CGRectMake(CGRectGetMaxX(clicker.frame),clicker.frame.origin.y  , 200, ITEM_SIZE) withValue:cupcakes inView:self];
}

-(void)animateGrandma:(NSNumber *) grandmaNumber withTheseManyCupcakes: (NSNumber *) cupcakes{
    
    grandmaNumber = [NSNumber numberWithInt:grandmaNumber.intValue % [[CupcakesAndGoodThings sharedInstance] grandmas]];
    UIView *grandma = [self.grandmasAdded objectAtIndex:grandmaNumber.integerValue];
    
    [self makeIncreaseAnimationFromRect:(CGRectMake(CGRectGetMaxX(grandma.frame),grandma.frame.origin.y  - ITEM_SIZE, 200, ITEM_SIZE))withValue:cupcakes inView:self.createdItemsScrollView];
}

-(void)animateGirlScout:(NSNumber *) girlScoutNumber withTheseManyCupcakes: (NSNumber *) cupcakes{
    
    girlScoutNumber = [NSNumber numberWithInt:girlScoutNumber.intValue % [[CupcakesAndGoodThings sharedInstance] girlScouts]];
    UIView *girlScoutImage = [self.girlScoutsAdded objectAtIndex:girlScoutNumber.integerValue];
    
    [self makeIncreaseAnimationFromRect:(CGRectMake(CGRectGetMaxX(girlScoutImage.frame),girlScoutImage.frame.origin.y  - ITEM_SIZE, 200, ITEM_SIZE))withValue:cupcakes inView:self.createdItemsScrollView];
}

-(void)animateFactory:(NSNumber *) factoryNumber withTheseManyCupcakes: (NSNumber *) cupcakes{
    
    factoryNumber = [NSNumber numberWithInt:factoryNumber.intValue % [[CupcakesAndGoodThings sharedInstance] factories]];
    UIView *factory = [self.factoriesAdded objectAtIndex:factoryNumber.integerValue];
    
     [self makeIncreaseAnimationFromRect:CGRectMake(CGRectGetMaxX(factory.frame),factory.frame.origin.y -10, 200, ITEM_SIZE) withValue:cupcakes inView:self.createdItemsScrollView];
}

-(void)animateNinja:(NSNumber *) ninjaNumber withTheseManyCupcakes: (NSNumber *) cupcakes{
    
    ninjaNumber = [NSNumber numberWithInt:ninjaNumber.intValue % [[CupcakesAndGoodThings sharedInstance] ninjas]];
    UIView *ninja = [self.ninjasAdded
                     objectAtIndex:ninjaNumber.integerValue];
    
    [self makeIncreaseAnimationFromRect:CGRectMake(CGRectGetMaxX(ninja.frame),ninja.frame.origin.y -10, 200, ITEM_SIZE) withValue:cupcakes inView:self.createdItemsScrollView];
}

-(void)animateNation:(NSNumber *) nationNumber withTheseManyCupcakes: (NSNumber *) cupcakes{
    
    nationNumber = [NSNumber numberWithInt:nationNumber.intValue % [[CupcakesAndGoodThings sharedInstance] nations]];
    UIView *nation = [self.nationsAdded
                     objectAtIndex:nationNumber.integerValue];
    
    [self makeIncreaseAnimationFromRect:CGRectMake(CGRectGetMaxX(nation.frame),nation.frame.origin.y -10, 200, ITEM_SIZE) withValue:cupcakes inView:self.createdItemsScrollView];
}

#pragma mark cupcakesandgoodthings delegates

- (void)CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance didUpdateCupcakesTo:(NSNumber*)newCupcakeValue{
    [[self  cupcakeCount] setText:[NSString stringWithFormat:@"🍥%@",[[CupcakesAndGoodThings sharedInstance] cupcakes] ]];
}

-(void)CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance didRejectPurchaseOf:(NSNumber *) itemPurchased{
    NSString* itemName = @"";
    
    switch (itemPurchased.integerValue) {
        case 0:
            itemName = @"clicker";
            break;
        case 1:
            itemName = @"girl scout";
            break;
        case 2:
            itemName = @"grandma";
            break;
        case 3:
            itemName = @"ninja";
            break;
        case 4:
            itemName = @"factory";
            break;
        case 5:
            itemName = @"nation";
            break;
        default:
            break;
    }
    UIAlertView *notNuffFunds = [[UIAlertView alloc] initWithTitle:@"Need mo doe" message:[NSString stringWithFormat:@"You need more cupcakes to buy that %@", itemName] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [notNuffFunds show];
    
}

-(void)CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance item:(NSNumber *)purchaseItem didCreateTheseManyCupcakes:(NSNumber *)cupcakes theseManyTimes:(int)n{
    
    switch (purchaseItem.integerValue) {
        case 0:
            [self  animateAClicker:[NSNumber numberWithInt:n] withTheseManyCupcakes:cupcakes];
            break;
        case 1:
            [self  animateGirlScout:[NSNumber numberWithInt:n] withTheseManyCupcakes:cupcakes];
            break;
        case 2:
            [self  animateGrandma:[NSNumber numberWithInt:n] withTheseManyCupcakes:cupcakes];
            break;
        case 3:
            [self  animateNinja:[NSNumber numberWithInt:n] withTheseManyCupcakes:cupcakes];
            break;
        case 4:
            [self  animateFactory:[NSNumber numberWithInt:n] withTheseManyCupcakes:cupcakes];
            break;
        case 5:
            [self  animateNation:[NSNumber numberWithInt:n] withTheseManyCupcakes:cupcakes];
            break;
        default:
            break;
    }
    
}

-(BOOL)CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance didUpdateCupcakeRateTo:(NSNumber *)cupcakeRate withTheseManyClicksThisSecond:(int)thisSecondClicks{
    
    BOOL didAdvanceLevels = NO;
    if(self.progressMultiplier.progress == 1.0f){
        didAdvanceLevels = YES;
        NSLog(@"progress: %f", self.progressMultiplier.progress);
        [[CupcakesAndGoodThings sharedInstance] setGlobalMultiplier:([[CupcakesAndGoodThings sharedInstance] globalMultiplier] +2)];
    
    }
    
    int multplierLevel = [[CupcakesAndGoodThings sharedInstance] globalMultiplier];
     self.multiplierLabel.text = [NSString stringWithFormat:@"x%d", multplierLevel];
    
    if(!didAdvanceLevels){
        [self.progressMultiplier setProgress:MIN((self.progressMultiplier.progress *0.8 + 0.1* (thisSecondClicks / 2)), 1) animated:YES];
    }
    else{
        [self.progressMultiplier setProgress:0.0f animated:YES];
        switch((int)[[CupcakesAndGoodThings sharedInstance] globalMultiplier]){
            case 1:
                
                self.progressMultiplier.progressImage = [UIImage imageNamed:@"candycane.png"];
                break;
            case 3:
                self.progressMultiplier.progressImage = [self colorImageName:@"candycane.png" withColor:[UIColor yellowColor]];
                break;
            case 5:
                
                self.progressMultiplier.progressImage = [self colorImageName:@"candycane.png" withColor:[UIColor orangeColor]];
                break;
            case 7:
                
                self.progressMultiplier.progressImage = [self colorImageName:@"candycane.png" withColor:[UIColor redColor]];
                break;
            case 9:
                
                self.progressMultiplier.progressImage = [self colorImageName:@"candycane.png" withColor:[UIColor blueColor]];
                break;
                
                
                
        }
    }
    
    
    
    float roundedRate = cupcakeRate.intValue/10;
    int integerRepresentation= ceil(roundedRate);
    self.cupcakeRateLabel.text = [NSString stringWithFormat:@"%d/s", integerRepresentation];
    return didAdvanceLevels;
}



#pragma mark Helpers
-(void)cycleCupcakeButton{
    self.cupcakeButton.tag ++;//= MIN((self.cupcakeButton.tag+1), 3);
    [self.cupcakeButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"cupCakeClearBitten%d",(int)floor(self.cupcakeButton.tag/10)]] forState:UIControlStateNormal];
    if(self.cupcakeButton.tag == 39){
        self.cupcakeButton.tag = -1;
    }
    
}

-(void) makeIncreaseAnimationFromRect:(CGRect)rect withValue:(NSNumber *) value inView:(UIView *) view{
    
    UILabel *increasedValue = [[UILabel alloc] initWithFrame:rect];
    
    increasedValue.text = [NSString stringWithFormat:@"+ %d",value.intValue];
    increasedValue.textColor = [UIColor cyanColor];
    increasedValue.font = [UIFont fontWithName:@"verdana-bold" size:10.0f];
    
    [view addSubview:increasedValue];
    [UIView animateWithDuration:1
                     animations:^{
                         increasedValue.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         increasedValue.alpha = 1.0f;
                         
                         [increasedValue removeFromSuperview];
                         
                     }
     ];
    
}


- (UIImage *)colorImageName:(NSString *)name withColor:(UIColor *)theColor
{
    UIImage *baseImage = [UIImage imageNamed:name];
    UIGraphicsBeginImageContext(baseImage.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, baseImage.size.width, baseImage.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, baseImage.CGImage);
    [theColor set];
    CGContextFillRect(ctx, area);
    CGContextRestoreGState(ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextDrawImage(ctx, area, baseImage.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



@end
