//
//  Parser.h
//  GetOnThatBus
//
//  Created by Diego Cichello on 1/20/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParserDelegate <NSObject>




@end

@interface Parser : NSObject




@property (nonatomic,weak) id<ParserDelegate> delegate;

+ (NSMutableArray *) populateBusStopsArray;

@end
