//
//  CupcakesAndGoodThings.m
//  Cupcake Maker
//
//  Created by DEVFLOATER79-XL on 2013-09-22.
//  Copyright (c) 2013 DEVFLOATER79-XL. All rights reserved.
//


#import "CupcakesAndGoodThings.h"

@implementation CupcakesAndGoodThings{
   // itemIndexes itemTypes;
}


//@synthesize delegate;
static id instance = nil;

+ (void)initialize {
    if (self == [CupcakesAndGoodThings class]) {
        instance = [[self alloc] init];
        [instance setDefaultValues];
    }

}


//@property (nonatomic, strong) NSTimer *clickerTimer;
//@property (nonatomic, strong) NSTimer *girlScoutTimer;
//@property (nonatomic, strong) NSTimer *grandmaTimer;
//@property (nonatomic, strong) NSTimer *factoryTimer;
//@property (nonatomic, strong) NSTimer *ninjaTimer;
//@property (nonatomic, strong) NSTimer *nationTimer;
//@property (nonatomic, strong) NSTimer *portalTimer;

-(void)setDefaultValues{
    
    self.cupcakes = [NSNumber numberWithInt:100000000];
    self.globalMultiplier = 1;
    
    self.costArray = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:-15], [NSNumber numberWithInt:-100],[NSNumber numberWithInt:-300],[NSNumber numberWithInt:-500],[NSNumber numberWithInt:-1000], [NSNumber numberWithInt:-7500], [NSNumber numberWithInt:-100000],  nil];
    
    self.increaseArray = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:9],[NSNumber numberWithInt:28],[NSNumber numberWithInt:4],[NSNumber numberWithInt:57],[NSNumber numberWithInt:180],[NSNumber numberWithInt:500],nil];
    
    self.itemArray = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil];
    
    self.animatedCountArray = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],nil];
    
    
    self.timerArray = [[NSMutableArray alloc] initWithObjects:[NSObject alloc],[NSObject alloc],[NSObject alloc],[NSObject alloc],[NSObject alloc],[NSObject alloc],[NSObject alloc], nil];
    self.cupcakesInSeconds = [[NSMutableArray alloc]init];
}

+ (CupcakesAndGoodThings *) sharedInstance
{
    return instance;
}

#pragma mark Items Making Cupcakes with timers


-(void) increaseCupcakesBy:(NSNumber *)amount asUserClick: (BOOL) userClick{
    if(!self.cupcakePerMinuteTimer){
        self.cupcakePerMinuteTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCupcakesPerMinute) userInfo:nil repeats:YES];
    }
    bool isIncrease = amount.intValue > 0;
    
    if(isIncrease && userClick){
        self.cupcakesMadeThisSecondByUser += amount.intValue;
    }
    self.cupcakes = [NSNumber numberWithInt:(self.cupcakes.intValue + amount.intValue* (isIncrease ? self.globalMultiplier:1))];
    if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:didUpdateCupcakesTo:) ]){
        [self.delegate CupcakesAndGoodThings:self didUpdateCupcakesTo:self.cupcakes];
    }
}

-(void) updateCupcakesPerMinute{
    [self updateItemCupcakeRate];
    [self.cupcakesInSeconds addObject:[NSNumber numberWithInt:self.cupcakesMadeThisSecondByUser]];
    self.actualSpeed += self.cupcakesMadeThisSecondByUser;
    int timesUserClickedCupcakeButtonThisSecond = (self.cupcakesMadeThisSecondByUser/[(NSNumber*)self.increaseArray[clicker] floatValue]);
    self.cupcakesMadeThisSecondByUser =0;
    
    if(self.cupcakesInSeconds.count > 10){
        self.actualSpeed -= [(NSNumber *)self.cupcakesInSeconds[0] intValue];
        [self.cupcakesInSeconds removeObjectAtIndex:0];
    }
    
    if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:didUpdateCupcakeRateTo:withTheseManyClicksThisSecond:) ]){
        BOOL wentUpALevel = [self.delegate CupcakesAndGoodThings:self didUpdateCupcakeRateTo:[NSNumber numberWithInt:self.actualSpeed + self.cupcakesRateByItem *10]withTheseManyClicksThisSecond:timesUserClickedCupcakeButtonThisSecond];
    }

}

- (void)makeCupcakesForItem:(NSTimer*)timer {
    int item = [[[timer userInfo] objectForKey:@"item"] integerValue];

    int cupcakesCreated = [(NSNumber*)self.increaseArray[item] intValue] * self.globalMultiplier;
    [self increaseCupcakesBy:[NSNumber numberWithInt: cupcakesCreated] asUserClick:NO];
    if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:item:didCreateTheseManyCupcakes:theseManyTimes:) ]){
        [self.animatedCountArray replaceObjectAtIndex:item withObject:[NSNumber numberWithInt:[(NSNumber*)self.animatedCountArray[clicker] intValue] +1]];
        [self.delegate CupcakesAndGoodThings:self item:[NSNumber numberWithInt:item] didCreateTheseManyCupcakes:cupcakesCreated theseManyTimes:[(NSNumber*)self.animatedCountArray[clicker] intValue]];
    }
}

#pragma mark Incrementing items by one

-(void)incrementItem: (items) item{
    if((self.cupcakes.intValue + [(NSNumber *)self.costArray[clicker] intValue])< 0){
        if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:didRejectPurchaseOf:) ]){
            [self.delegate CupcakesAndGoodThings:self didRejectPurchaseOf:[NSNumber numberWithInt:item]];
        }
        return;
    }
    NSNumber *costOfItem = self.costArray[item];
    NSNumber *itemCount = self.itemArray[item];
    [self increaseCupcakesBy:costOfItem asUserClick:NO];
    [self.itemArray replaceObjectAtIndex:item withObject:[NSNumber numberWithInt:itemCount.intValue + 1]];
    itemCount = self.itemArray[item];
    [self updateCostValuesForItem:item];
    [self updateTimerForItem:item withItemCount: itemCount];
    
}

-(void) updateTimerForItem: (items) item withItemCount: (NSNumber*) itemCount{
    float defaultTime = 15.0f;
    switch (item) {
        case clicker:
                defaultTime = 5.0f;
            break;
        case girlScout:
                defaultTime = 5.0f;
            break;
        case grandma:
                defaultTime = 7.0f;
            break;
        case ninja:
                defaultTime = 1.0f;
            break;
        case factory:
                defaultTime = 15.0f;
            break;
        case nation:
                defaultTime = 30.0f;
            break;
        case portal:
                defaultTime = 60.0f;
            break;
        default:
            break;
    }
    
    NSTimer *incrementTimer = [self invalidateTimerForItem: item];
    incrementTimer = [NSTimer scheduledTimerWithTimeInterval:defaultTime/ itemCount.floatValue target:self selector:@selector(makeCupcakesForItem:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:item] , @"item", nil] repeats:YES];
    [self.timerArray replaceObjectAtIndex:item withObject:incrementTimer];

}
-(void) updateCostValuesForItem: (items) item{
    
    int costIncrease;
    int increaseIncrease;
    
    int currentNumberOfItems = [(NSNumber*)self.itemArray[item] intValue];
    
    switch (item) {
        case clicker:
            costIncrease = (currentNumberOfItems % 5) == 0 ? 1 : 0;
            increaseIncrease = (currentNumberOfItems % 5) == 0 ? -1 : 0;
            break;
        case girlScout:
            costIncrease = 1;
            increaseIncrease = 1;
            break;
        case grandma:
            costIncrease = 5;
            increaseIncrease = 5;
            break;
        case ninja:
            costIncrease = 15;
            increaseIncrease = (currentNumberOfItems % 5) == 0 ? 1 : 0;
            break;
        case factory:
            costIncrease = 100;
            increaseIncrease = 10;
            break;
        case nation:
            costIncrease = 1000;
            increaseIncrease = 55;
            break;
        case portal:
            costIncrease = 40000;
            increaseIncrease = 200;
            break;
        default:
            break;
    }
    
    NSNumber *currentCost = self.costArray[item];
    [self.costArray replaceObjectAtIndex:item withObject:[NSNumber numberWithInt:currentCost.intValue + costIncrease]];

    NSNumber *currentIncrease = self.increaseArray[item];
    [self.increaseArray replaceObjectAtIndex:item withObject:[NSNumber numberWithInt:currentIncrease.intValue + increaseIncrease]];
}
-(NSTimer *) invalidateTimerForItem: (items) item{
    if(self.timerArray[item] && ([self.timerArray[item] isKindOfClass:[NSTimer class] ])){
        NSTimer *objectTimer = self.timerArray[item];
        [objectTimer invalidate];
        return objectTimer;
    }
    
    return [[NSTimer alloc] init];
}

#pragma helpers

-(void)updateItemCupcakeRate{
    
    float timesPerSecond;
    NSNumber *countOfItems;
    self.cupcakesRateByItem=0;
    for(int x=0; x < self.increaseArray.count; x++){
        
        switch (x) {
            case clicker:
                timesPerSecond = 10.0f;
                countOfItems = self.itemArray[x];
                break;
            case girlScout:
                timesPerSecond = 10.0f;
                countOfItems = self.itemArray[x];
                break;
            case grandma:
                timesPerSecond = 10.0f;
                countOfItems = self.itemArray[grandma];
                break;
            case ninja:
                timesPerSecond = 0.8f;
                countOfItems = self.itemArray[ninja];
                break;
            case factory:
                timesPerSecond = 15.0f;
                countOfItems = self.itemArray[factory];
                break;
            case nation:
                timesPerSecond = 30.0f;
                countOfItems = self.itemArray[nation];
                break;
            case portal:
                timesPerSecond = 20.0f;
                countOfItems = self.itemArray[x];
                break;
            default:
                timesPerSecond= 10.0f;
                break;
        }
        self.cupcakesRateByItem += countOfItems.floatValue * ([(NSNumber*)self.increaseArray[x] floatValue] /timesPerSecond);
        
    }
}
-(NSString*) getFriendlyNameForItem: (items) item{
    NSString *result = @"";
    
    switch(item) {
        case clicker:
            result = @"Clicker";
        case girlScout:
            result = @"Girl Scout";
            break;
        case grandma:
            result = @"Grandma";
            break;
        case ninja:
            result = @"Ninja";
            break;
        case factory:
            result = @"Factory";
            break;
        case nation:
            result = @"Nation";
            break;
        case portal:
            result = @"Portal";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    
    return result;
}

@end
