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

@property (nonatomic,strong) NSMutableArray* timerArray;
@property (nonatomic,strong) NSMutableArray* costArray;
@property (nonatomic,strong) NSMutableArray* itemArray;
@property (nonatomic,strong) NSMutableArray* increaseArray;

@property (nonatomic) double globalMultiplier;

+ (CupcakesAndGoodThings *) sharedInstance;
-(void) increaseCupcakesBy:(NSNumber *)amount asUserClick: (BOOL) userClick;

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

-(void) incrementItem: (items) item;
@property (nonatomic,strong) NSMutableArray* animatedCountArray;


@property (nonatomic,strong) NSMutableArray* cupcakesInSeconds;
@property (nonatomic, strong) NSTimer *cupcakePerMinuteTimer;
@property (nonatomic) float cupcakesMadeThisSecondByUser;
@property (nonatomic) float cupcakesRateByItem;
@property (nonatomic) float actualSpeed;

@end
