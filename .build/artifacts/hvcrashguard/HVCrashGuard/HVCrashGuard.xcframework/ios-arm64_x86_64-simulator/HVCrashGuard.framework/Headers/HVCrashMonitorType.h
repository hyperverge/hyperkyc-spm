//
//  HVCrashMonitorType.h
//
//  Copyright (c) 2012 Karl Stenerud. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall remain in place
// in this source code.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#ifndef HDR_HVCrashMonitorType_h
#define HDR_HVCrashMonitorType_h

#ifdef __OBJC__
#include <Foundation/Foundation.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifndef NS_SWIFT_NAME
#define NS_SWIFT_NAME(_name)
#endif

// clang-format off

/** Various aspects of the system that can be monitored:
 * - Mach kernel exception
 * - Fatal signal
 * - Uncaught C++ exception
 * - Uncaught Objective-C NSException
 * - Deadlock on the main thread
 * - User reported custom exception
 */
typedef
#ifdef __OBJC__
NS_OPTIONS(NSUInteger, HVCrashMonitorType)
#else /* __OBJC__ */
enum
#endif /* __OBJC__ */
{
    /** No monitoring. */
    HVCrashMonitorTypeNone               = 0,

    /** Monitor Mach kernel exceptions. */
    HVCrashMonitorTypeMachException      = 1 << 0,

    /** Monitor fatal signals. */
    HVCrashMonitorTypeSignal             = 1 << 1,

    /** Monitor uncaught C++ exceptions. */
    HVCrashMonitorTypeCPPException       = 1 << 2,

    /** Monitor uncaught Objective-C NSExceptions. */
    HVCrashMonitorTypeNSException        = 1 << 3,

    /** Detect deadlocks on the main thread. */
    HVCrashMonitorTypeMainThreadDeadlock = 1 << 4,

    /** Monitor user-reported custom exceptions. */
    HVCrashMonitorTypeUserReported       = 1 << 5,

    /** Track and inject system information. */
    HVCrashMonitorTypeSystem             = 1 << 6,

    /** Track and inject application state information. */
    HVCrashMonitorTypeApplicationState   = 1 << 7,

    /** Track memory issues and last zombie NSException. */
    HVCrashMonitorTypeZombie             = 1 << 8,

    /** Monitor memory to detect OOMs at startup. */
    HVCrashMonitorTypeMemoryTermination  = 1 << 9,

    /** Enable all monitoring options. */
    HVCrashMonitorTypeAll = (
                             HVCrashMonitorTypeMachException |
                             HVCrashMonitorTypeSignal |
                             HVCrashMonitorTypeCPPException |
                             HVCrashMonitorTypeNSException |
                             HVCrashMonitorTypeMainThreadDeadlock |
                             HVCrashMonitorTypeUserReported |
                             HVCrashMonitorTypeSystem |
                             HVCrashMonitorTypeApplicationState |
                             HVCrashMonitorTypeZombie |
                             HVCrashMonitorTypeMemoryTermination
                             ),

    /** Fatal monitors track exceptions that lead to error termination of the process.. */
    HVCrashMonitorTypeFatal = (
                               HVCrashMonitorTypeMachException |
                               HVCrashMonitorTypeSignal |
                               HVCrashMonitorTypeCPPException |
                               HVCrashMonitorTypeNSException |
                               HVCrashMonitorTypeMainThreadDeadlock
                               ),

    /** Enable experimental monitoring options. */
    HVCrashMonitorTypeExperimental = HVCrashMonitorTypeMainThreadDeadlock,

    /** Monitor options unsafe for use with a debugger. */
    HVCrashMonitorTypeDebuggerUnsafe = HVCrashMonitorTypeMachException,

    /** Monitor options that are async-safe. */
    HVCrashMonitorTypeAsyncSafe = (HVCrashMonitorTypeMachException | HVCrashMonitorTypeSignal),

    /** Optional monitor options. */
    HVCrashMonitorTypeOptional = HVCrashMonitorTypeZombie,

    /** Monitor options that are async-unsafe. */
    HVCrashMonitorTypeAsyncUnsafe = (HVCrashMonitorTypeAll & (~HVCrashMonitorTypeAsyncSafe)),

    /** Monitor options safe to enable in a debugger. */
    HVCrashMonitorTypeDebuggerSafe = (HVCrashMonitorTypeAll & (~HVCrashMonitorTypeDebuggerUnsafe)),

    /** Monitor options safe for production environments. */
    HVCrashMonitorTypeProductionSafe = (HVCrashMonitorTypeAll & (~HVCrashMonitorTypeExperimental)),

    /** Minimal set of production-safe monitor options. */
    HVCrashMonitorTypeProductionSafeMinimal = (HVCrashMonitorTypeProductionSafe & (~HVCrashMonitorTypeOptional)),

    /** Required monitor options for essential operation. */
    HVCrashMonitorTypeRequired = (
                                  HVCrashMonitorTypeSystem |
                                  HVCrashMonitorTypeApplicationState
                                  ),

    /** Disable automatic reporting; only manual reports are allowed. */
    HVCrashMonitorTypeManual = (HVCrashMonitorTypeRequired | HVCrashMonitorTypeUserReported)
} NS_SWIFT_NAME(MonitorType)
#ifndef __OBJC__
HVCrashMonitorType
#endif
;

// clang-format on

#ifdef __cplusplus
}
#endif

#endif  // HDR_HVCrashMonitorType_h
