//
//  SMAObjectFetchController.m
//  SMAObjectFetchController
//
//  Created by Soheil M. Azarpour on 8/17/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//

#import "SMAObjectFetchController.h"


@interface SMAObjectFetchController ()

@property (nonatomic, copy) NSString* prototype; // to hold a string as prototype, with %@ placeholders
@property (nonatomic, retain) NSMutableData *receivedData; // to hold downloaded data from URL

@end


@implementation SMAObjectFetchController
@synthesize prototype = _prototype;
@synthesize receivedData = _receivedData;


- (void)dealloc {
    [_prototype release];
    [_receivedData release];
    [super dealloc];
}


#pragma mark -
#pragma mark - Designated initializer and header implemetation

- (id)initWithPrototypeURLString:(NSString *)string {
    if (self = [super init]) {
        self.prototype = string;
    }
    return self;
}



- (void)performFetchWithParameters:(NSArray *)parameters {
    
    // If there is a parameter array
    // combine the prototype with given parameters
    
    NSString *urlString = nil;
    
    if (parameters) {
        urlString = [self URLStringFromPrototype:self.prototype withParameters:parameters];
        
        // Create a request
        NSURL *theURL = [NSURL URLWithString:urlString];
        NSURLRequest *theRequest = [[NSURLRequest alloc] initWithURL:theURL cachePolicy:NSURLCacheStorageAllowedInMemoryOnly timeoutInterval:20.0];
        
        // Create the connection with the request
        // and start loading the data
        // the delegate for the NSURLConnection is self
        // Connection will be released upon completion, or failure in delegate methods.
        
        NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        NSAssert(theConnection, @"theConnection is nil");

    }
    
    
}


#pragma mark -
#pragma mark - Private methods


// Combine a given prototype string with an array of paramteres.
// Return the combined string.
// Assumptions:
//   1. Prototype string contains placeholders with %@
//   2. Objects in array are of NSString class
//   3. Number of objects in the array is exactly eqaul with the number of placeholder,
//      otherwise, an exceptaion raises.

- (NSString *)URLStringFromPrototype:(NSString *)prototype withParameters:(NSArray *)parameters {
    
    NSString *ret = nil;
    
    NSInteger count = parameters.count;
    char *params = (char *)malloc((sizeof(NSString *) * count));
    [parameters getObjects:(id *)params range:NSMakeRange(0, count)];
    ret = [[NSString alloc] initWithFormat:self.prototype arguments:params];
    free(params);
    
    // Return nil if prototype hasn't been changed.
    if ([ret isEqualToString:self.prototype]) {
        ret = nil;
    }
    
    return ret;
}


- (void)processReceivedData {
    
    // Create JSON object
    
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:self.receivedData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        
        // Report error
        
        [self.delegate controller:self didFail:error];
        
    } else {
        
        // Finish
        
        [self.delegate controller:self fetchedResults:json];
    }
}


#pragma mark -
#pragma mark - NSURLConnection methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    // Create the NSMutableData to hold the received data.
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
	
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    self.receivedData = [[NSMutableData alloc] init];
    
    [self.receivedData setLength:0];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    // Append the new data to receivedData.
    
    [self.receivedData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    // release the connection, and the data object
    
    [connection release];
    self.receivedData = nil;
    
    [self.delegate controller:self didFail:error];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    // Process reveived data
    [self processReceivedData];
    
    // release the connection
    [connection release];
}

@end
