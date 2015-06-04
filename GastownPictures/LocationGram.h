//
//  LocationGram.h
//  GastownPictures
//
//  Created by Ian MacKinnon on 2015-06-04.
//  Copyright (c) 2015 Ian MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationGram : NSObject<MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(copy, nonatomic) NSString *title;

@property(copy, nonatomic) NSString *imageUrl;

-(instancetype) initWithJson:(NSDictionary*)dict;

@end
