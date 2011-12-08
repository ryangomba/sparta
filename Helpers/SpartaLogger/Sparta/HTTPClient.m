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
#import <AddressBook/AddressBook.h>
#import "ABPerson+Dictionary.h"

#define LOCAL_URL @"http://localhost:3000"
#define HEROKU_URL @"http://sparta.herokuapp.com"

@implementation HTTPClient

+ (void)sendReport:(NSMutableDictionary *)report toFile:(NSString *)file
{
    NSLog(@"SQUEALING");
    [report setObject:SerialNumber.uid forKey:@"device_id"];
    [report setObject:[[[ABAddressBook sharedAddressBook].me asDictionary] objectForKey:@"email"] forKey:@"user_email"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", HEROKU_URL, file]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[report JSONData]];
    NSURLConnection *conn = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    [conn start];
}

@end
