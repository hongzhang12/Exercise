//
//  ZHViewController.m
//  camera
//
//  Created by keke on 4/19/15.
//  Copyright (c) 2015 keke. All rights reserved.
//

#import "ZHViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZHProgressView.h"
#import <QuartzCore/QuartzCore.h>
#import "ZHTakeMovieView.h"
#import <MediaPlayer/MediaPlayer.h>
typedef void(^PrepertyChangeBlock)(AVCaptureDevice *captureDevice);
#define FocusCursorLenth 45
#define ScreenBoundsWidth [UIScreen mainScreen].bounds.size.width
#define ScreenBoundsHeight [UIScreen mainScreen].bounds.size.height
#define MaxTimeOfmp4 10.0
#define ProgressHeight 10
#define ProgressRedrawTimeInterval 1/20.0
//#define ScreenBounds [UIScreen mainScreen].bounds

#define topBtnLength 35
@interface ZHViewController ()<AVCaptureFileOutputRecordingDelegate,UIAlertViewDelegate,ZHTakeMovieViewDelegate>
@property (nonatomic ,strong) AVCaptureSession *captureSession;
@property (nonatomic ,strong) AVCaptureDeviceInput *devInput;
@property (nonatomic ,strong) AVCaptureDeviceInput *devInputAudio;
@property (nonatomic ,strong) AVCaptureStillImageOutput *imageOutput;
@property (nonatomic ,strong) AVCaptureMovieFileOutput *moveFileOut;
@property (nonatomic ,weak) UIView *ContainerView;
@property (nonatomic ,weak) AVCaptureVideoPreviewLayer *preViewLayer;
@property (nonatomic ,weak) UIImageView *focusCursor;
@property (nonatomic ,weak) UIButton *flashBtn;
@property (nonatomic ,weak) UIButton *changeCameraBtn;
@property (nonatomic ,weak) UIButton *closeButton;
@property (nonatomic ,strong) NSURL *outPutFileUrl;
@property (nonatomic ,assign) CGFloat currentTime;
@property (nonatomic ,weak) UIButton *takePhotoBtn;
@property (nonatomic ,weak) ZHProgressView *progressView;

@property (nonatomic ,strong) NSTimer *timer;
@property (nonatomic ,weak) ZHTakeMovieView *takeMovieView;
@property (nonatomic ,weak) UILabel *takeStatusLabel;
@property (nonatomic ,assign) bool isCancelTake;

- (void)changeCameraBtnClicked:(UIButton *)button;
- (void)takePhotoBtnClicked:(UIButton *)button;
- (void)flashBtnClicked:(UIButton *)button;


@end

@implementation ZHViewController
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentTime = 0;
    
    self.view.backgroundColor = [UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:1.0];
	AVCaptureSession *session = [[AVCaptureSession alloc] init];
    if ([session canSetSessionPreset:AVCaptureSessionPreset352x288]) {
        session.sessionPreset = AVCaptureSessionPreset352x288;
    }
    self.captureSession = session;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    

    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    self.devInput = input;
    
    AVCaptureDevice *device1 = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
    
    AVCaptureDeviceInput *input1 = [[AVCaptureDeviceInput alloc] initWithDevice:device1 error:nil];
    self.devInputAudio = input1;
    

    self.moveFileOut = [[AVCaptureMovieFileOutput alloc] init];
    
    if ([session canAddInput:input]) {
        [session addInput:input];
        [session addInput:input1];
    }
    
    if ([session canAddOutput:self.moveFileOut]) {
        [session addOutput:self.moveFileOut];
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenBoundsWidth, ScreenBoundsWidth)];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    self.ContainerView = view;
    
    AVCaptureVideoPreviewLayer *preLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    preLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preViewLayer = preLayer;
    
    CALayer *layer = view.layer;
    layer.masksToBounds = YES;
    preLayer.frame = layer.bounds;
    
    [layer addSublayer:preLayer];
    [self addNotificationToCaptureDevice:device];
    
    
    UIImageView *focusCursor = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FocusCursorLenth, FocusCursorLenth)];
    focusCursor.image = [UIImage imageNamed:@"touch_focus_not.png"];
    focusCursor.alpha = 0;
    [self.ContainerView addSubview:focusCursor];
    self.focusCursor = focusCursor;
    

    CGFloat takePhotoWidth = 70;
    UIButton *takePhotoBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenBoundsWidth-takePhotoWidth)/2, (ScreenBoundsHeight-ScreenBoundsWidth-takePhotoWidth)/2+ScreenBoundsWidth, takePhotoWidth, takePhotoWidth)];
    [takePhotoBtn addTarget:self action:@selector(takePhotoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [takePhotoBtn setBackgroundImage:[UIImage imageNamed:@"video_longvideo_btn_shoot.png"] forState:UIControlStateNormal];
    [takePhotoBtn setBackgroundImage:[UIImage imageNamed:@"video_longvideo_btn_pause.png"] forState:UIControlStateSelected];
    //[self.view addSubview:takePhotoBtn];
    self.takePhotoBtn = takePhotoBtn;
    
    [self addGenstureRecognizer];
//    [self setFlashModeBtnStatus];
    CGFloat padding = 10;
    UIButton *flashBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenBoundsWidth-padding-topBtnLength, 5, topBtnLength, topBtnLength)];
    [flashBtn addTarget:self action:@selector(flashBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [flashBtn setBackgroundImage:[UIImage imageNamed:@"record_flashlight_normal.png"] forState:UIControlStateNormal];
    [flashBtn setBackgroundImage:[UIImage imageNamed:@"record_flashlight_disable.png"] forState:UIControlStateDisabled];
    [flashBtn setBackgroundImage:[UIImage imageNamed:@"record_flashlight_highlighted.png"] forState:UIControlStateSelected];
    [self.view addSubview:flashBtn];
    self.flashBtn = flashBtn;
    
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(padding, 5, topBtnLength, topBtnLength
                                                                  )];
    
    [closeButton setImage:[UIImage imageNamed:@"record_close_normal.png"] forState:UIControlStateNormal];
    [closeButton setImage:[UIImage imageNamed:@"record_close_disable.png"] forState:UIControlStateDisabled];
    [closeButton setImage:[UIImage imageNamed:@"record_close_highlighted.png"] forState:UIControlStateSelected];
    [closeButton setImage:[UIImage imageNamed:@"record_close_highlighted.png"] forState:UIControlStateHighlighted];
    [closeButton addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    closeButton.accessibilityLabel = @"关闭录像";
    [self.view addSubview:closeButton];
    self.closeButton = closeButton;
    
    CGRect frame = flashBtn.frame;
    frame.origin.x = frame.origin.x - padding - topBtnLength;
    UIButton *changeCameraBtn = [[UIButton alloc] initWithFrame:frame];
    [changeCameraBtn addTarget:self action:@selector(changeCameraBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [changeCameraBtn setBackgroundImage:[UIImage imageNamed:@"record_lensflip_normal.png"] forState:UIControlStateNormal];
    [changeCameraBtn setBackgroundImage:[UIImage imageNamed:@"record_lensflip_disable.png"] forState:UIControlStateDisabled];
    [changeCameraBtn setBackgroundImage:[UIImage imageNamed:@"record_lensflip_highlighted.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:changeCameraBtn];
    self.changeCameraBtn = changeCameraBtn;
    
    ZHProgressView *progressView = [[ZHProgressView alloc] initWithFrame:CGRectMake(0, self.ContainerView.frame.size.height, ScreenBoundsWidth, ProgressHeight)];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    ZHTakeMovieView *takeMovieView = [[ZHTakeMovieView alloc] initWithFrame:CGRectMake(0,ScreenBoundsWidth, ScreenBoundsWidth, ScreenBoundsHeight-ScreenBoundsWidth)];
    takeMovieView.delegate = self;
    [self.view addSubview:takeMovieView];
    self.takeMovieView = takeMovieView;
    
    CGFloat takeStatusLabelW = 60;
    CGFloat takeStatusLabelH = 20;
    UILabel *takeStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenBoundsWidth-takeStatusLabelW)/2, ScreenBoundsWidth-takeStatusLabelH, takeStatusLabelW, takeStatusLabelH)];
    takeStatusLabel.hidden = YES;
    takeStatusLabel.backgroundColor = [UIColor clearColor];
    takeStatusLabel.font = [UIFont systemFontOfSize:14];
    [self.view insertSubview:takeStatusLabel aboveSubview:self.ContainerView];
    self.takeStatusLabel = takeStatusLabel;
}
#pragma mark -view周期方法
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.captureSession startRunning];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self.captureSession stopRunning];
}
#pragma mark -通知:捕获区域改变
- (void)addNotificationToCaptureDevice:(AVCaptureDevice *)captureDevice
{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        captureDevice.subjectAreaChangeMonitoringEnabled = YES;
    }];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(areaChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}

- (void)removeNotificationFromCaptureDevice:(AVCaptureDevice *)captureDevice
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}
- (void)removeAllNoticification
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}
- (void)areaChange:(NSNotification *)not
{
    //NSLog(@"捕获区域改变！！！");
}
#pragma mark -添加手势,监听点击聚焦和设定白平衡
- (void)addGenstureRecognizer
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.ContainerView addGestureRecognizer:tap];
}
- (void)tap:(UITapGestureRecognizer *)tap
{    CGPoint point = [tap locationInView:self.ContainerView];
    CGPoint camera = [self.preViewLayer captureDevicePointOfInterestForPoint:point];
    [self setFocusCursorWithPoint:point];
    NSLog(@"%f-%f-%f-%f",point.x,point.y,camera.x,camera.y);
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:camera];
}

- (void)setFocusCursorWithPoint:(CGPoint)point
{
    self.focusCursor.alpha = 1.0;
    self.focusCursor.center = point;
    self.focusCursor.transform = CGAffineTransformMakeScale(1.5, 1.5);
    [UIView animateWithDuration:1.0 animations:^{
        self.focusCursor.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.focusCursor.alpha = 0;
    }];
    
}
- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)expotureMode atPoint:(CGPoint)Point
{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFocusModeSupported:focusMode]) {
            captureDevice.focusMode = focusMode;
        }
        if ([captureDevice isFocusPointOfInterestSupported]) {
            captureDevice.focusPointOfInterest = Point;
        }
        
        if ([captureDevice isExposureModeSupported:expotureMode]) {
            captureDevice.exposureMode = expotureMode;
        }
        if ([captureDevice isExposurePointOfInterestSupported]) {
            captureDevice.exposurePointOfInterest = Point;
        }
    }];
}

#pragma mark -拍照
- (void)takePhotoBtnClicked:(UIButton *)button
{

    button.selected = ![self.moveFileOut isRecording];
    if ([self.moveFileOut isRecording]) {
        [self.moveFileOut stopRecording];
        [self.timer invalidate];
        self.timer = nil;
    }else{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
        
        NSString *path = [NSTemporaryDirectory() stringByAppendingString:[NSString stringWithFormat:@"%@.mp4",nowTimeStr]];
        NSURL *url = [NSURL fileURLWithPath:path];
        NSLog(@"%@",path);
        
        [self.moveFileOut startRecordingToOutputFileURL:url recordingDelegate:self];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ProgressRedrawTimeInterval target:self selector:@selector(redrawProgressView) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];  
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self bestTimeArrive];
        });
    }
}

- (void)closeBtnClicked:(UIButton *)button
{
    [self.moveFileOut stopRecording];
    [self.timer invalidate];
    self.timer = nil;
    [self dismissViewControllerAnimated:YES completion:^{
       
    }];
}
- (void)bestTimeArrive
{
    
    NSLog(@"bestTimeArrive");
    if ([self.moveFileOut isRecording]) {
        [self.moveFileOut stopRecording];
        NSLog(@"时间到了");
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)redrawProgressView
{
    static int a = 0;
    a++;
    self.currentTime += ProgressRedrawTimeInterval;
    //NSLog(@"%f----%d",self.currentTime,a);
    self.progressView.currentTime = self.currentTime;
    [self.progressView setNeedsDisplay];
    
}
- (void)reSetProgressView
{
    self.currentTime = 0;
    self.progressView.viewColor = ZHProgressViewGreen;
    self.progressView.currentTime = self.currentTime;
    [self.progressView setNeedsDisplay];
}
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections
{
    NSLog(@"录制开始");
}
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    [self reSetProgressView];
    if (self.isCancelTake){
        self.isCancelTake = NO;
        return;
    };
    if (error) {
        NSLog(@"录制错误");
    }else{
        NSLog(@"录制完成");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"选项" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存",@"播放",nil];
        [alert show];
        self.outPutFileUrl = outputFileURL;
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        ALAssetsLibrary *ala = [[ALAssetsLibrary alloc] init];
        [ala writeVideoAtPathToSavedPhotosAlbum:self.outPutFileUrl completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error) {
                NSLog(@"视频保存到相册失败");
            }else{
                NSLog(@"视频保存到相册成功");
            }
        }];
    }else{
        MPMoviePlayerViewController *controller = [[MPMoviePlayerViewController alloc] initWithContentURL:self.outPutFileUrl];
        [self presentMoviePlayerViewControllerAnimated:controller];
    }
}
- (void)changeDeviceProperty:(PrepertyChangeBlock)proertyChange
{
    AVCaptureDevice *device = self.devInput.device;
    
    if ([device lockForConfiguration:nil]) {
        proertyChange(device);
        [device unlockForConfiguration];
    }
    
}
- (void)flashBtnClicked:(UIButton *)button
{
    AVCaptureDevice *dev = self.devInput.device;
    button.selected = !dev.torchMode;
    if (dev.torchMode) {
        [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
            if ([captureDevice isFlashAvailable]) {
                captureDevice.torchMode = AVCaptureTorchModeOff;
            }else{
                NSLog(@"闪光灯不可用");
            }
        }];
    }else{
        [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
            if ([captureDevice isFlashAvailable]) {
                captureDevice.torchMode = AVCaptureTorchModeOn;
            }else{
                NSLog(@"闪光灯不可用");
            }
        }];
    }
}
- (void)changeCameraBtnClicked:(UIButton *)button
{
    AVCaptureDevice *device = self.devInput.device;
    AVCaptureDevicePosition position = device.position;
    NSArray *deves = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
//    NSLog(@"%d",position);
    if (position == AVCaptureDevicePositionBack) {
        self.flashBtn.enabled = NO;
        for (AVCaptureDevice *dev in deves) {
        if (dev.position == AVCaptureDevicePositionFront) {
            [self.captureSession beginConfiguration];
            [self.captureSession removeInput:self.devInput];
            self.devInput = [[AVCaptureDeviceInput alloc] initWithDevice:dev error:nil];
            if ([self.captureSession canAddInput:self.devInput]) {
                [self.captureSession addInput:self.devInput];
            }
            [self.captureSession commitConfiguration];
        }
        }
    }else{
        self.flashBtn.enabled = YES;
        self.flashBtn.selected = NO;
        for (AVCaptureDevice *dev in deves) {
        if (dev.position == AVCaptureDevicePositionBack) {
            [self.captureSession beginConfiguration];
            [self.captureSession removeInput:self.devInput];
            self.devInput = [[AVCaptureDeviceInput alloc] initWithDevice:dev error:nil];
            if ([self.captureSession canAddInput:self.devInput]) {
                [self.captureSession addInput:self.devInput];
            }
            [self.captureSession commitConfiguration];
        }
        }
    }
    //NSLog(@"%d",self.devInput.device.position);
}
#pragma mark -ZHTakeMovieView代理
- (void)takeMovieViewbeginTake:(ZHTakeMovieView *)takeMovieView
{
    NSLog(@"begin");
    self.takeStatusLabel.hidden = NO;
    self.takeStatusLabel.text = @"上移取消";
    self.takeStatusLabel.textColor = [UIColor greenColor];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    NSString *path = [NSTemporaryDirectory() stringByAppendingString:[NSString stringWithFormat:@"%@.mp4",nowTimeStr]];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSLog(@"%@",path);
    
    [self.moveFileOut startRecordingToOutputFileURL:url recordingDelegate:self];
//            [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(bestTimeArrive) userInfo:nil repeats:NO];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(9.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self bestTimeArrive];
//    });
    [self performSelector:@selector(bestTimeArrive) withObject:self afterDelay:10.0];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:ProgressRedrawTimeInterval target:self selector:@selector(redrawProgressView) userInfo:nil repeats:YES];
//    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(redrawProgressView)];
//    self.link.frameInterval = 1.0/50;
//    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}
- (void)takeMovieViewWillCancelTake:(ZHTakeMovieView *)takeMovieView
{
    NSLog(@"WillCancel");
    self.takeStatusLabel.text = @"松手取消";
    self.takeStatusLabel.textColor = [UIColor redColor];
    self.progressView.viewColor = ZHProgressViewRed;
    self.isCancelTake = YES;
}
- (void)takeMovieViewContinueTake:(ZHTakeMovieView *)takeMovieView
{
    NSLog(@"Continue");
    self.takeStatusLabel.text = @"上移取消";
    self.progressView.viewColor = ZHProgressViewGreen;
    self.takeStatusLabel.textColor = [UIColor greenColor];
    self.isCancelTake = NO;
}
- (void)takeMovieViewCancelTake:(ZHTakeMovieView *)takeMovieView
{
#warning 延迟函数不用需要停止，否则会出问题（下一次开始会在这次的时间基础上叠加）
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    NSLog(@"Cancel");
    self.takeStatusLabel.hidden = YES;
    NSLog(@"时间没到");
    [self.moveFileOut stopRecording];
#warning 定时器不用需要停止
    [self.timer invalidate];
    self.timer = nil;
    
}

@end
