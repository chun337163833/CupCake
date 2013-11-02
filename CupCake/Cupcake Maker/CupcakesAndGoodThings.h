//
//  CupcakesAndGoodThings.h
//  Cupcake Maker
//
//  Created by DEVFLOATER79-XL on 2013-09-22.
//  Copyright (c) 2013 DEVFLOATER79-XL. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CupcakesAndGoodThings;
@protocol CupcakesAndGoodThingsDelegate <NSObject>
@optional
- (void)CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance didUpdateCupcakesTo:(NSNumber*)newCupcakeValue;
- (void)CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance didRejectPurchaseOf:(NSNumber*)itemPurchased;
- (BOOL)CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance didUpdateCupcakeRateTo:(NSNumber*)cupcakeRate withTheseManyClicksThisSecond: (int) thisSecondClicks;
- (void)CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance item:(NSNumber*)purchaseItem didCreateTheseManyCupcakes:(NSNumber *)cupcakes theseManyTimes: (int) n;

@end

@interface CupcakesAndGoodThings : NSObject{
//        id <CupcakesAndGoodThingsDelegate> delegate;
}

@property (nonatomic, assign) id <CupcakesAndGoodThingsDelegate> delegate;

@property (nonatomic, strong) NSNumber *cupcakes;
@property (nonatomic) int girlScouts;
@property (nonatomic) int grandmas;
@property (nonatomic) int clickers;
@property (nonatomic) int factories;
@property (nonatomic) int ninjas;
@property (nonatomic) int nations;

@property (nonatomic, strong) NSTimer *clickerTimer;
@property (nonatomic, strong) NSTimer *girlScoutTimer;
@property (nonatomic, strong) NSTimer *grandmaTimer;
@property (nonatomic, strong) NSTimer *factoryTimer;
@property (nonatomic, strong) NSTimer *ninjaTimer;
@property (nonatomic, strong) NSTimer *nationTimer;

@property (nonatomic,strong) NSMutableArray* costArray;
@property (nonatomic) int costOfClicker;
@property (nonatomic) int costOfGirlScout;
@property (nonatomic) int costOfGrandma;
@property (nonatomic) int costOfFactory;
@property (nonatomic) int costOfNinja;
@property (nonatomic) int costOfNation;

@property (nonatomic,strong) NSMutableArray* increaseArray;
@property (nonatomic) double increaseOfClicker;
@property (nonatomic) double increaseOfGrandma;
@property (nonatomic) double increaseOfFactory;
@property (nonatomic) double increaseOfGirlScout;
@property (nonatomic) double increaseOfNinja;
@property (nonatomic) double increaseOfNation;
@property (nonatomic) double globalMultiplier;

+ (CupcakesAndGoodThings *) sharedInstance;
-(void) increaseCupcakesBy:(NSNumber *)amount asUserClick: (BOOL) userClick;
-(void) incrementClickers;
-(void) incrementFactories;
-(void) incrementGrandmas;
-(void) incrementGirlScout;
-(void) incrementNinjas;
-(void) incrementNation;

typedef enum {
    clicker,
    girlScout,
    grandma,
    ninja,
    factory,
    nation
}itemIndexes;

@property(nonatomic,assign)  itemIndexes itemTypes;
@property (nonatomic) int clickersAnimated;
@property (nonatomic) int grandmasAnimated;
@property (nonatomic) int factoriesAnimated;
@property (nonatomic) int girlScoutsAnimated;
@property (nonatomic) int ninjasAnimated;
@property (nonatomic) int nationsAnimated;

@property (nonatomic,strong) NSMutableArray* cupcakesInSeconds;
@property (nonatomic, strong) NSTimer *cupcakePerMinuteTimer;
@property (nonatomic) float cupcakesMadeThisSecondByUser;
@property (nonatomic) float cupcakesRateByItem;
@property (nonatomic) float actualSpeed;

@end
