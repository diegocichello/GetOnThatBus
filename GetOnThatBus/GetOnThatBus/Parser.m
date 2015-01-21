//
//  Parser.m
//  GetOnThatBus
//
//  Created by Diego Cichello on 1/20/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "Parser.h"
#import "BusStop.h"

@implementation Parser

+ (NSMutableArray *) populateBusStopsArray
{

    NSMutableArray *busStops = [NSMutableArray new];

    NSString *urlString = @"https://s3.amazonaws.com/mobile-makers-lib/bus.json";
    NSURL *url = [NSURL URLWithString:urlString];


    NSData *urlData = [NSData dataWithContentsOfURL:url];

    NSDictionary *urlDictionary = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:nil];

    NSArray *array = urlDictionary[@"row"];


    for (NSDictionary *dictionary in array)
    {

        BusStop *busStop = [BusStop new];
        busStop.latitude = dictionary[@"latitude"];
        busStop.longitude = dictionary[@"longitude"];
        if ([busStop.longitude floatValue]>0)
        {
            busStop.longitude = [NSNumber numberWithFloat:([busStop.longitude floatValue] * -1)];
        }
        if ([dictionary[@"inter_modal"] isEqualToString:@"Metra"])
        {
            busStop.isMetroModal = true;
        }
        else if ([dictionary[@"inter_modal"] isEqualToString:@"Pace"])
        {
            busStop.isPaceModal = true;
        }
        busStop.routes = dictionary[@"routes"];



        busStop.stopName = dictionary[@"cta_stop_name"];


        [busStops addObject:busStop];
        
        
    }

    return busStops;
}

@end
