//
//  SMAObjectFetchController.m
//  SMAObjectFetchController
//
//  Created by Soheil M. Azarpour on 8/17/12.
//  Copyright (c) 2012 iOS Developer. All rights reserved.
//

#import "SMAObjectFetchController.h"


@interface SMAObjectFetchController ()

@property (nonatomic, copy) NSString *prototype;

@end


@implementation SMAObjectFetchController
@synthesize prototype = _prototype;


- (id)initWithPrototypeURLString:(NSString *)string {
    if (self = [super init]) {
        self.prototype = string;
    }
    return self;
}




- (id)fetchedResultsWithParameters:(NSArray *)parameters {
    
    NSString *modifiedString = nil;
    
    if (!parameters) {
        
        NSInteger count = parameters.count;
        char *params = (char *)malloc((sizeof(NSString *) * count));
        [parameters getObjects:(id *)params range:NSMakeRange(0, count)];
        modifiedString = [[NSString alloc] initWithFormat:self.prototype arguments:params];
        free(params);
        
        // Return nil if prototype hasn't been changed.
        if ([modifiedString isEqualToString:self.prototype]) {
            modifiedString = nil;
        }
        
    }
    
    return modifiedString;
}






- (id)JSON:(NSString *)modifiedString {
    
    NSURL *URL = [NSURL URLWithString:modifiedString];
    NSData* data = [NSData dataWithContentsOfURL:URL];
    
    //parse out the json data
    NSError* error = nil;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    
    return json;
}

@end
