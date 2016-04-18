//
//  OnigmoRegex.m
//  EditorKit
//
//  Created by Piet Brauer on 18/04/16.
//  Copyright © 2016 nerdish by nature. All rights reserved.
//

#import "OnigmoRegex.h"
#import "oniguruma.h"

NSString *const OnigmoErrorDomain = @"OnigmoErrorDomain";

@interface OnigmoRegularExpression ()
@property (nonatomic, nonnull) regex_t *reg;
@end

@implementation OnigmoRegularExpression

+ (OnigmoRegularExpression *)regularExpressionWithPattern:(NSString *)pattern options:(OnigmoRegularExpressionOptions)options error:(NSError * _Nullable __autoreleasing *)error {
    return [[self alloc] initWithPattern:pattern options:options error:error];
}

- (instancetype)initWithPattern:(NSString *)pattern options:(OnigmoRegularExpressionOptions)options error:(NSError * _Nullable __autoreleasing *)error {
    self = [super init];
    if (self) {
        int r;
        OnigErrorInfo einfo;
        const UChar *cPattern = (UChar* )[pattern cStringUsingEncoding:NSUTF8StringEncoding];

        int success = onig_new(&_reg, cPattern, cPattern + strlen((char *)cPattern), options, ONIG_ENCODING_ASCII, ONIG_SYNTAX_DEFAULT, &einfo);
        if (success != ONIG_NORMAL) {
            char s[ONIG_MAX_ERROR_MESSAGE_LEN];
            onig_error_code_to_str((OnigUChar *)s, r, &einfo);
            *error = [NSError errorWithDomain:OnigmoErrorDomain code:r userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithCString:s encoding:NSUTF8StringEncoding]}];
            return nil;
        }
    }

    return self;
}

- (NSDictionary<NSString *,NSValue *> *__nullable)matchesInString:(NSString *)string error:(NSError **)error {
    unsigned char *str = (unsigned char *)[string cStringUsingEncoding:NSUTF8StringEncoding];
    OnigRegion *region = onig_region_new();

    NSMutableDictionary *_matches = [NSMutableDictionary dictionary];
    unsigned char *end = str + strlen((char* )str);
    unsigned char *start = str;
    unsigned char *range = end;

    int r = onig_search(self.reg, str, end, start, range, region, ONIG_OPTION_NONE);
    if (r >= 0) {
        for (int i = 0; i < region->num_regs; i++) {
            int length = region->end[i] - region->beg[i];
            NSRange range = NSMakeRange(region->beg[i], length);
            [_matches setValue:[NSValue valueWithRange:range] forKey:@(i).stringValue];
        }
    } else if (r == ONIG_MISMATCH) {
        return nil;
    } else { /* error */
        char s[ONIG_MAX_ERROR_MESSAGE_LEN];
        onig_error_code_to_str((unsigned char *)s, r);
        *error = [NSError errorWithDomain:OnigmoErrorDomain code:r userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithCString:s encoding:NSUTF8StringEncoding]}];
        return nil;
    }

    onig_region_free(region, 1 /* 1:free self, 0:free contents only */);
    onig_end();
    return _matches.copy;
}

- (NSString *)compiledPattern {
    return [NSString stringWithCString:(const char *)self.reg->p encoding:NSUTF8StringEncoding];
}

- (OnigEncoding)encoding {
    return self.reg->enc;
}

@end
