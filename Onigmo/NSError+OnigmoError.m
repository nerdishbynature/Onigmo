#import "NSError+OnigmoError.h"
#import "oniguruma.h"

NSString *const OnigmoErrorDomain = @"OnigmoErrorDomain";

@implementation NSError (OnigmoError)

+ (NSError *)onigmo_errorWithCode:(int)code {
    OnigErrorInfo einfo;
    char s[ONIG_MAX_ERROR_MESSAGE_LEN];
    onig_error_code_to_str((UChar *)s, code, &einfo);
    return [NSError errorWithDomain:OnigmoErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithCString:s encoding:NSUTF8StringEncoding]}];
}

@end
