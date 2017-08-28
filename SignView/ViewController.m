//
//  ViewController.m
//  SignView
//
//  Created by 杨志强 on 2017/8/28.
//  Copyright © 2017年 sheep. All rights reserved.
//

#import "ViewController.h"
#import "SignView.h"
#import "Masonry.h"
@interface ViewController ()
@property (nonatomic, strong) SignView *signview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签名";
    self.signview = [[SignView alloc] init];
    self.signview.lineWidth = 5;
    self.signview.signColor = [UIColor blueColor];
    [self.view addSubview:self.signview];
    [self.signview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(complete)];
    
}

- (void)complete {
    NSData *imageData = [self.signview generatePNGSignData];
    NSString* docDir = [NSString stringWithFormat:@"%@/Documents/Image", NSHomeDirectory()];
    [[NSFileManager defaultManager] createDirectoryAtPath:docDir withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *path = [NSString stringWithFormat:@"%@/Documents/Image/IMAGE.PNG", NSHomeDirectory()];
    [imageData writeToFile:path atomically:YES];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
