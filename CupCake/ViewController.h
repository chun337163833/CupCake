//
//  ViewController.h
//  Cupcake Maker
//
//  Created by DEVFLOATER79-XL on 2013-09-22.
//  Copyright (c) 2013 DEVFLOATER79-XL. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CupcakeView.h"
//#import "CupcakesAndGoodThings.h"
#import "GADInterstitial.h"
#import "cocos2d.h"
#import "GameLayer.h"
@interface ViewController  : UIViewController <CCDirectorDelegate, GADInterstitialDelegate>{
     GADInterstitial *interstitial_;
}
//- (IBAction)cupcakeButtonPressed:(id)sender;
//- (IBAction)cursorButtonPressed:(id)sender;
//- (IBAction)grandmaButtonPressed:(id)sender;
//- (IBAction)girlScoutButtonPressed:(id)sender;
//- (IBAction)ninjaButtonPressed:(id)sender;

//extern enum PurchaseItems;

@end
