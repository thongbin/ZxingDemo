//
//  TBCaptureViewController.m
//  ZxingDemo
//
//  Created by Jarvis on 14-8-4.
//  Copyright (c) 2014年 com.thongbin. All rights reserved.
//

#import "TBCaptureViewController.h"
#import "TBCaptureViewMask.h"

@interface TBCaptureViewController ()

@property (nonatomic, strong) ZXCapture *capture;
@property (nonatomic, strong) TBCaptureViewMask *scanRectView;

@end

@implementation TBCaptureViewController

#pragma mark - View Controller Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.rotation = 90.0f;
    
    self.capture.layer.frame = self.view.bounds;
    CGAffineTransform captureSizeTransform = CGAffineTransformMakeScale(320 / self.view.frame.size.width, 480 / self.view.frame.size.height);
    self.capture.scanRect = CGRectApplyAffineTransform(self.scanRectView.frame, captureSizeTransform);
    [self.view.layer addSublayer:self.capture.layer];
    self.capture.delegate = self;
    
    _scanRectView = [[TBCaptureViewMask alloc]initWithFrame:self.view.frame];
    _scanRectView.delegate = self;
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_scanRectView];
    [self.view bringSubviewToFront:self.scanRectView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_capture.running) {
        [_scanRectView startOnceScanEffect];
    }

}

#pragma mark - Private Methods

- (NSString *)barcodeFormatToString:(ZXBarcodeFormat)format {
    switch (format) {
        case kBarcodeFormatAztec:
            return @"Aztec";
            
        case kBarcodeFormatCodabar:
            return @"CODABAR";
            
        case kBarcodeFormatCode39:
            return @"Code 39";
            
        case kBarcodeFormatCode93:
            return @"Code 93";
            
        case kBarcodeFormatCode128:
            return @"Code 128";
            
        case kBarcodeFormatDataMatrix:
            return @"Data Matrix";
            
        case kBarcodeFormatEan8:
            return @"EAN-8";
            
        case kBarcodeFormatEan13:
            return @"EAN-13";
            
        case kBarcodeFormatITF:
            return @"ITF";
            
        case kBarcodeFormatPDF417:
            return @"PDF417";
            
        case kBarcodeFormatQRCode:
            return @"QR Code";
            
        case kBarcodeFormatRSS14:
            return @"RSS 14";
            
        case kBarcodeFormatRSSExpanded:
            return @"RSS Expanded";
            
        case kBarcodeFormatUPCA:
            return @"UPCA";
            
        case kBarcodeFormatUPCE:
            return @"UPCE";
            
        case kBarcodeFormatUPCEANExtension:
            return @"UPC/EAN extension";
            
        default:
            return @"Unknown";
    }
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    if (!result)
    {
        return;
    }
    // We got a result. Display information about the result onscreen.
    NSString *formatString = [self barcodeFormatToString:result.barcodeFormat];
    
    
    if ([_delegate respondsToSelector:@selector(captureResult:result:barcodeFormat:)]) {
        [_delegate captureResult:capture result:result barcodeFormat:formatString];
    }
    
    // Vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [self cancelScan:nil];
}

#pragma  mark -  TBCaptureViewMaskDelegate
-(void)cancelScan:(id)sender
{
    [_capture stop];
    if (![self.presentedViewController isBeingDismissed]) {
            [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)pickImageFromPhotoLibrary:(id)sender
{
    UIImagePickerController *_pickerController = [UIImagePickerController new];
    _pickerController.allowsEditing = YES;
    _pickerController.delegate = self;
    _pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_pickerController animated:YES completion:^(){
        [_capture stop];
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:^{
        
        CGImageRef imageToDecode = [image CGImage];  // Given a CGImage in which we are looking for barcodes
        
        ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
        ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
        
        NSError *error = nil;
        
        // There are a number of hints we can give to the reader, including
        // possible formats, allowed lengths, and the string encoding.
        ZXResult *result = [_capture.reader decode:bitmap
                                    hints:_capture.hints
                                    error:&error];
        if (result) {
            [_capture.delegate captureResult:_capture result:result];
        } else {
            // Use error to determine why we didn't get a result, such as a barcode
            // not being found, an invalid checksum, or a format inconsistency.
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        [_capture start];
    }];
}
@end
