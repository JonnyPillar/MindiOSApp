//
//  ResgistrationResponseModel.h
//  MindApp
//
//  Created by Jonny Pillar on 24/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponseDataContract.h"

@interface RegistrationResponseModel : BaseResponseDataContract

@property (nonatomic, strong) NSString* SessionId;

-(id) initWithDictionary:(NSDictionary *)responseDictionary;

@end
