//
//  MCTeacher.m
//  BuzzMe
//
//  Created by Tim Wong on 2/15/15.
//  Copyright (c) 2015 Tim Wong. All rights reserved.
//

#import "MCTeacher.h"

@implementation MCTeacher

- (id)init{
    self = [super init];
    
    if (self) {
        _peerID = nil;
        _session = nil;
        _browser = nil;
        _advertiser = nil;
    }
    
    return self;
}

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    NSDictionary *dict = @{@"peerID": peerID,
                           @"state": [NSNumber numberWithInt:state]};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCTeacherDidChangeStateNotification" object:nil userInfo:dict];
}


- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
    NSDictionary *dict = @{@"data": data,
                           @"peerID": peerID};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCTeacherDidReceiveData" object:nil userInfo:dict];
}


- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress{
    
}


- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{
    
}


- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
    
}

- (void)setupPeerAndSessionWithDisplayName:(NSString *)displayName{
    _peerID = [[MCPeerID alloc] initWithDisplayName:displayName];
    
    _session = [[MCSession alloc] initWithPeer:_peerID];
    _session.delegate = self;
}

- (void)setupMCBrowser {
    _browser = [[MCBrowserViewController alloc] initWithServiceType:@"chat-files" session:_session];
}

-(void)advertiseSelf:(BOOL)shouldAdvertise {
    if (shouldAdvertise) {
        _advertiser = [[MCAdvertiserAssistant alloc] initWithServiceType:@"chat-files"
                                                           discoveryInfo:nil
                                                                 session:_session];
        [_advertiser start];
    }
    else {
        if (self.advertiser) {
            [_advertiser stop];
            _advertiser = nil;
        }
    }
}

@end
