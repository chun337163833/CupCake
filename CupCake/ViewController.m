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
        [director replaceScene:[HelloWorldLayer scene]];
    else
        [director runWithScene:[HelloWorldLayer scene]];
    
    
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
//
//- (IBAction)cupcakeButtonPressed:(id)sender {
//    [[CupcakesAndGoodThings sharedInstance] increaseCupcakesBy:[NSNumber numberWithInt:[[CupcakesAndGoodThings sharedInstance] increaseOfClicker]]asUserClick:YES];
//    [UIView animateWithDuration:0.1
//                     animations:^{
//                         self.mainView.cupcakeCount.alpha = 0.0f;
//                     }
//                     completion:^(BOOL finished){
//                         self.mainView.cupcakeCount.alpha = 1.0f;
//                     }
//     ];
//    [self.mainView cycleCupcakeButton];
//}
//
//- (IBAction)cursorButtonPressed:(id)sender {
//    [[CupcakesAndGoodThings sharedInstance] incrementClickers];
//
//    [self.mainView addCursor];
//    [self.mainView.autoclickerPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfClicker]];
//}
//
//- (IBAction)grandmaButtonPressed:(id)sender {
//    [[CupcakesAndGoodThings sharedInstance] incrementGrandmas];
//    [self.mainView addGrandma];
//      [self.mainView.grandmaPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfGrandma]];
//}
//
//- (IBAction)girlScoutButtonPressed:(id)sender {
//    [[CupcakesAndGoodThings sharedInstance] incrementGirlScout];
//    [self.mainView addGirlScout];
//    [self.mainView.girlScoutPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfGirlScout]];
//}
//
//- (IBAction)ninjaButtonPressed:(id)sender {
//    [[CupcakesAndGoodThings sharedInstance] incrementNinjas];
//    [self.mainView addNinja];
//    [self.mainView.ninjaPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfNinja]];
//}
//
//- (IBAction)factoryButtonPressed:(id)sender {
//    [[CupcakesAndGoodThings sharedInstance] incrementFactories];
//    [self.mainView addFactory];
//    [self.mainView.factoryPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfFactory]];
//}
//- (IBAction)nationButtonPressed:(id)sender {
//    [[CupcakesAndGoodThings sharedInstance] incrementNation];
//    [self.mainView addNation];
//    [self.mainView.nationPrice setText:[NSString stringWithFormat:@"🍥%d",-(int)[CupcakesAndGoodThings sharedInstance].costOfNation]];
//    
//}


@end
