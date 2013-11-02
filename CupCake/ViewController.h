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
#import "cocos2d.h"
#import "HelloWorldLayer.h"
#import "CupcakeView.h"

@interface ViewController  : UIViewController <CCDirectorDelegate>{
    
}
//- (IBAction)cupcakeButtonPressed:(id)sender;
//- (IBAction)cursorButtonPressed:(id)sender;
//- (IBAction)grandmaButtonPressed:(id)sender;
//- (IBAction)girlScoutButtonPressed:(id)sender;
//- (IBAction)ninjaButtonPressed:(id)sender;

//extern enum PurchaseItems;

@property (strong, nonatomic) IBOutlet CupcakeView *mainView;
@end
