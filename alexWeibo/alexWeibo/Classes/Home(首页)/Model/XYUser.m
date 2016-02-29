
#import "XYUser.h"

@implementation XYUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}


@end
