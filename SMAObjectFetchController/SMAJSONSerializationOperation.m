//
//  SMAJSONSerializationOperation.m
//  SMAObjectFetchController
//
//  Created by Soheil M. Azarpour on 8/19/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//

#import "SMAJSONSerializationOperation.h"


@interface SMAJSONSerializationOperation ()

@property (nonatomic, copy, readwrite) id results;
@property (nonatomic, copy, readwrite) NSError *error;
@property (nonatomic, copy) NSData *inputData;

@end

@implementation SMAJSONSerializationOperation
@synthesize delegate = _delegate;
@synthesize results = _results;
@synthesize error = _error;
@synthesize inputData = _inputData;


#pragma mark -
#pragma mark - Life cycle

- (void)dealloc {
    [_results release];
    [_error release];
    [_inputData release];
    [super dealloc];
}


- (id)initWithData:(NSData *)data delegate:(id<SMAJSONSerializationDelegate>)delegate {
    
    if (self = [super init]) {
        self.inputData = data;
    }
    return self;
}


#pragma mark -
#pragma mark - Operation


- (void)main {
    
    @autoreleasepool {
        
        if (self.isCancelled) return;
        
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:self.inputData options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            
            // Retain a copy of the error so that it can be access from the main thread by caller
            self.error = error;
            json = nil;
            
        } else {
            
            // Retain the results
            self.results = json;
            
        }
        
        // Notify caller on main thread
        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(operationDidFinish:) withObject:self waitUntilDone:NO];
    }
}

@end
