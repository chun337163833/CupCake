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
    [super viewDidLoad];
//    self.interstitial = [[GADInterstitial alloc] init];
//    self.interstitial.adUnitID = @"ca-app-pub-1900105952197422/2749568192";
//    [self.interstitial loadRequest:[GADRequest request]];
//    // Show the interstitial.
//    [self.interstitial presentFromRootViewController:self];
}
- (id)init
{
    self = [super initWithNibName:@"ViewController" bundle:nil];
    if (self != nil)
    {
        // Further initialization if needed
    }
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.adUnitID = @"ca-app-pub-1900105952197422/2749568192";
    GADRequest *request = [GADRequest request];
    
    [self.interstitial setDelegate:self];
//    request.testDevices = @[ @"efbaecfe36f2f8767f39f9daca1867dd" ];
   request.testDevices = @[ GAD_SIMULATOR_ID ];
//    request.testDevices = @[ GAD_SIMULATOR_ID ];
    [self.interstitial loadRequest:request];
    // Show the interstitial.
    return self;
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    NSAssert(NO, @"Initialize with -init");
    return nil;
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
    NSLog(@"did recieve error %@", error.debugDescription);
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    NSLog(@"did recieve ad");
    [interstitial presentFromRootViewController:self];
}

-(void)interstitialDidDismissScreen:(GADInterstitial *)ad{
    [self launchGameDirector];
}
//-(void)launchGameDirector{
//    // Create the main window
//	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//	
//	
//	// CCGLView creation
//	// viewWithFrame: size of the OpenGL view. For full screen use [_window bounds]
//	//  - Possible values: any CGRect
//	// pixelFormat: Format of the render buffer. Use RGBA8 for better color precision (eg: gradients). But it takes more memory and it is slower
//	//	- Possible values: kEAGLColorFormatRGBA8, kEAGLColorFormatRGB565
//	// depthFormat: Use stencil if you plan to use CCClippingNode. Use Depth if you plan to use 3D effects, like CCCamera or CCNode#vertexZ
//	//  - Possible values: 0, GL_DEPTH_COMPONENT24_OES, GL_DEPTH24_STENCIL8_OES
//	// sharegroup: OpenGL sharegroup. Useful if you want to share the same OpenGL context between different threads
//	//  - Possible values: nil, or any valid EAGLSharegroup group
//	// multiSampling: Whether or not to enable multisampling
//	//  - Possible values: YES, NO
//	// numberOfSamples: Only valid if multisampling is enabled
//	//  - Possible values: 0 to glGetIntegerv(GL_MAX_SAMPLES_APPLE)
//	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
//								   pixelFormat:kEAGLColorFormatRGB565
//								   depthFormat:0
//							preserveBackbuffer:NO
//									sharegroup:nil
//								 multiSampling:NO
//							   numberOfSamples:0];
//	
//	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
//	
//	director_.wantsFullScreenLayout = YES;
//	
//	// Display FSP and SPF
//	[director_ setDisplayStats:YES];
//	
//	// set FPS at 60
//	[director_ setAnimationInterval:1.0/60];
//	
//	// attach the openglView to the director
//	[director_ setView:glView];
//	
//	// 2D projection
//	[director_ setProjection:kCCDirectorProjection2D];
//	//	[director setProjection:kCCDirectorProjection3D];
//	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
//	if( ! [director_ enableRetinaDisplay:YES] )
//		CCLOG(@"Retina Display Not supported");
//	
//	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
//	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
//	// You can change this setting at any time.
//	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
//	
//	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
//	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
//	// On iPad     : "-ipad", "-hd"
//	// On iPhone HD: "-hd"
//	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
//	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
//	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
//	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
//	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
//	
//	// Assume that PVR images have premultiplied alpha
//	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
//	
//	// Create a Navigation Controller with the Director
//	navController_ = [[UINavigationController alloc] initWithRootViewController:director_];
//	navController_.navigationBarHidden = YES;
//	
//	// set the Navigation Controller as the root view controller
//	[window_ setRootViewController:navController_];
//	
//	// make main window visible
//	[window_ makeKeyAndVisible];
//    [DataUtil loadArrayFromUserDefaults];
//}

-(void)launchGameDirector{
    [self.navigationController popViewControllerAnimated:YES];
    [[CCDirector sharedDirector] resume];
    return;
}
- (void)dealloc {
    _interstitial.delegate = nil;
}
@end
