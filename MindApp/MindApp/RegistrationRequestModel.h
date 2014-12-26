//
//  RegistrationRequestModel.h
//  MindApp
//
//  Created by Jonny Pillar on 14/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequestDataContract.h"

@interface RegistrationRequestModel : BaseRequestDataContract

@property (nonatomic, strong) NSString* EmailAddress;
@property (nonatomic, strong) NSString* Password;
@property (nonatomic, strong) NSString* DateOfBirth;

@end
