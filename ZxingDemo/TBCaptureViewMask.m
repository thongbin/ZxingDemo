//
//  TBCaptureViewMask.m
//  ZxingDemo
//
//  Created by Jarvis on 14-8-4.
//  Copyright (c) 2014年 com.thongbin. All rights reserved.
//

#import "TBCaptureViewMask.h"

@implementation TBCaptureViewMask
{
    UIImageView *_scan_icon_00;
    UIImageView *_scan_icon_01;
    UIImageView *_barcode_scan_box_top;
    UIImageView *_barcode_scan_box_mid;
    UIImageView *_barcode_scan_box_bottom;
    UIImageView *_maskImageView;
    UIImageView *_barcode_effect_line1;
    UIImageView *_barcode_effect_line2;
    
    UIButton *_cancelButton;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        _maskImageView = [[UIImageView alloc]initWithFrame:frame];
        [_maskImageView setImage:[UIImage imageNamed:@"barcode_scan_back"]];
        [self addSubview:_maskImageView];
        
        _scan_icon_00 = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/4 - 28, 40, 56.0, 46)];
        [_scan_icon_00 setImage:[UIImage imageNamed:@"scan_icon0"]];
        [self addSubview:_scan_icon_00];
        
        _scan_icon_01 = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/4*3 - 28, 40, 56.0, 46)];
        [_scan_icon_01 setImage:[UIImage imageNamed:@"scan_icon1"]];
        [self addSubview:_scan_icon_01];
        
        _barcode_scan_box_top = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, 226.0, 23.5)];
        [_barcode_scan_box_top setImage:[UIImage imageNamed:@"barcode_scan_box_top"]];
        [_barcode_scan_box_top setCenter:CGPointMake(self.frame.size.width/2, 150.0)];
        [self addSubview:_barcode_scan_box_top];
        
        _barcode_scan_box_mid = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, 226.0, 176.5)];
        [_barcode_scan_box_mid setImage:[[UIImage imageNamed:@"barcode_scan_box_mid"] stretchableImageWithLeftCapWidth:1 topCapHeight:0]];
        [_barcode_scan_box_mid setCenter:CGPointMake(self.frame.size.width/2, 250.0)];
        [self addSubview:_barcode_scan_box_mid];
        
        _barcode_scan_box_bottom = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, 226.0, 23.5)];
        [_barcode_scan_box_bottom setImage:[UIImage imageNamed:@"barcode_scan_box_bottom"]];
        [_barcode_scan_box_bottom setCenter:CGPointMake(self.frame.size.width/2, 350.0)];
        [self addSubview:_barcode_scan_box_bottom];
        
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setFrame:CGRectMake(0, 0, 32, 32)];
        [_cancelButton setCenter:CGPointMake(30, self.frame.size.height/25*24 - _cancelButton.frame.size.height/2)];
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"barcode_close_btn"] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelScanAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
    }
    return self;
}

-(void)cancelScanAction:(id)sender
{
    [_scan_icon_00 removeFromSuperview];
    [_scan_icon_01 removeFromSuperview];
    [_barcode_scan_box_top removeFromSuperview];
    [_barcode_scan_box_mid removeFromSuperview];
    [_barcode_scan_box_bottom removeFromSuperview];
    [_maskImageView removeFromSuperview];
    [_barcode_effect_line1 removeFromSuperview];
    [_barcode_effect_line2 removeFromSuperview];
    
    _cancelButton = nil;
    if ([_delegate respondsToSelector:@selector(cancelScan)]) {
        [_delegate cancelScan];
    }

}

#pragma mark - Public Method
-(void)startOnceScanEffect
{
    _barcode_effect_line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, 214, 55)];
    [_barcode_effect_line1 setImage:[UIImage imageNamed:@"barcode_effect_line1"]];
    [_barcode_effect_line1 setCenter:CGPointMake(self.frame.size.width/2, 130.0)];
    [self addSubview:_barcode_effect_line1];
    
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(){
                         _barcode_effect_line1.transform = CGAffineTransformMakeTranslation(0,205);
                    }
                     completion:^(BOOL finished){
                         [_barcode_effect_line1 removeFromSuperview];
                         [self startRoundScanEffect];
                     }];
    
}

-(void)startRoundScanEffect
{
    _barcode_effect_line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, 214, 10)];
    [_barcode_effect_line2 setImage:[UIImage imageNamed:@"barcode_effect_line2"]];
    [_barcode_effect_line2 setCenter:CGPointMake(self.frame.size.width/2, 355.0)];
    [self addSubview:_barcode_effect_line2];
    
    [self startScanAnimation];
    
}

-(void)startScanAnimation
{
    [UIView animateWithDuration:1.5f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse
                         animations:^(){
                             _barcode_effect_line2.transform = CGAffineTransformMakeTranslation(0.0f, -210.0f);
                             _barcode_effect_line2.transform = CGAffineTransformIdentity;
                             _barcode_effect_line2.transform = CGAffineTransformMakeTranslation(0.0f, -210.0f);
                         }
                         completion:^(BOOL finished){
                         }];
}

- (void)dealloc
{
    _scan_icon_00 = nil;
    _scan_icon_01 = nil;
    _barcode_scan_box_top = nil;
    _barcode_scan_box_mid = nil;
    _barcode_scan_box_bottom = nil;
    _maskImageView = nil;
    _barcode_effect_line1 = nil;
    _barcode_effect_line2 = nil;
    
    _cancelButton = nil;
}
@end
