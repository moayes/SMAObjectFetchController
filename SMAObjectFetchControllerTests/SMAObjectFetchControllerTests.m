//
//  SMAObjectFetchControllerTests.m
//  SMAObjectFetchControllerTests
//
//  Created by Soheil M. Azarpour on 8/17/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//

#import "SMAObjectFetchControllerTests.h"

@implementation SMAObjectFetchControllerTests


- (void)setUp {
    [super setUp];
    // Set-up code here.
}


- (void)tearDown {
    // Tear-down code here.
    [super tearDown];
}


- (void)test_zero_parameter {
    
    NSString *zero_parameter_url = @"http://www.example.com/";
    
    SMAObjectFetchController *controller = [[SMAObjectFetchController alloc] initWithPrototypeURLString:zero_parameter_url];
    
    STAssertNotNil(controller, @"controller is nil");
    
    NSArray *parameters = [NSArray arrayWithObject:@"replacement"];
    NSString *result = (NSString *)[controller fetchedResultsWithParameters:parameters];
    
    STAssertNil(result, @"zero param failed");
    
    result = (NSString *)[controller fetchedResultsWithParameters:nil];
    
    STAssertNil(result, @"zero param failed");
    
    [controller release];
}


- (void)test_one_parameter {
    
    NSString *one_parameter_url = @"http://www.example.com/%@";
    
    SMAObjectFetchController *controller = [[SMAObjectFetchController alloc] initWithPrototypeURLString:one_parameter_url];
    
    STAssertNotNil(controller, @"controller is nil");
    
    NSArray *parameters = [NSArray arrayWithObject:@"replacement"];
    NSString *result = (NSString *)[controller fetchedResultsWithParameters:parameters];
    
    STAssertEqualObjects(result, @"http://www.example.com/replacement", @"one param test failed");
    
    [controller release];
}


- (void)test_two_parameters {
    
    NSString *two_parameter_url = @"http://www.example.com/%@/something/%@";
    
    SMAObjectFetchController *controller = [[SMAObjectFetchController alloc] initWithPrototypeURLString:two_parameter_url];
    
    STAssertNotNil(controller, @"controller is nil");
    
    NSArray *parameters = [NSArray arrayWithObject:@"replacement"];
    NSString *result = (NSString *)[controller fetchedResultsWithParameters:parameters];
    
    STAssertEqualObjects(result, @"http://www.example.com/replacement/something/(null)", @"one param test failed");
    
    parameters = [NSArray arrayWithObjects:@"replacement_1", @"replacement_2", nil];
    result = (NSString *)[controller fetchedResultsWithParameters:parameters];
    
    [controller release];
}



@end
