//
//  TBMainViewController.m
//  ZxingDemo
//
//  Created by Jarvis on 14-8-4.
//  Copyright (c) 2014年 com.thongbin. All rights reserved.
//

#import "TBMainViewController.h"

@interface TBMainViewController ()
{
    
}
@property (strong, nonatomic) IBOutlet UITextView *_contentTextView;
@property (strong, nonatomic) IBOutlet UIImageView *_codeImage;
@property (strong, nonatomic) IBOutlet UIButton *_launchScanButton;
@property (strong, nonatomic) IBOutlet UIButton *_generateButton;

@end

@implementation TBMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - Button Action
- (IBAction)launchScan:(id)sender {
    TBCaptureViewController *capturer = [TBCaptureViewController new];
    capturer.delegate = self;
    
    [self presentViewController:capturer animated:YES completion:^(){}];
    
}

- (IBAction)genreateQRCode:(id)sender {
    
}

#pragma mark - TBCaptureViewControllerDelegate
-(void)captureResult:(ZXCapture *)capture result:(ZXResult *)result barcodeFormat:(NSString *)barcodeFormat
{
    [__contentTextView setText:[NSString stringWithFormat:@"%@\n%@",barcodeFormat,result.text]];
    [__codeImage setImage:[UIImage imageWithCGImage:capture.lastScannedImage]];
}
@end
