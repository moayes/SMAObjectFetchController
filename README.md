
SMAObjectFetchController 
========================

The purpose of this library is to provide an easier way to communicate using REST API.
The class should be initialized using the designated initializer.
The prototype is a URL as string. The class saves it for re-usability.
The URL contains replaceable arguments, the same as in NSString formatting, that can be
dynamically replaced and re-used, by calling the -fetchedResultsWithParameters: method.
 
The results are JSON, wrapped in an instance of NSDictionary. It comes back asynchronously.
The caller should adopt the delegation to be notified.
 
Example:
-------- 
``` objective-c
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
```
 