//
//  LocationGram.m
//  GastownPictures
//
//  Created by Ian MacKinnon on 2015-06-04.
//  Copyright (c) 2015 Ian MacKinnon. All rights reserved.
//

#import "LocationGram.h"

@implementation LocationGram


-(instancetype) initWithJson:(NSDictionary*)dict{
    self = [super init];
    
    if (self){
        self.title = [[dict objectForKey:@"user"] objectForKey:@"username"];
        CLLocationCoordinate2D photoLocation;
        photoLocation.latitude = [[[dict objectForKey:@"location"] objectForKey:@"latitude"] floatValue];
        photoLocation.longitude = [[[dict objectForKey:@"location"] objectForKey:@"longitude"] floatValue];
        self.coordinate = photoLocation;
        self.imageUrl = [[[dict objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
    }
    
    return self;
}


@end
