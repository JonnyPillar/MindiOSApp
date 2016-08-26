//
// Created by Jonny Pillar on 02/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MIAPIManager : NSObject

-(id)initWithCommunicationDelegate: (id) delegate;
-(void) getMediaFiles;

@end