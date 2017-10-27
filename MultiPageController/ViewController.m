//
//  ViewController.m
//  MultiPageController
//
//  Created by Piao Piao on 2017/10/26.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import "ViewController.h"
#import "MultiPageViewController.h"

@interface TestController :UIViewController
@end

@implementation TestController
- (void)viewDidLoad
{
    [super viewDidLoad];
}
@end

@interface TestController2 :UIViewController
@end

@implementation TestController2
- (void)viewDidLoad
{
    [super viewDidLoad];
}
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(id)sender {
    TestController* vc1 = [TestController new];
    vc1.view.backgroundColor = [UIColor redColor];
    UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label1.text = @"1";
    [vc1.view addSubview:label1];
    TestController2* vc2 = [TestController2 new];
    vc2.view.backgroundColor = [UIColor greenColor];
    UILabel* label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label2.text = @"2";
    [vc2.view addSubview:label2];
    TestController* vc3 = [TestController new];
    vc3.view.backgroundColor = [UIColor redColor];
    UILabel* label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label3.text = @"3";
    [vc3.view addSubview:label3];
    TestController2* vc4 = [TestController2 new];
    vc4.view.backgroundColor = [UIColor greenColor];
    UILabel* label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label4.text = @"4";
    [vc4.view addSubview:label4];
    
    
    TestController* vc5 = [TestController new];
    vc5.view.backgroundColor = [UIColor redColor];
    UILabel* label5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label5.text = @"5";
    [vc5.view addSubview:label5];
    TestController2* vc6 = [TestController2 new];
    vc6.view.backgroundColor = [UIColor greenColor];
    UILabel* label6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label6.text = @"6";
    [vc6.view addSubview:label6];
    
    TestController* vc7 = [TestController new];
    vc7.view.backgroundColor = [UIColor redColor];
    UILabel* label7 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label7.text = @"7";
    [vc7.view addSubview:label7];
    TestController2* vc8 = [TestController2 new];
    vc8.view.backgroundColor = [UIColor greenColor];
    UILabel* label8 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label8.text = @"8";
    [vc8.view addSubview:label8];
    
    TestController* vc9 = [TestController new];
    vc9.view.backgroundColor = [UIColor redColor];
    
    UILabel* label9 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label9.text = @"9";
    [vc9.view addSubview:label9];
    TestController2* vc10 = [TestController2 new];
    vc10.view.backgroundColor = [UIColor greenColor];
    UILabel* label10 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label10.text = @"10";
    [vc10.view addSubview:label10];
    
    MultiPageViewController* pageCtrl = [[MultiPageViewController alloc] initWithAllControllers:@[vc1,vc2,vc3,vc4,vc5,vc6,vc7,vc8,vc9,vc10] AndTypes:@[@"vc1",@"vc2",@"vc3",@"vc4",@"vc5",@"vc6",@"vc7",@"vc8",@"vc9",@"vc10"]];
    [self.navigationController pushViewController:pageCtrl animated:YES];
    


}

@end
