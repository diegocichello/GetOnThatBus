//
//  ViewController.m
//  MobileMapper
//
//  Created by Diego Cichello on 1/20/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property MKPointAnnotation *mobileMakersAnnotation;
@property CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(37.790752,-122.402071);
    self.mobileMakersAnnotation = [MKPointAnnotation new];
    self.mobileMakersAnnotation.coordinate = coordinate;
    self.mobileMakersAnnotation.title = @"Mobile Makers";

    [self.mapView addAnnotation:self.mobileMakersAnnotation];

    [self makePinInAddress:@"Mount Rushmore"];
    [self makePinInAddress:@"Golden Gate Bridge"];
    [self makePinInAddress:@"Statue of Liberty"];
    [self makePinInAddress:@"Cristo Redentor, Rio de Janeiro"];

    self.locationManager = [[CLLocationManager alloc]init];


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.locationManager requestAlwaysAuthorization];
    self.mapView.showsUserLocation = YES;

}

- (void) makePinInAddress: (NSString *)string
{
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:string completionHandler:^(NSArray *placemarks, NSError *error)
    {
        for (CLPlacemark *placemark in placemarks)
        {
            MKPointAnnotation *annotation = [MKPointAnnotation new];
            annotation.coordinate = placemark.location.coordinate;
            annotation.title = placemark.name;

            [self.mapView addAnnotation:annotation];
        }
    }];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    CLLocationCoordinate2D coordinate = view.annotation.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region animated:true];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    if ([annotation.title isEqualToString:@"Mobile Makers"])
    {
        pin.image = [UIImage imageNamed:@"mobilemakers"];
    }
    pin.canShowCallout = YES;

    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];


    return pin;
    
}


@end
