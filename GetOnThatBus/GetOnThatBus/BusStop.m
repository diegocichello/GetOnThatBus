//
//  BusStop.m
//  GetOnThatBus
//
//  Created by Diego Cichello on 1/20/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "BusStop.h"
#import "CustomAnnotation.h"

@interface BusStop ()

@property CLLocation *center;

@end


@implementation BusStop



+ (void) setAllBusStopsInMap:(NSMutableArray *) busStops :(MKMapView *)mapView

{
    //NSMutableArray *annotationArray = [NSMutableArray new];
    for (BusStop *busStop in busStops)
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([busStop.latitude floatValue],[busStop.longitude floatValue]) ;
        CustomAnnotation *annotation = [CustomAnnotation new];
        annotation.coordinate = coordinate;
        annotation.title = busStop.stopName;
        annotation.subtitle = [NSString stringWithFormat:@"Routes: %@",busStop.routes];
        annotation.busStop = busStop;
        [mapView addAnnotation:annotation];
        //[annotationArray addObject:annotation];



    }


   // return annotationArray;


}

+ (CLLocationCoordinate2D) centerOfAllBusStops: (NSMutableArray *) busStops
{
    float latitude;
    float longitude;
    for (BusStop *busStop in busStops)
    {
        latitude += [busStop.latitude floatValue];
        longitude += [busStop.longitude floatValue];
    }
    latitude /= busStops.count;
    longitude /= busStops.count;

   

    return CLLocationCoordinate2DMake(latitude, longitude);

}

+ (BusStop *) getBusStopFromTitle: (NSString *)title :(NSMutableArray *)busStops
{
    for (BusStop *busStop in busStops)
    {
        if ([busStop.stopName isEqualToString:title])
        {
            return busStop;
        }
    }
    return nil;
}

@end


