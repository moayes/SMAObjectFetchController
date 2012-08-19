//
//  SMAJSONSerializationOperation.h
//  SMAObjectFetchController
//
//  Created by Soheil M. Azarpour on 8/19/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

/**
 
 This class will process JSON data based on NSJSONSerialization Class asynchronously.
 
 */

#import <Foundation/Foundation.h>


@protocol SMAJSONSerializationDelegate;


@interface SMAJSONSerializationOperation : NSOperation

@property (nonatomic, assign) id <SMAJSONSerializationDelegate> delegate;

// Processed data
// If accessed before the delegate method is called, it will be nil
// Either an instance of NSArray or NSDictionary

@property (nonatomic, copy, readonly) id results;

// If an error occurs, it can be inquired

@property (nonatomic, copy, readonly) NSError *error;


// Designated initializer
- (id)initWithData:(NSData *)data delegate:(id <SMAJSONSerializationDelegate>)delegate;

@end


@protocol SMAJSONSerializationDelegate <NSObject>

- (void)operationDidFinish:(SMAJSONSerializationOperation *)operation;

@end