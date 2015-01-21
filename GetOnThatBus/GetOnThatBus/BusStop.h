//
//  BusStop.h
//  GetOnThatBus
//
//  Created by Diego Cichello on 1/20/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BusStop : NSObject


@property NSNumber *longitude;
@property NSNumber *latitude;
@property NSString *stopName;
@property NSString *routes;
@property BOOL isMetroModal;
@property BOOL isPaceModal;



+ (void) setAllBusStopsInMap:(NSMutableArray *)busStops :(MKMapView *)mapView;
+ (CLLocationCoordinate2D) centerOfAllBusStops: (NSMutableArray *) busStops;
+ (BusStop *) getBusStopFromTitle:(NSString *)title :(NSMutableArray *)busStops;
+ (BusStop *) getBusStopFromTitle:(NSString *)title inBusStopsArray:(NSMutableArray *)busStops;




@end
