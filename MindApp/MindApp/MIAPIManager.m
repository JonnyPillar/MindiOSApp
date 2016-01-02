//
// Created by Jonny Pillar on 02/01/2016.
// Copyright (c) 2016 Mind In Salford. All rights reserved.
//

#import "MIAPIManager.h"
#import "MICommunicationsManager.h"
#import "MIApiConstants.h"
#import "MILogUtil.h"

@implementation MIAPIManager {
    MICommunicationsManager * communicationManager;
}

-(id) initWithCommuniattionDelegate: (id) delegate{
    if (self = [super init] ) {
        if(!communicationManager){
            communicationManager = [[MICommunicationsManager alloc] initWithDelegate:delegate];
        }
    }

    return self;
}

- (void)getMediaFiles {
    [MILogUtil log:@"Retreiving Media Items"];
    [communicationManager GetRequest:[MIApiConstants getMediaFilesUrl] withParams:nil];
}

@end