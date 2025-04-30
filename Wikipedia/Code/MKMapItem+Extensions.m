#import "MKMapItem+Extensions.h"

@implementation MKMapItem (Extensions)

+ (nullable MKMapItem *)mapItemWithLatitudeString:(nullable NSString *)latitudeString
                                  longitudeString:(nullable NSString *)longitudeString
                                             name:(nullable NSString *)name {
    if (!latitudeString || !longitudeString) {
        return nil;
    }

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];

    NSNumber *latitudeNumber = [formatter numberFromString:latitudeString];
    NSNumber *longitudeNumber = [formatter numberFromString:longitudeString];
    
    if (latitudeNumber && longitudeNumber) {
        double latitude = latitudeNumber.doubleValue;
        double longitude = longitudeNumber.doubleValue;

        BOOL latitudeInRange = latitude >= -90.0 && latitude <= 90.0;
        BOOL longitudeInRange = longitude >= -180.0 && longitude <= 180.0;
        
        if (latitudeInRange && longitudeInRange) {
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate];
            MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];

            if (name != nil) {
                mapItem.name = name;
            }
            
            return mapItem;
        }
    }

    return nil;
}

- (MKPointAnnotation *_Nonnull)annotation {
    CLLocationCoordinate2D coordinate = self.placemark.coordinate;

    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title = self.name;
    annotation.subtitle = [NSString stringWithFormat:@"%f, %f", coordinate.latitude, coordinate.longitude];

    return annotation;
}

@end
