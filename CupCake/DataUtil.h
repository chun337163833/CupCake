//
//  AnimationUtil.h
//  CupCake
//
//  Created by Saif Jamil Khan on 2/9/2014.
//  Copyright (c) 2014 SaifKhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CupcakesAndGoodThings.h"
@class DataUtil;

@interface DataUtil : NSObject;

+(void) saveArrayToUserDefaults;
+(void) loadArrayFromUserDefaults;
@end
