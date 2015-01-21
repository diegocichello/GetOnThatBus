//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Diego Cichello on 1/20/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "RootViewController.h"
#import "DetailViewController.h"
#import "BusStop.h"
#import "Parser.h"
#import "CustomAnnotation.h"

@interface RootViewController () <UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property BusStop *currentBusStop;

@property NSMutableArray *busStops;

@end

@implementation RootViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.busStops = [Parser populateBusStopsArray];

    NSMutableArray *annotationsArray = [NSMutableArray new];

    [BusStop setAllBusStopsInMap:self.busStops:self.mapView];  



}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.mapView showAnnotations:self.mapView.annotations animated:YES];

}
- (IBAction)onSegmentedControlChanged:(id)sender
{
    self.tableView.hidden = !self.tableView.hidden;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    BusStop *busStop = [self.busStops objectAtIndex:indexPath.row];

    cell.textLabel.text = busStop.stopName;
    cell.detailTextLabel.text = busStop.routes;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.busStops.count;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
    pin.canShowCallout = YES;

    CustomAnnotation *cAnnotation = annotation;


    if (cAnnotation.busStop.isMetroModal)
    {
        pin.pinColor = MKPinAnnotationColorGreen;
       // pin.image = [UIImage imageNamed:@"MetraLogo"];
    }

    if (cAnnotation.busStop.isPaceModal)
    {
        pin.pinColor = MKPinAnnotationColorPurple;
       // pin.image = [UIImage imageNamed:@"PaceLogo"];
    }

    

    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];


    
    pin.rightCalloutAccessoryView = button;
    return pin;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *detailView = segue.destinationViewController;

    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

    detailView.currentBusStop = [self.busStops objectAtIndex:indexPath.row];


}



- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    DetailViewController *detailView= [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];

    CustomAnnotation *cAnnotation = view.annotation;

    detailView.currentBusStop = cAnnotation.busStop;


    [[self navigationController] pushViewController:detailView animated:YES];
}



@end
