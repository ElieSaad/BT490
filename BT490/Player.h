//
//  Player.h
//  BT490
//
//  Created by Elie SAAD on 12-01-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, assign) int playerID;
@property (nonatomic, assign) int gamePlayed;
@property (nonatomic, assign) int score;
@property (nonatomic, assign) BOOL authenticated;


@end