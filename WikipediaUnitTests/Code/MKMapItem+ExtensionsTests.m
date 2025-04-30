#import <XCTest/XCTest.h>
#import "MKMapItem+Extensions.h"

@interface MKMapItem_ExtensionsTests : XCTestCase
@end

@implementation MKMapItem_ExtensionsTests

- (void)testValidCoordinatesWithName {
    MKMapItem *item = [MKMapItem mapItemWithLatitudeString:@"37.7749"
                                           longitudeString:@"-122.4194"
                                                      name:@"San Francisco"];
    
    XCTAssertNotNil(item);
    XCTAssertEqualWithAccuracy(item.placemark.coordinate.latitude, 37.7749, 0.0001);
    XCTAssertEqualWithAccuracy(item.placemark.coordinate.longitude, -122.4194, 0.0001);
    XCTAssertEqualObjects(item.name, @"San Francisco");
}

- (void)testInvalidCoordinatesWithCommaDecimal {
    MKMapItem *item = [MKMapItem mapItemWithLatitudeString:@"37,7749"
                                           longitudeString:@"-122,4194"
                                                      name:@"San Francisco"];
    
    XCTAssertNil(item); // Commas aren't valid in en_US_POSIX
}

- (void)testValidCoordinatesWithoutName {
    MKMapItem *item = [MKMapItem mapItemWithLatitudeString:@"40.7128"
                                           longitudeString:@"-74.0060"
                                                      name:nil];
    
    XCTAssertNotNil(item);
    XCTAssertEqualWithAccuracy(item.placemark.coordinate.latitude, 40.7128, 0.0001);
    XCTAssertEqualWithAccuracy(item.placemark.coordinate.longitude, -74.0060, 0.0001);
    // item.name will be "Unknown Location", but that's implemented in MKMapItem, not is the category.
}

- (void)testNilLatitude {
    MKMapItem *item = [MKMapItem mapItemWithLatitudeString:nil
                                           longitudeString:@"-74.0060"
                                                      name:@"New York"];
    
    XCTAssertNil(item);
}

- (void)testNilLongitude {
    MKMapItem *item = [MKMapItem mapItemWithLatitudeString:@"40.7128"
                                           longitudeString:nil
                                                      name:@"New York"];
    
    XCTAssertNil(item);
}

- (void)testInvalidLatitudeString {
    MKMapItem *item = [MKMapItem mapItemWithLatitudeString:@"abc"
                                           longitudeString:@"-74.0060"
                                                      name:@"Invalid"];
    
    XCTAssertNil(item);
}

- (void)testInvalidLongitudeString {
    MKMapItem *item = [MKMapItem mapItemWithLatitudeString:@"40.7128"
                                           longitudeString:@"xyz"
                                                      name:@"Invalid"];
    
    XCTAssertNil(item);
}

- (void)testLatitudeOutOfRange {
    MKMapItem *item = [MKMapItem mapItemWithLatitudeString:@"100.0"
                                           longitudeString:@"0.0"
                                                      name:@"OutOfRange"];
    
    XCTAssertNil(item);
}

- (void)testLongitudeOutOfRange {
    MKMapItem *item = [MKMapItem mapItemWithLatitudeString:@"0.0"
                                           longitudeString:@"200.0"
                                                      name:@"OutOfRange"];
    
    XCTAssertNil(item);
}

- (void)testAnnotation {
    NSString *latitude = @"37.7749";
    NSString *longitude = @"-122.4194";
    NSString *name = @"San Francisco";

    MKMapItem *mapItem = [MKMapItem mapItemWithLatitudeString:latitude
                                              longitudeString:longitude
                                                         name:name];
    
    XCTAssertNotNil(mapItem);

    MKPointAnnotation *annotation = [mapItem annotation];
    XCTAssertNotNil(annotation);

    XCTAssertEqualWithAccuracy(annotation.coordinate.latitude, 37.7749, 0.0001);
    XCTAssertEqualWithAccuracy(annotation.coordinate.longitude, -122.4194, 0.0001);
    XCTAssertEqualObjects(annotation.title, @"San Francisco");
    XCTAssertEqualObjects(annotation.subtitle, @"37.774900, -122.419400");
}

@end
