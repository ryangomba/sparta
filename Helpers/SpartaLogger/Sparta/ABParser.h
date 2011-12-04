//
//  ABParser.h
//  SpartaLogger
//
//  Created by Ryan Gomba on 11/25/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

@class ABAddressBook;

@interface ABParser : NSObject

@property (readonly) ABAddressBook *addressBook;

- (NSDictionary *)fetchUser;
- (NSArray *)fetchContacts;

@end
