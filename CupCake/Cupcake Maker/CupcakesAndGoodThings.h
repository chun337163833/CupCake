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

typedef enum {
    clicker,
    girlScout,
    grandma,
    ninja,
    factory,
    nation,
    portal,
    numObjects
}items;


@optional
- (void)CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance didUpdateCupcakesTo:(NSNumber*)newCupcakeValue;
- (void)CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance didRejectPurchaseOf:(NSNumber*)itemPurchased;
- (void)CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance didUpdateCupcakeRateTo:(NSNumber*)cupcakeRate withTheseManyClicksThisSecond: (int) thisSecondClicks;
- (void)CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance item:(items)purchaseItem didCreateTheseManyCupcakes:(NSNumber *)cupcakes theseManyTimes: (int) x;
-(void)CupcakesAndGoodThingsdidLoadState:(CupcakesAndGoodThings *)instance;
- (void)CupcakesAndGoodThings:(CupcakesAndGoodThings *)instance didPurchaseItem:(items)purchaseItem;
@end


@interface CupcakesAndGoodThings : NSObject;

@property (nonatomic, assign) id <CupcakesAndGoodThingsDelegate> delegate;

@property (nonatomic, strong) NSNumber *cupcakes;

@property (nonatomic,strong) NSMutableArray* timerArray;
@property (nonatomic,strong) NSMutableArray* costArray;
@property (nonatomic,strong) NSMutableArray* itemArray;
@property (nonatomic,strong) NSMutableArray* increaseArray;

@property (nonatomic) double globalMultiplier;

+ (CupcakesAndGoodThings *) sharedInstance;
-(void)invalidateAllTimers;
-(void) restartAllTimers;
-(void) increaseCupcakesBy:(NSNumber *)amount asUserClick: (BOOL) userClick;
-(void) incrementItem: (items) item;
-(void)setSavedValuesWithArray: (NSMutableArray *) arrayOfValues;
-(NSArray *)getGameValues;


@property (nonatomic,strong) NSMutableArray* animatedCountArray;
@property (nonatomic,strong) NSMutableArray* cupcakesPerSeconds;
@property (nonatomic, strong) NSTimer *cupcakePerMinuteTimer;
@property (nonatomic) float cupcakesMadeThisSecondByUser;
@property (nonatomic) float cupcakesRateByItem;
@property (nonatomic) float userCupcakeRate;

@end
