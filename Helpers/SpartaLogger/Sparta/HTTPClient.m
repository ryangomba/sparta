//
//  HTTPClient.m
//  SpartaLogger
//
//  Created by Ryan Gomba on 11/25/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

#import "HTTPClient.h"
#import "SGJSONKit.h"
#import "SerialNumber.h"

@implementation HTTPClient

+ (void)sendReport:(NSMutableDictionary *)report toFile:(NSString *)file
{
    NSLog(@"SQUEALING");
    [report setObject:SerialNumber.uid forKey:@"device_id"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sparta.herokuapp.com/%@", file]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[report JSONData]];
    NSURLConnection *conn = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    [conn start];
}

@end
