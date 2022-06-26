#import "screenlock.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

void Screenlock::setDisabled(bool isDisabled) {
    if (isDisabled)
        [[UIApplication sharedApplication] setIdleTimerDisabled: YES]
    else
        [[UIApplication sharedApplication] setIdleTimerDisabled: NO]
}
