//
//  GastownPicturesTests.m
//  GastownPicturesTests
//
//  Created by Ian MacKinnon on 2015-06-04.
//  Copyright (c) 2015 Ian MacKinnon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LocationGram.h"

#define DEFAULT_NUM_LOCATIONS 4

@interface GastownPicturesTests : XCTestCase{
    NSMutableArray *_locations;
}

@end

@implementation GastownPicturesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _locations = [[NSMutableArray alloc] init];
    
    for (int i =0; i<DEFAULT_NUM_LOCATIONS; i++){
        LocationGram *location = [[LocationGram alloc] init];
        [_locations addObject:location];
    }
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    _locations = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(true, @"Pass");
}

-(void) testNumberOfLocations{
    //This is a bad test for reasons I'll get into below vvvvvvvv
    //The key reason is that the "4" is a "magic number" set twice
    //So we move the magic number to a constant
    XCTAssert([_locations count] ==DEFAULT_NUM_LOCATIONS, @"Pass");
}

- (void)testIansAge {
    // This is an example of a functional test case.
    XCTAssert(33 == [self helperToGetIansAge], @"Pass");
}


-(void) testLocationGramInitializer{
    
    NSDictionary *dict = @{@"user":@{@"username":@"imack"}, @"location":@{@"latitude":@49.0, @"longitude": @-123}};
    
    LocationGram *gram = [[LocationGram alloc] initWithJson:dict];
    
    XCTAssert([gram.title isEqualToString:@"imack"], @"Pass");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(int)helperToGetIansAge{
    return 33;
}

@end
