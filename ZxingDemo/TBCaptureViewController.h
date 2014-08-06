//
//  TBCaptureViewController.h
//  ZxingDemo
//
//  Created by Jarvis on 14-8-4.
//  Copyright (c) 2014年 com.thongbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZXingObjC/ZXingObjC.h>
#import "TBCaptureViewMask.h"

@protocol TBCaptureViewControllerDelegate <NSObject>

@required
-(void)captureResult:(ZXCapture *)capture
              result:(ZXResult *)result
       barcodeFormat:(NSString*)barcodeFormat;

@end

@interface TBCaptureViewController : UIViewController
<
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
ZXCaptureDelegate,
TBCaptureViewMaskDelegate
>

@property (nonatomic , weak)id<TBCaptureViewControllerDelegate> delegate;
@end
