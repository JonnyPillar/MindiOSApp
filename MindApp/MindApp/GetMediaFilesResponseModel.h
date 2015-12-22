//
//  GetMediaFilesResponseModel.h
//  MindApp
//
//  Created by Jonny Pillar on 02/01/2015.
//  Copyright (c) 2015 Jonny Pillar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponseDataContract.h"

@interface GetMediaFilesResponseModel : BaseResponseDataContract

@property (nonatomic, strong) NSArray* MediaFiles;

-(id) initWithDictionary:(NSDictionary *)responseDictionary;

@end
