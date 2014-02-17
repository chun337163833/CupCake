//
//  ViewController.m
//  Cupcake Maker
//
//  Created by DEVFLOATER79-XL on 2013-09-22.
//  Copyright (c) 2013 DEVFLOATER79-XL. All rights reserved.
//

#import "ViewController.h"
//#import "CupcakesAndGoodThings.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad
{
    
//    self.mainView = [[CupcakeView alloc] initWithFrame:self.view.frame];
//    self.view = self.mainView;
    
    [super viewDidLoad];
    interstitial_ = [[GADInterstitial alloc] init];
    interstitial_.adUnitID = @"ca-app-pub-1900105952197422/2749568192";
    [interstitial_ loadRequest:[GADRequest request]];

    CCDirector *director = [CCDirector sharedDirector];
    
    if([director isViewLoaded] == NO)
    {
        // Create the OpenGL view that Cocos2D will render to.
        CCGLView *glView = [CCGLView viewWithFrame:[[[UIApplication sharedApplication] keyWindow] bounds]
                                       pixelFormat:kEAGLColorFormatRGB565
                                       depthFormat:0
                                preserveBackbuffer:NO
                                        sharegroup:nil
                                     multiSampling:NO
                                   numberOfSamples:0];
        
        // Assign the view to the director.
        director.view = glView;
        
        // Initialize other director settings.
        [director setAnimationInterval:1.0f/60.0f];
        [director enableRetinaDisplay:YES];
    }
    
    // Set the view controller as the director's delegate, so we can respond to certain events.
    director.delegate = self;
    
    // Add the director as a child view controller of this view controller.
    [self addChildViewController:director];
    
    // Add the director's OpenGL view as a subview so we can see it.
    [self.view addSubview:director.view];
    [self.view sendSubviewToBack:director.view];
    
    // Finish up our view controller containment responsibilities.
    [director didMoveToParentViewController:self];
    
    // Run whatever scene we'd like to run here.
    if(director.runningScene)
        [director replaceScene:[GameLayer scene]];
    else
        [director runWithScene:[GameLayer scene]];
    
    
//    [CupcakesAndGoodThings initialize];
//    (void)[self.mainView init];
    
}
-(void)viewDidUnload{
     [[CCDirector sharedDirector] setDelegate:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    [self launchGameDirector];
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    [interstitial presentFromRootViewController:self];
}

-(void) launchGameDirector{
    
}


@end
