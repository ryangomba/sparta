//
//  ABPerson+Dictionary.m
//  SpartaLogger
//
//  Created by Ryan Gomba on 11/25/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

#import "ABPerson+Dictionary.h"

@implementation ABPerson (Dictionary)

- (NSObject *)primaryValueForProperty:(NSString *)property
{
    ABMultiValue *values = [self valueForProperty:property];
    return [values valueForIdentifier:[values primaryIdentifier]];
}

- (NSString *)primaryAddress
{
    NSDictionary *address = (NSDictionary *)[self primaryValueForProperty:kABAddressProperty];
    if (!address) return nil;
    return [NSString stringWithFormat:@"%@\n%@, %@ %@",
            [address objectForKey:@"Street"],
            [address objectForKey:@"City"],
            [address objectForKey:@"State"],
            [address objectForKey:@"ZIP"]];
}

- (NSString *)socialHandle:(NSString *)service
{
    ABMultiValue *socials = [self valueForProperty:@"SocialProfile"];
    for (NSString *identifier in socials) {
        NSDictionary *social = [socials valueForIdentifier:identifier];
        if ([[social objectForKey:@"serviceName"] isEqual:service]) {
           return [social objectForKey:@"username"];
        }
    }
    return nil;
}

- (NSString *)chatHandle:(NSString *)service
{
    ABMultiValue *ims = [self valueForProperty:@"InstantMessage"];
    for (NSString *identifier in ims) {
        NSDictionary *im = [ims valueForIdentifier:identifier];
        if ([[im objectForKey:@"InstantMessageService"] isEqual:[service stringByAppendingString:@"Instant"]]) {
            return [im objectForKey:@"InstantMessageUsername"];
        }
    }
    return nil;
}

- (NSDictionary *)asDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setValue:[self uniqueId] forKey:@"uid"];
    
    [dict setValue:[self valueForProperty:kABFirstNameProperty] forKey:@"first_name"];
    [dict setValue:[self valueForProperty:kABLastNameProperty] forKey:@"last_name"];
    [dict setValue:[self valueForProperty:kABNicknameProperty] forKey:@"nickname"];
    [dict setValue:[self valueForProperty:kABOrganizationProperty] forKey:@"company"];
    
    [dict setValue:[self primaryValueForProperty:kABEmailProperty] forKey:@"email"];
    [dict setValue:[self primaryValueForProperty:kABPhoneProperty] forKey:@"phone"];
    [dict setValue:[self primaryAddress] forKey:@"address"];
    
    [dict setValue:[self socialHandle:@"Twitter"] forKey:@"twitter"];
    [dict setValue:[self socialHandle:@"Facebook"] forKey:@"facebook"];
    [dict setValue:[self socialHandle:@"LinkedIn"] forKey:@"linkedin"];
    
    if ([[self valueForProperty:kABLastNameProperty] isEqual:@"Black"]) {
        NSLog(@"%@", self);
        NSLog(@"%@", [self socialHandle:@"Twitter"]);
    }
    
    [dict setValue:[self chatHandle:@"AIM"] forKey:@"aim"];
    [dict setValue:[self chatHandle:@"Jabber"] forKey:@"jabber"];
    
    //UIImage *image = [CIImage imageWithData:self.imageData];
    //[dict setValue:UIImageJPEGRepresentation(image, 1.0) forKey:@"image"];
    
    [dict setValue:[NSNumber numberWithBool:[self isEqual:[[ABAddressBook sharedAddressBook] me]]] forKey:@"me"];
    
    return dict;
}

@end
