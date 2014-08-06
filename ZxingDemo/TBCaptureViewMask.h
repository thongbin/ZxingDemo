//
//  TBCaptureViewMask.h
//  ZxingDemo
//
//  Created by Jarvis on 14-8-4.
//  Copyright (c) 2014年 com.thongbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TBCaptureViewMaskDelegate <NSObject>

@required
-(void)cancelScan:(id)sender;

@optional
-(void)pickImageFromPhotoLibrary:(id)sender;
@end

@interface TBCaptureViewMask : UIView

@property (nonatomic , weak)id<TBCaptureViewMaskDelegate> delegate;

-(void)startOnceScanEffect;

-(void)startRoundScanEffect;

@end
