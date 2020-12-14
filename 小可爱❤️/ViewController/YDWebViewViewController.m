//
//  YDWebViewViewController.m
//  小可爱❤️
//
//  Created by Farben on 2020/5/4.
//  Copyright © 2020 Farben. All rights reserved.
//

#import "YDWebViewViewController.h"
#import <WebKit/WebKit.h>
#import "Header.h"
#import "webViewSlidView.h"
#import "UIView+Events.h"


#define OFFSET_X 320.f

@interface YDWebViewViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic) WKWebView *webView;
@property (nonatomic) UIProgressView *progressView;
@property (nonatomic) UIView *searchView;
@property (nonatomic,strong) webViewSlidView *webSlidView;
@property (nonatomic, strong) UIButton *openSlidButton;

@end

@implementation YDWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯详情";
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    [self createwebSlideView];
}


-(void)createwebSlideView{
    
    
    self.webSlidView = [[webViewSlidView alloc]contentView];
    self.webSlidView.frame = CGRectMake(-OFFSET_X, 0, OFFSET_X, ScreenHeight);
    [self.view addSubview:self.webSlidView];
    
    WEAKSELF;
    [self.webSlidView.closeButton addClickEventBlock:^(id obj) {
        [weakSelf closeSlideView];
    }];
    
    [self.webSlidView.lastPage addClickEventBlock:^(id obj) {
        [self.webView goBack];
    }];
    
    [self.webSlidView.exitPage addClickEventBlock:^(id obj) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    self.openSlidButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.openSlidButton.frame = CGRectMake(ScreenWidth - 50, ScreenHeight - 90, 30, 30);
//    self.openSlidButton.backgroundColor = UIColor.blackColor;
    [self.openSlidButton setImage:[UIImage imageNamed:@"控制按钮"] forState:UIControlStateNormal];
    [self.openSlidButton addTarget:self action:@selector(openSlide) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.openSlidButton];
    
}

-(void)closeSlideView{
    [UIView animateWithDuration:0.3 animations:^{
        self.webSlidView.frame = CGRectMake(-OFFSET_X, 0, OFFSET_X, ScreenHeight);
    }];
}

-(void)openSlide{
    [UIView animateWithDuration:0.5 animations:^{
        self.webSlidView.frame = CGRectMake(0, 0, OFFSET_X, ScreenHeight);
    }];
}


#pragma mark - Getter
- (UIProgressView *)progressView {
    if (!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0 , ScreenWidth, 2)];
        _progressView.tintColor = [UIColor orangeColor];
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}
- (WKWebView *)webView{
    if (_webView == nil) {
        //创建网页配置对象
        //以下代码适配大小
        //以下代码适配大小
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        
        WKWebViewConfiguration *webConfig = [[WKWebViewConfiguration alloc] init];
        webConfig.userContentController = wkUController;
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webConfig];
       // UI代理
       _webView.UIDelegate = self;
       // 导航代理
       _webView.navigationDelegate = self;
       // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
       _webView.allowsBackForwardNavigationGestures = YES;

//        NSString *path = [[NSBundle mainBundle] pathForResource:@"messageDetail" ofType:@"pdf"];
//        NSURL *pathURL = [NSURL fileURLWithPath:path];
//        [_webView loadRequest:[NSURLRequest requestWithURL:pathURL]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
        //http://tieba.baidu.com/wxf/25431955?kw=%E6%AF%94%E5%BF%83app&fr=frsshare
        //http://i.meituan.com/
        //https://tieba.baidu.com/f?ie=utf-8&kw=比心APP&fr=search
       [_webView loadRequest:request];
       //添加监测网页加载进度的观察者
       [_webView addObserver:self
                          forKeyPath:@"estimatedProgress"
                             options:0
                             context:nil];
        
        [_webView.scrollView addClickEventBlock:^(id obj) {
            NSLog(@"webViewCLick");
        }];
        
        
        
    }
    return _webView;

}
   //kvo 监听进度 必须实现此方法
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == _webView) {
       NSLog(@"网页加载进度 = %f",_webView.estimatedProgress);
        self.progressView.progress = _webView.estimatedProgress;
        if (_webView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.progress = 0;
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    _searchView.hidden = NO;

}
- (void)dealloc{
   
    //移除观察者
    [_webView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

#pragma mark - WKNavigationDelegate

// 开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"didStartProvisionalNavigation   ====    %@", navigation);
}

// 页面加载完调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"didFinishNavigation   ====    %@", navigation);
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
////        [self.webView.scrollView addSubview:self.addView];
//
////        if (useEdgeInset) {
////            // url 使用 test.html 对比更明显
////            self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, addViewHeight, 0);
////        } else {
////            NSString *js = [NSString stringWithFormat:@"\
////                            var appendDiv = document.getElementById(\"AppAppendDIV\");\
////                            if (appendDiv) {\
////                            appendDiv.style.height = %@+\"px\";\
////                            } else {\
////                            var appendDiv = document.createElement(\"div\");\
////                            appendDiv.setAttribute(\"id\",\"AppAppendDIV\");\
////                            appendDiv.style.width=%@+\"px\";\
////                            appendDiv.style.height=%@+\"px\";\
////                            document.body.appendChild(appendDiv);\
////                            }\
////////                            ", @(addViewHeight), @(ScreenWidth), @(addViewHeight)];
////            [self.webView evaluateJavaScript:js completionHandler:^(id value, NSError *error) {
////                // 执行完上面的那段 JS, webView.scrollView.contentSize.height 的高度已经是加上 div 的高度
////                self.addView.frame = CGRectMake(0, self.webView.scrollView.contentSize.height - addViewHeight, ScreenWidth, addViewHeight);
////            }];
//        }
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailProvisionalNavigation   ====    %@\nerror   ====   %@", navigation, error);
}

// 内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"didCommitNavigation   ====    %@", navigation);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    [self closeSlideView];
    
    
    NSLog(@"decidePolicyForNavigationAction   ====    %@", navigationAction);
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"decidePolicyForNavigationResponse   ====    %@", navigationResponse);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 加载 HTTPS 的链接，需要权限认证时调用  \  如果 HTTPS 是用的证书在信任列表中这不要此代理方法
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}

#pragma mark - WKUIDelegate

// 提示框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示框" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认框" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入框" message:prompt preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor blackColor];
        textField.placeholder = defaultText;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(nil);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.webView evaluateJavaScript:@"parseFloat(document.getElementById(\"AppAppendDIV\").style.width);" completionHandler:^(id value, NSError * _Nullable error) {
        NSLog(@"======= %@", value);
    }];
}
@end

