//
//  SMAObjectFetchController.h
//  SMAObjectFetchController
//
//  Created by Soheil M. Azarpour on 8/17/12.
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
 
 The purpose of this library is to provide an easier way to communicate using REST API.
 The class should be initialized using the designated initializer.
 The prototype is a URL as string. The class saves it for re-usability.
 The URL contains replaceable arguments, the same as in NSString formatting, that can be
 dynamically replaced and re-used, by calling the -fetchedResultsWithParameters: method.
 
 The results are JSON, wrapped in an instance of NSDictionary. It comes back asynchronously.
 The caller should adopt the delegation to be notified.
 
 Example:
 
 
 //  This a Google custom search REST API
 //  https://www.googleapis.com/customsearch/v1?key=INSERT-YOUR-KEY&cx=013036536707430787589:_pqjad5hr1a&q=flowers&alt=json
 //  Most of the string is constant, only query changes (flowers)
 //  Instead of query, you pass %@
 
 
 #define kGoogleSearchAPI = @"https://www.googleapis.com/customsearch/v1?key=INSERT-YOUR-KEY&cx=013036536707430787589:_pqjad5hr1a&q=%@&alt=json
 
 SMAObjectFetchController *controller = [[SMAObjectFetchController alloc] initWithPrototypeURLString:kGoogleSearchAPI];
 
 // anytime you want to perform a search,
 // simply put new parameters in an NSArray and call the convenient method
 
 NSArray *parameters = [NSArray arrayWithObjects:@"red", @"flowers", nil];
 
 // resutls return as NSDictionary
 NSDictionary *results = [controller fetchedResultsWithParameters:parameters];
 
 [controller release];
 
 */



#import <Foundation/Foundation.h>


@protocol SMAObjectFetchDelegate;


@interface SMAObjectFetchController : NSObject


@property (nonatomic, assign) id <SMAObjectFetchDelegate> delegate;

/**
 
 Designated initializer. Init with a URL string, that contains %@. Later you can call
 the convenient method. The class will replace %@ with parameters and return appropriate results.
 
 */

- (id)initWithPrototypeURLString:(NSString *)string;

/**
 
 Create an array with instances of NSString.
 Pass it in as parameters.
 
 NOTE: It is the responsibility of the caller to make sure the number of parameteres matches
 the number of arguments in prototype string. If they don't match, an exception will raise.
 
 */

- (id)performFetchWithParameters:(NSArray *)parameters;

@end


@protocol SMAObjectFetchDelegate <NSObject>

- (void)controller:(SMAObjectFetchController *)controller fetchedResults:(id)results;

@end