#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FIRCollectionReference.h"
#import "FIRDocumentChange.h"
#import "FirebaseFirestore.h"
#import "FIRFieldPath.h"
#import "FIRFieldValue.h"
#import "FIRFirestoreErrors.h"
#import "FIRFirestoreSettings.h"
#import "FIRFirestoreSource.h"
#import "FIRGeoPoint.h"
#import "FIRListenerRegistration.h"
#import "FIRLoadBundleTask.h"
#import "FIRQuerySnapshot.h"
#import "FIRSnapshotMetadata.h"
#import "FIRTimestamp.h"
#import "FIRTransaction.h"
#import "FIRWriteBatch.h"

FOUNDATION_EXPORT double FirebaseFirestoreVersionNumber;
FOUNDATION_EXPORT const unsigned char FirebaseFirestoreVersionString[];

