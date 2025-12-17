//
//  HVCrashInstallation.h
//
//  Created by Karl Stenerud on 2013-02-10.
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

#import <Foundation/Foundation.h>
#import <HVCrashGuard/HVCrashReportFilter.h>
#import <HVCrashGuard/HVCrashReportWriter.h>

NS_ASSUME_NONNULL_BEGIN

@class HVCrashConfiguration;

/**
 * Crash system installation which handles backend-specific details.
 *
 * Only one installation can be installed at a time.
 *
 * This is an abstract class.
 */
NS_SWIFT_NAME(HVCrashInstallation)
@interface HVCrashInstallation : NSObject

/** C Function to call during a crash report to give the callee an opportunity to
 * add to the report. NULL = ignore.
 *
 * WARNING: Only call async-safe functions from this function! DO NOT call
 * Swift/Objective-C methods!!!
 */
@property(atomic, readwrite, assign, nullable) HVReportWriteCallback onCrash;

/** Flag for disabling built-in demangling pre-filter.
 * If enabled an additional `HVCrashReportFilterDemangle` filter will be applied first.
 * @note Enabled by-default.
 */
@property(nonatomic, assign) BOOL isDemangleEnabled;

/** Flag for disabling a pre-filter for automated diagnostics.
 * If enabled an additional `HVCrashReportFilterDoctor` filter will be applied.
 * @note Enabled by-default.
 */
@property(nonatomic, assign) BOOL isDoctorEnabled;

/** Install this crash handler with a specific configuration.
 * Call this method instead of `-[HVCrash installWithConfiguration:error:]` to set up the crash handler
 * tailored for your specific backend requirements.
 *
 * @param configuration The configuration object containing the settings for the crash handler.
 * @param error         On input, a pointer to an error object. If an error occurs, this pointer
 *                      is set to an actual error object containing the error information.
 *                      You may specify nil for this parameter if you do not want the error information.
 *                      See HVCrashError.h for specific error codes that may be returned.
 *
 * @return YES if the installation was successful, NO otherwise.
 *
 * @note The `crashNotifyCallback` property of the provided `HVCrashConfiguration` will not take effect
 *       when using this method. The callback will be internally managed to ensure proper integration
 *       with the backend.
 *
 * @see HVCrashError.h for a complete list of possible error codes.
 */
- (BOOL)installWithConfiguration:(HVCrashConfiguration *)configuration error:(NSError **)error;

/** Convenience method to call -[HVCrash sendAllReportsWithCompletion:].
 * This method will set the HVCrash sink and then send all outstanding reports.
 *
 * Note: Pay special attention to HVCrash's "deleteBehaviorAfterSendAll" property.
 *
 * @param onCompletion Called when sending is complete (nil = ignore).
 */
- (void)sendAllReportsWithCompletion:(nullable HVCrashReportFilterCompletion)onCompletion;

/** Add a filter that gets executed before all normal filters.
 * Prepended filters will be executed in the order in which they were added.
 *
 * @param filter the filter to prepend.
 */
- (void)addPreFilter:(id<HVCrashReportFilter>)filter;

/** Creates a sink to be used for reports sending.
 * @note Subclasses MUST implement this, otherwise `sendAllReportsWithCompletion:` will complete with error.
 *
 * @return An instance that implements `HVCrashReportFilter` protocol to be used as a reports sending sink.
 */
- (id<HVCrashReportFilter>)sink;



/** Validates properties of installation.
 *
 * Intended to be overriden in subclasses to handle properties validation
 * in the installation logic (e.g. before sending crash reports).
 *
 * @param error Pointer to an error object to store validation error.
 * @return `NO` if there is a validation error.
 */
- (BOOL)validateSetupWithError:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
