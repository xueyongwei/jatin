//
//  MBProgressHUD+Utility.m
//  115
//
//  Created by Cyril Hu on 14-6-7.
//  Copyright (c) 2014年 115. All rights reserved.
//

#import "MBProgressHUD+Utility.h"
#import "MBProgressHUD.h"
//#import "UDLoadingView.h"

UIImage* kMBProgressHUDImageSuccess = nil;
UIImage* kMBProgressHUDImageFail = nil;
UIImage* kMBProgressHUDImageWarning = nil;

@interface MBProgressHUD (UtilityPrivateHack)
- (void)setTransformForCurrentOrientation:(BOOL)animated;
@end

@implementation MBProgressHUD (Utility)

+ (void)initialize {
  kMBProgressHUDImageSuccess = [UIImage imageNamed:@"hud_success"];  // √
  kMBProgressHUDImageFail = [UIImage imageNamed:@"hud_fail"];        // X
  kMBProgressHUDImageWarning = [UIImage imageNamed:@"hud_warning"];  // !
}

+ (instancetype)sharedHUD {
  static MBProgressHUD* sharedHUD = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedHUD = [[MBProgressHUD alloc]
        initWithWindow:[UIApplication sharedApplication].windows[0]];
    sharedHUD.removeFromSuperViewOnHide = YES;
    sharedHUD.detailsLabelFont = [UIFont boldSystemFontOfSize:16.0];

    //        __weak MBProgressHUD *weakSelf = sharedHUD;
    //        [[NSNotificationCenter defaultCenter]
    //        addObserverForName:UIKeyboardWillShowNotification object:nil
    //        queue:nil usingBlock:^(NSNotification *note) {
    //            weakSelf.yOffset = -108;
    //            [weakSelf setNeedsLayout];
    //            [weakSelf setNeedsDisplay];
    //        }];
    //        [[NSNotificationCenter defaultCenter]
    //        addObserverForName:UIKeyboardWillHideNotification object:nil
    //        queue:nil usingBlock:^(NSNotification *note) {
    //            weakSelf.yOffset = 0;
    //            [weakSelf setNeedsLayout];
    //            [weakSelf setNeedsDisplay];
    //        }];
  });
  return sharedHUD;
}

+ (void)showMode:(MBProgressHUDMode)mode
            text:(NSString*)text
           title:(NSString*)title
           delay:(NSTimeInterval)delay {
  MBProgressHUD* HUD = [self sharedHUD];
  HUD.detailsLabelText = text;
  HUD.labelText = title;
  HUD.mode = mode;
  HUD.animationType = MBProgressHUDAnimationFade;
  HUD.userInteractionEnabled =
      (delay <
       0);  // 显示临时提示界面时不屏蔽点击事件，如果文字和图片类型的提示
  // HUD.yOffset = -[UIScreen mainScreen].bounds.size.height / 5.0;

  //    if (floor(NSFoundationVersionNumber) <=
  //    NSFoundationVersionNumber_iOS_7_1) {
  //        [HUD setTransformForCurrentOrientation:NO];
  //    }
  dispatch_async(dispatch_get_main_queue(), ^{
    [HUD show:(HUD.superview == nil)];  // 如果已经显示在界面上，就不用动画
    [[UIApplication sharedApplication].windows[0] addSubview:HUD];
    [NSObject cancelPreviousPerformRequestsWithTarget:HUD];  //取消上一次的隐藏
    if (delay > 0) {
      [HUD hide:YES afterDelay:delay];
    }
  });
}

#pragma mark -
+ (void)showText:(NSString*)text {
  [self showText:text title:nil];
}

+ (void)showText:(NSString*)text title:(NSString*)title {
  [[self sharedHUD] setMinSize:CGSizeZero];
  [self showMode:MBProgressHUDModeText text:text title:title delay:1.5];
}

#pragma mark -
+ (void)showLoading:(NSString*)text {
  [self showLoading:text title:nil];
}

+ (void)showLoading:(NSString*)text title:(NSString*)title {
//      UDLoadingView *loadingView = [[UDLoadingView alloc] initWithFrame:CGRectMake(0, 0, 58.0, 58.0) isMBProgressHUD:YES];
//      [[self sharedHUD] setCustomView:loadingView];
////      [[self sharedHUD] setMinSize:CGSizeMake(165.0, 165.0)];
//      [self showMode:MBProgressHUDModeCustomView text:text title:title
//      delay:-1];
}

#pragma mark -
+ (void)showProgress:(NSString*)text {
  [self showProgress:text title:nil];
}

+ (void)showProgress:(NSString*)text title:(NSString*)title {
  [[self sharedHUD] setMinSize:CGSizeMake(165.0, 165.0)];
  [self showMode:MBProgressHUDModeDeterminate text:text title:title delay:-1];
}

+ (void)updateProgress:(float)progress {
  [[self sharedHUD] setProgress:progress];
}

#pragma mark -
+ (void)showSuccessImage:(NSString*)text {
  [self showImage:kMBProgressHUDImageSuccess text:text title:nil];
}

+ (void)showFailImage:(NSString*)text {
  [self showImage:kMBProgressHUDImageFail text:text title:nil];
}

+ (void)showWarningImage:(NSString*)text {
  [self showImage:kMBProgressHUDImageWarning text:text title:nil];
}

+ (void)showWarningImageOnWindow:(NSString*)text {
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:1];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:hud];
    [hud showImage:kMBProgressHUDImageWarning text:text title:nil];
}

+ (void)showImage:(UIImage*)image text:(NSString*)text {
  [self showImage:image text:text title:nil];
}

+ (void)showImage:(UIImage*)image text:(NSString*)text title:(NSString*)title {
  UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  [[self sharedHUD] setCustomView:imageView];
  //[[self sharedHUD] setMinSize:CGSizeMake(165.0, 165.0)];
  [self showMode:MBProgressHUDModeCustomView text:text title:title delay:1.0];
}

- (void)showImage:(UIImage*)image text:(NSString*)text title:(NSString*)title {
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self  setCustomView:imageView];
    self.removeFromSuperViewOnHide = YES;
    self.detailsLabelFont = [UIFont boldSystemFontOfSize:16.0];
    self.detailsLabelText = text;
    self.mode = MBProgressHUDModeCustomView;
    self.animationType = MBProgressHUDAnimationFade;
    [self show:YES];
    [self hide:YES afterDelay:2.0];
}


+ (void)showGIFView:(UIImageView*)imageView text:(NSString*)text {
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  [[self sharedHUD] setCustomView:imageView];
//  [[self sharedHUD] setMinSize:CGSizeMake(165.0, 165.0)];
  [self showMode:MBProgressHUDModeCustomView text:text title:nil delay:-1];
}

- (void)showGIFView:(UIImageView *)imageView text:(NSString *)text {
//    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    self.removeFromSuperViewOnHide = YES;
    self.detailsLabelFont = [UIFont boldSystemFontOfSize:16.0];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self setCustomView:imageView];
    self.detailsLabelText = text;
    self.mode = MBProgressHUDModeCustomView;
    self.animationType = MBProgressHUDAnimationFade;
}

#pragma mark -
+ (void)hide {
  [[self sharedHUD] hide:YES
              afterDelay:0.0];  // 用 afterDelay 的方法可以让 hide
  // 事件取消，参考 `showMode:text:title:delay:`
}

+ (void)hideAfterDelay:(NSTimeInterval)delay {
  [[self sharedHUD] hide:YES afterDelay:delay];
}

@end
