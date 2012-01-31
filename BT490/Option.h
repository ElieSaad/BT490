//
//  Option.h
//  BT490
//
//  Created by Elie SAAD on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Option : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) int idNum;
@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end
