//
//  HTTPClient.h
//  SpartaLogger
//
//  Created by Ryan Gomba on 11/25/11.
//  Copyright (c) 2011 AppThat. All rights reserved.
//

@interface HTTPClient : NSObject

+ (void)sendReport:(NSMutableDictionary *)dictionary toFile:(NSString *)file;

@end
