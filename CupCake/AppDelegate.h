//
//  AppDelegate.h
//  CupCake
//
//  Created by Saif Khan on 10/27/2013.
//  Copyright SaifKhan 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "CupcakesAndGoodThings.h"
#import "DataUtil.h"
#import "GameLayer.h"
#import "IntroLayer.h"
#import "GADInterstitial.h"
// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate, GADInterstitialDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;

	CCDirectorIOS	*__unsafe_unretained director_;							// weak ref
}

@property(nonatomic, strong) GADInterstitial *interstitial;
@property (nonatomic, strong) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (unsafe_unretained, readonly) CCDirectorIOS *director;

@end
