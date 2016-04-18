#import <Foundation/Foundation.h>
#import "oniguruma.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const OnigmoErrorDomain;

typedef NS_OPTIONS(NSUInteger, OnigmoRegularExpressionOptions) {
    OnigmoOptionDefault = ONIG_OPTION_NONE,
    OnigmoOptionIgnoreCase = ONIG_OPTION_IGNORECASE,
    OnigmoOptionExtend = ONIG_OPTION_EXTEND,
    OnigmoOptionMultiline = ONIG_OPTION_MULTILINE,
    OnigmoOptionSingleLine = ONIG_OPTION_SINGLELINE,
    OnigmoOptionFindLongest = ONIG_OPTION_FIND_LONGEST,
    OnigmoOptionFindNotEmpty = ONIG_OPTION_FIND_NOT_EMPTY,
    OnigmoOptionNegativeSingleLine = ONIG_OPTION_NEGATE_SINGLELINE,
    OnigmoOptionDontCaptureGroup = ONIG_OPTION_DONT_CAPTURE_GROUP,
    OnigmoOptionCaptureGroup = ONIG_OPTION_CAPTURE_GROUP,
    OnigmoOptionNotBol = ONIG_OPTION_NOTBOL,
    OnigmoOptionNotEol = ONIG_OPTION_NOTEOL,
    OnigmoOptionPosixRegion = ONIG_OPTION_POSIX_REGION,
    OnigmoOptionMaxBit = ONIG_OPTION_MAXBIT
};

@interface OnigmoRegularExpression : NSObject

@property (nonatomic, readonly) NSString *compiledPattern;
@property (nonatomic, readonly) OnigEncoding encoding;

+ (nullable OnigmoRegularExpression *)regularExpressionWithPattern:(NSString *)pattern options:(OnigmoRegularExpressionOptions)options error:(NSError **)error;
- (nullable instancetype)initWithPattern:(NSString *)pattern options:(OnigmoRegularExpressionOptions)options error:(NSError **)error NS_DESIGNATED_INITIALIZER;

- (NSDictionary<NSString *,NSValue *> *__nullable)matchesInString:(NSString *)string  error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
