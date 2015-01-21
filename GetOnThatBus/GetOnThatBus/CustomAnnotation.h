//
//  CustomAnnotation.h
//  GetOnThatBus
//
//  Created by Diego Cichello on 1/20/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "BusStop.h"

@interface CustomAnnotation : MKPointAnnotation

@property BusStop *busStop;

@end
