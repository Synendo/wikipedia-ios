#import <MapKit/MapKit.h>

@interface MKMapItem (Extensions)

+ (nullable MKMapItem *)mapItemWithLatitudeString:(nullable NSString *)latitudeString
                                  longitudeString:(nullable NSString *)longitudeString
                                             name:(nullable NSString *)name;

- (MKPointAnnotation *_Nonnull)annotation;

@end
