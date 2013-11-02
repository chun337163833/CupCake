//
//  CupcakeView.h
//  Cupcake Maker
//
//  Created by DEVFLOATER79-XL on 2013-09-22.
//  Copyright (c) 2013 DEVFLOATER79-XL. All rights reserved.
//
#import "CupcakesAndGoodThings.h"
#import <Foundation/Foundation.h>

@interface CupcakeView : UIView <CupcakesAndGoodThingsDelegate>{
    CGPoint cupcakeButtonCenter;
}


@property (strong, nonatomic) IBOutlet UILabel *cupcakeCount;
@property (weak, nonatomic) IBOutlet UILabel *grandmaPrice;
@property (weak, nonatomic) IBOutlet UILabel *autoclickerPrice;
@property (weak, nonatomic) IBOutlet UILabel *factoryPrice;
@property (weak, nonatomic) IBOutlet UILabel *ninjaPrice;
@property (weak, nonatomic) IBOutlet UILabel *girlScoutPrice;
@property (weak, nonatomic) IBOutlet UILabel *cupcakeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nationPrice;
@property (weak, nonatomic) IBOutlet UILabel *multiplierLabel;

@property (strong, nonatomic) IBOutlet UIButton *cupcakeButton;

@property (weak, nonatomic) IBOutlet UIButton *addGrandmaButton;
@property (weak, nonatomic) IBOutlet UIButton *addFactoryButton;
@property (weak, nonatomic) IBOutlet UIButton *addClickerButton;
@property (weak, nonatomic) IBOutlet UIButton *addGirlScoutButton;
@property (weak, nonatomic) IBOutlet UIButton *addNinjaButton;
@property (weak, nonatomic) IBOutlet UIButton *addNationButton;


@property (strong, nonatomic) NSMutableArray *cursorsAdded;
@property (strong, nonatomic) NSMutableArray *grandmasAdded;
@property (strong, nonatomic) NSMutableArray *factoriesAdded;
@property (strong, nonatomic) NSMutableArray *girlScoutsAdded;
@property (strong, nonatomic) NSMutableArray *ninjasAdded;
@property (strong, nonatomic) NSMutableArray *nationsAdded;


@property (weak, nonatomic) IBOutlet UIScrollView *buttonScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *createdItemsScrollView;
@property (strong, nonatomic) IBOutlet UIProgressView *progressMultiplier;

-(void)addCursor;
-(void)addGrandma;
-(void)addFactory;
-(void)addNinja;
-(void)addGirlScout;
-(void)addNation;
-(void)cycleCupcakeButton;

@end
