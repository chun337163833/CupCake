//
//  DataUtil.m
//  CupCake
//
//  Created by Saif Jamil Khan on 2/9/2014.
//  Copyright (c) 2014 SaifKhan. All rights reserved.
//

#import "DataUtil.h"

@implementation DataUtil

+(void) saveArrayToUserDefaults{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSArray *values = [[CupcakesAndGoodThings sharedInstance] getGameValues];
    [prefs setValuesForKeysWithDictionary:[NSDictionary dictionaryWithObject:values forKey:@"values"]];
}

+(void) loadArrayFromUserDefaults{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSArray *values = [prefs objectForKey:@"values"];
    [[CupcakesAndGoodThings sharedInstance] setSavedValuesWithArray:values];
//    return [[prefs dictionaryRepresentation] objectForKey:@"values"];
}

@end
