//
//  ZLAdvertView.m
//  CordovaCard
//
//  Created by tdr on 2018/11/2.
//  Copyright © 2018年 vvho. All rights reserved.
//

#import "ZLAdvertView.h"
@interface ZLAdvertView ()



@end

// 广告显示的时间
static int const showtime = 3;

@implementation ZLAdvertView

- (NSTimer *)timer {
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _starimg = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_starimg];
        _starimg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPage)];
        [_starimg addGestureRecognizer:tapGesturRecognizer];
        _starimg.backgroundColor = [UIColor redColor];
        _starimg.contentMode = UIViewContentModeScaleAspectFill;
        _starimg.image = [UIImage imageNamed:(UIScreen.mainScreen.bounds.size.height == 812) ? @"LOGO" : @"LOGO"];
        
        
        _tiaoguobtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tiaoguobtn.frame = CGRectMake(kScreenWidth-60-20, 30, 60, 30);
        //    tiaoguobtn.layer.borderWidth = .5;
        //    tiaoguobtn.layer.borderColor = [UIColor colorWithHex:0xffffff alpha:1].CGColor;
//        _tiaoguobtn.backgroundColor = [UIColor colorWithHex:0x000000 alpha:.6];
        _tiaoguobtn.alpha = .5;
        _tiaoguobtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        [_tiaoguobtn setTintColor:[UIColor whiteColor]];
        [_starimg addSubview:_tiaoguobtn];
//        [_tiaoguobtn setTitle:[NSString stringWithFormat:@"跳过3"] forState:UIControlStateNormal];
        [_tiaoguobtn addTarget:self action:@selector(removeAdvertView) forControlEvents:UIControlEventTouchUpInside];
        _tiaoguobtn.layer.masksToBounds = YES;
        _tiaoguobtn.layer.cornerRadius = 15;
        
    }
    return self;
}


//点击启动图按钮
-(void)tapPage
{
    [self removeAdvertView];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZLPushToAdvert" object:nil userInfo:nil];
    
}



- (void)countDown {
    
    _time --;
    _tiaoguobtn.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.6];
    [_tiaoguobtn setTitle:[NSString stringWithFormat:@"跳过%d",_time] forState:UIControlStateNormal];
    if (_time == 0) {
        
        [self removeAdvertView];
    }
}

// 广告页面的跳过按钮倒计时功能可以通过定时器或者GCD实现
- (void)showtimer {
    
    // 倒计时方法1：GCD
    [self startCoundown];
    
    // 倒计时方法2：定时器
//    [self startTimer];
}

// 定时器倒计时
- (void)startTimer {
    
    _time = showtime;
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// GCD倒计时
- (void)startCoundown {
    
    __weak __typeof(self) weakSelf = self;
    __block int timeout = showtime + 1; //倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf removeAdvertView];
                
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tiaoguobtn.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.6];
                [self->_tiaoguobtn setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

// 移除广告页面
- (void)removeAdvertView {
    
    // 停掉定时器
    [self.timer invalidate];
    _timer = nil;

    
    [UIView animateWithDuration:0.3f animations:^{

        self.alpha = 0.f;

    } completion:^(BOOL finished) {

        [self removeFromSuperview];

    }];
    
}



@end
