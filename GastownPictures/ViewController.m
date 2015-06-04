//
//  ViewController.m
//  GastownPictures
//
//  Created by Ian MacKinnon on 2015-06-04.
//  Copyright (c) 2015 Ian MacKinnon. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "LocationGram.h"
@interface ViewController ()<MKMapViewDelegate>{
    NSMutableArray *_locations;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.gastownMapView.delegate = self;
    
    MKCoordinateRegion startingRegion;
    CLLocationCoordinate2D loc;
    loc.latitude = 49.281815;
    loc.longitude = -123.108219;
    startingRegion.center = loc;
    startingRegion.span.latitudeDelta = 0.02;
    startingRegion.span.longitudeDelta = 0.02;
    [self.gastownMapView setRegion:startingRegion];
    

    [[AFHTTPRequestOperationManager manager] GET:@"https://api.instagram.com/v1/media/search?lat=49.281815&lng=-123.108219&client_id=531009644bc8430a8ac8404c7d713317" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self.gastownMapView removeAnnotations:self.gastownMapView.annotations];
        
        for (NSDictionary *dict in [responseObject objectForKey:@"data"]){
            _locations = [[NSMutableArray alloc] init];
            
            LocationGram * marker =[[LocationGram alloc] init];
            marker.title = [[dict objectForKey:@"user"] objectForKey:@"username"];
            CLLocationCoordinate2D photoLocation;
            photoLocation.latitude = [[[dict objectForKey:@"location"] objectForKey:@"latitude"] floatValue];
            photoLocation.longitude = [[[dict objectForKey:@"location"] objectForKey:@"longitude"] floatValue];
            marker.coordinate = photoLocation;
            marker.imageUrl = [[[dict objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
            
            [_locations addObject:marker];
            [self.gastownMapView addAnnotation:marker];
        }

       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void) viewDidAppear:(BOOL)animated{

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if (annotation == self.gastownMapView.userLocation){
        return nil; //default to blue dot
    }
    
    static NSString* annotationIdentifier = @"iansApartment";
    
    MKPinAnnotationView* pinView = (MKPinAnnotationView *)
    [self.gastownMapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
    if (!pinView) {
        // if an existing pin view was not available, create one
        pinView = [[MKPinAnnotationView alloc]
                   initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
    }
    
    pinView.canShowCallout = YES;
    pinView.pinColor = MKPinAnnotationColorGreen;
    
    return pinView;
}

- (void)mapView:(MKMapView *)mapView
didSelectAnnotationView:(MKAnnotationView *)view{
    
    LocationGram *locGram = (LocationGram*)view;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
