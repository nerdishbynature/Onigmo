#import <Foundation/Foundation.h>

extern NSString *const OnigmoErrorDomain;

@interface NSError (OnigmoError)

+ (NSError *)onigmo_errorWithCode:(int)code;

@end
