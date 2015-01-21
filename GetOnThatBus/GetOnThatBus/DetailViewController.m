//
//  DetailViewController.m
//  GetOnThatBus
//
//  Created by Diego Cichello on 1/20/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *busStopName;

@property (weak, nonatomic) IBOutlet UILabel *routesLabel;

@property (weak, nonatomic) IBOutlet UILabel *metraLabel;
@property (weak, nonatomic) IBOutlet UILabel *paceLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.busStopName.text = self.currentBusStop.stopName;
    self.routesLabel.text = self.currentBusStop.routes;
    if (self.currentBusStop.isMetroModal)
    {
        self.metraLabel.text = @"Yes";
    }
    if (self.currentBusStop.isPaceModal)
    {
        self.paceLabel.text = @"Yes";
    }


}





@end
