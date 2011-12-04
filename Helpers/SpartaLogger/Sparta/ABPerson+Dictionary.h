//
//  ABPerson+Dictionary.h
//  SpartaLogger
//
//  Created by Ryan Gomba on 11/25/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

#import <AddressBook/AddressBook.h>

@interface ABPerson (Dictionary)

- (NSObject *)primaryValueForProperty:(NSString *)property;
- (NSDictionary *)asDictionary;

@end
