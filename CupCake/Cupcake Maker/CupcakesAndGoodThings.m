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

-(void)setDefaultValues{
    self.costOfFactory =-1000;
    self.costOfClicker =-1;
    self.costOfGrandma =-300;
    self.costOfGirlScout =-75;
    self.costOfNinja =-500;
    self.costOfNation =-7500;
    self.costArray = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:self.costOfClicker], [NSNumber numberWithInt:self.costOfGirlScout],[NSNumber numberWithInt:self.costOfGrandma],[NSNumber numberWithInt:self.costOfNinja],[NSNumber numberWithInt:self.costOfFactory], [NSNumber numberWithInt:self.costOfNation], nil];
    
    self.increaseOfClicker = 1;
    self.increaseOfGrandma = 28;
    self.increaseOfFactory = 57;
    self.increaseOfGirlScout =9;
    self.increaseOfNinja = 4;
    self.increaseOfNation = 180;
    self.globalMultiplier = 1;
    self.increaseArray = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithInt:self.increaseOfClicker], [NSNumber numberWithInt:self.increaseOfGirlScout],[NSNumber numberWithInt:self.increaseOfGrandma],[NSNumber numberWithInt:self.increaseOfNinja],[NSNumber numberWithInt:self.increaseOfFactory],[NSNumber numberWithInt:self.increaseOfNation], nil];
    
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
    bool isIncrease =amount.intValue > 0;
    
    if(isIncrease && userClick){
        self.cupcakesMadeThisSecondByUser += amount.intValue;
    }
    self.cupcakes = [NSNumber numberWithInt:(self.cupcakes.intValue + amount.intValue* (isIncrease ? self.globalMultiplier:1))];
    if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:didUpdateCupcakesTo:) ]){
        [self.delegate CupcakesAndGoodThings:self didUpdateCupcakesTo:self.cupcakes];
    }
}

-(void) updateCupcakesPerMinute{
    
    [self.cupcakesInSeconds addObject:[NSNumber numberWithInt:self.cupcakesMadeThisSecondByUser]];
    self.actualSpeed += self.cupcakesMadeThisSecondByUser;
    int timesUserClickedCupcakeButtonThisSecond = (self.cupcakesMadeThisSecondByUser/self.increaseOfClicker);
    self.cupcakesMadeThisSecondByUser =0;
    
    if(self.cupcakesInSeconds.count > 10){
        self.actualSpeed -= [(NSNumber *)self.cupcakesInSeconds[0] intValue];
        [self.cupcakesInSeconds removeObjectAtIndex:0];
    }
    
    if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:didUpdateCupcakeRateTo:withTheseManyClicksThisSecond:) ]){
        BOOL wentUpALevel = [self.delegate CupcakesAndGoodThings:self didUpdateCupcakeRateTo:[NSNumber numberWithInt:self.actualSpeed + self.cupcakesRateByItem *10]withTheseManyClicksThisSecond:timesUserClickedCupcakeButtonThisSecond];
    }

}
-(void) clickerMadeCupcakes{
    [self increaseCupcakesBy:[NSNumber numberWithInt:self.increaseOfClicker] asUserClick:NO];
    if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:item:didCreateTheseManyCupcakes:theseManyTimes:) ]){
        [self.delegate CupcakesAndGoodThings:self item:[NSNumber numberWithInt:0] didCreateTheseManyCupcakes:[NSNumber numberWithInt:self.increaseOfClicker * self.globalMultiplier] theseManyTimes:self.clickersAnimated];
        self.clickersAnimated++;
        
    }
}

-(void) grandmaMadeCupcakes{
    [self increaseCupcakesBy:[NSNumber numberWithInt:self.increaseOfGrandma] asUserClick:NO];
    if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:item:didCreateTheseManyCupcakes:theseManyTimes:) ]){
        [self.delegate CupcakesAndGoodThings:self item:[NSNumber numberWithInt:2] didCreateTheseManyCupcakes:[NSNumber numberWithInt:self.increaseOfGrandma * self.globalMultiplier] theseManyTimes:self.grandmasAnimated];
        self.grandmasAnimated++;
    }
}

-(void) factoryMadeCupcakes{
    [self increaseCupcakesBy:[NSNumber numberWithInt:self.increaseOfFactory]asUserClick:NO];
    if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:item:didCreateTheseManyCupcakes:theseManyTimes:) ]){
        [self.delegate CupcakesAndGoodThings:self item:[NSNumber numberWithInt:4] didCreateTheseManyCupcakes:[NSNumber numberWithInt:self.increaseOfFactory * self.globalMultiplier] theseManyTimes:self.factoriesAnimated];
        self.factoriesAnimated++;
    }
    
}

-(void) girlScoutMadeCupcakes{
    [self increaseCupcakesBy:[NSNumber numberWithInt:self.increaseOfGirlScout]asUserClick:NO];
    if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:item:didCreateTheseManyCupcakes:theseManyTimes:) ]){
        [self.delegate CupcakesAndGoodThings:self item:[NSNumber numberWithInt:1] didCreateTheseManyCupcakes:[NSNumber numberWithInt:self.increaseOfGirlScout * self.globalMultiplier] theseManyTimes:self.girlScoutsAnimated];
        self.girlScoutsAnimated++;
    }
    
}

-(void) ninjaMadeCupcakes{
    [self increaseCupcakesBy:[NSNumber numberWithInt:self.increaseOfNinja]asUserClick:NO];
    if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:item:didCreateTheseManyCupcakes:theseManyTimes:) ]){
        [self.delegate CupcakesAndGoodThings:self item:[NSNumber numberWithInt:3] didCreateTheseManyCupcakes:[NSNumber numberWithInt:self.increaseOfNinja * self.globalMultiplier] theseManyTimes:self.ninjasAnimated];
        self.ninjasAnimated++;
    }
    
}

-(void) nationMadeCupcakes{
    [self increaseCupcakesBy:[NSNumber numberWithInt:self.increaseOfNation]asUserClick:NO];
    if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:item:didCreateTheseManyCupcakes:theseManyTimes:) ]){
        [self.delegate CupcakesAndGoodThings:self item:[NSNumber numberWithInt:5]  didCreateTheseManyCupcakes:[NSNumber numberWithInt:self.increaseOfNation * self.globalMultiplier] theseManyTimes:self.nationsAnimated];
        self.nationsAnimated++;
    }
    
}

#pragma mark Incrementing items by one

-(void)incrementClickers{
    
    if((self.cupcakes.intValue + self.costOfClicker) < 0){
        if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:didRejectPurchaseOf:) ]){
            [self.delegate CupcakesAndGoodThings:self didRejectPurchaseOf:[NSNumber numberWithInt:0]];
        }
        return;
    }
    [self increaseCupcakesBy:[NSNumber numberWithDouble:self.costOfClicker]asUserClick:NO];
    self.clickers ++;
    [self.clickerTimer invalidate];
   // float timeTaken = (float)10/(float)self.clickers;
    
    self.clickerTimer = [NSTimer scheduledTimerWithTimeInterval:(float)(10.0f/(float)self.clickers) target:self selector:@selector(clickerMadeCupcakes) userInfo:nil repeats:YES] ;
//    self.costOfClicker -= 5;
     [self.costArray replaceObjectAtIndex:clicker withObject:[NSNumber numberWithInt:self.costOfClicker]];
    NSLog(@"cost of clicker %d", [(NSNumber *)self.costArray[0] intValue]);
    self.increaseOfClicker = 1 + (self.clickers /5);
    [self.increaseArray replaceObjectAtIndex:clicker withObject:[NSNumber numberWithInt:self.increaseOfClicker]];
    
    [self updateItemCupcakeRate];

}

-(void)incrementFactories{
    if((self.cupcakes.intValue + self.costOfFactory) < 0){
        if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:didRejectPurchaseOf:) ]){
            [self.delegate CupcakesAndGoodThings:self didRejectPurchaseOf:[NSNumber numberWithInt:4]];
        }
        return;
    }
    
    [self increaseCupcakesBy:[NSNumber numberWithDouble:self.costOfFactory]asUserClick:NO];
    self.factories ++;
    [self.factoryTimer invalidate];
    self.factoryTimer = [NSTimer scheduledTimerWithTimeInterval:(float)15.0/(float)self.factories target:self selector:@selector(factoryMadeCupcakes) userInfo:nil repeats:YES] ;
    [self.costArray replaceObjectAtIndex:factory withObject:[NSNumber numberWithInt:self.costOfFactory]];
    self.costOfFactory -= 50;
    self.increaseOfFactory = self.increaseOfFactory + 3;
    [self.increaseArray replaceObjectAtIndex:factory withObject:[NSNumber numberWithInt:self.increaseOfFactory]];
    
    [self updateItemCupcakeRate];

}

-(void)incrementGrandmas{
    
    if((self.cupcakes.intValue + self.costOfGrandma) < 0){
        if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:didRejectPurchaseOf:) ]){
            [self.delegate CupcakesAndGoodThings:self didRejectPurchaseOf:[NSNumber numberWithInt:2]];
        }
        return;
    }
    
    [self increaseCupcakesBy:[NSNumber numberWithDouble:self.costOfGrandma]asUserClick:NO];
    
    self.grandmas ++;
    [self.grandmaTimer invalidate];
    self.grandmaTimer = [NSTimer scheduledTimerWithTimeInterval:(float)10.0/(float)self.grandmas target:self selector:@selector(grandmaMadeCupcakes) userInfo:nil repeats:YES] ;
    self.costOfGrandma -= 20;
    [self.costArray replaceObjectAtIndex:grandma withObject:[NSNumber numberWithInt:self.costOfGrandma]];
    self.increaseOfGrandma =self.increaseOfGrandma +2;
    [self.increaseArray replaceObjectAtIndex:grandma withObject:[NSNumber numberWithInt:self.increaseOfGrandma]];
    
    [self updateItemCupcakeRate];

}

-(void)incrementGirlScout{
    
    if((self.cupcakes.intValue + self.costOfGirlScout) < 0){
        if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:didRejectPurchaseOf:) ]){
            [self.delegate CupcakesAndGoodThings:self didRejectPurchaseOf:[NSNumber numberWithInt:1]];
        }
        return;
    }
    
    [self increaseCupcakesBy:[NSNumber numberWithDouble:self.costOfGirlScout]asUserClick:NO];
    
    self.girlScouts ++;
    [self.girlScoutTimer invalidate];
    self.girlScoutTimer = [NSTimer scheduledTimerWithTimeInterval:(float)10.0/(float)self.girlScouts target:self selector:@selector(girlScoutMadeCupcakes) userInfo:nil repeats:YES] ;
    self.costOfGirlScout -= 10;
     [self.costArray replaceObjectAtIndex:girlScout withObject:[NSNumber numberWithInt:self.costOfGirlScout]];
    
    [self.costArray replaceObjectAtIndex:girlScout withObject:[NSNumber numberWithInt:self.costOfGirlScout]];
    self.increaseOfGirlScout =self.increaseOfGirlScout +1;
    [self.increaseArray replaceObjectAtIndex:girlScout withObject:[NSNumber numberWithInt:self.increaseOfGirlScout]];

    [self updateItemCupcakeRate];
}

-(void)incrementNinjas{
    
    if((self.cupcakes.intValue + self.costOfNinja) < 0){
        if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:didRejectPurchaseOf:) ]){
            [self.delegate CupcakesAndGoodThings:self didRejectPurchaseOf:[NSNumber numberWithInt:3]];
        }
        return;
    }
    
    [self increaseCupcakesBy:[NSNumber numberWithDouble:self.costOfNinja]asUserClick:NO];
    
    self.ninjas ++;
    [self.ninjaTimer invalidate];
    self.ninjaTimer = [NSTimer scheduledTimerWithTimeInterval:(float)0.8/(float)self.ninjas target:self selector:@selector(ninjaMadeCupcakes) userInfo:nil repeats:YES] ;
    self.costOfNinja -= 30;
    [self.costArray replaceObjectAtIndex:girlScout withObject:[NSNumber numberWithInt:self.costOfGirlScout]];
    self.increaseOfNinja = 4 +floor(self.ninjas / 5);
    [self.increaseArray replaceObjectAtIndex:ninja withObject:[NSNumber numberWithInt:self.increaseOfNinja]];
    
    [self updateItemCupcakeRate];
    
}

-(void)incrementNation{
    
    if((self.cupcakes.intValue + self.costOfNation) < 0){
        if([self.delegate respondsToSelector:@selector(CupcakesAndGoodThings:didRejectPurchaseOf:) ]){
            [self.delegate CupcakesAndGoodThings:self didRejectPurchaseOf:[NSNumber numberWithInt:5]];
        }
        return;
    }
    
    [self increaseCupcakesBy:[NSNumber numberWithDouble:self.costOfNation]asUserClick:NO];
    
    self.nations ++;
    [self.nationTimer invalidate];
    self.nationTimer = [NSTimer scheduledTimerWithTimeInterval:(float)30/(float)self.nations target:self selector:@selector(nationMadeCupcakes) userInfo:nil repeats:YES] ;
    self.costOfNation -= 30;
    [self.costArray replaceObjectAtIndex:nation withObject:[NSNumber numberWithInt:self.costOfNation]];
    self.increaseOfNation +=  20;
    [self.increaseArray replaceObjectAtIndex:nation withObject:[NSNumber numberWithInt:self.increaseOfNation]];
    [self updateItemCupcakeRate];
}

#pragma helpers

-(void)updateItemCupcakeRate{
    
    float timesPerSecond;
    int countOfItems;
    self.cupcakesRateByItem=0;
    for(int x=0; x < self.increaseArray.count; x++){
        
        switch (x) {
            case clicker:
                timesPerSecond = 10.0f;
                countOfItems = self.clickers;
                break;
            case girlScout:
                timesPerSecond = 10.0f;
                countOfItems = self.girlScouts;
                break;
            case grandma:
                timesPerSecond = 10.0f;
                countOfItems = self.grandmas;
                break;
            case ninja:
                timesPerSecond = 0.8f;
                countOfItems = self.ninjas;
                break;
            case factory:
                timesPerSecond = 15.0f;
                countOfItems = self.factories;
                break;
            case nation:
                timesPerSecond = 30.0f;
                countOfItems = self.nations;
                break;
            default:
                timesPerSecond= 10.0f;
                break;
        }
        NSNumber *increase = self.increaseArray[x];
        self.cupcakesRateByItem += countOfItems * (increase.floatValue /timesPerSecond);
        
    }
}
@end
