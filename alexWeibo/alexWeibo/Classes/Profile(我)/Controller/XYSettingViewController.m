//
//  XYSettingViewController.m
//  
//
//  Created by xiayao on 16/2/29.
//
//

#import "XYSettingViewController.h"
#import "XYProfileViewController.h"
@interface XYSettingViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation XYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popToProfile)];
    left.title = @"我";
    self.navigationItem.leftBarButtonItem = left;
    
    self.navigationItem.title = @"设置";
}

- (void)popToProfile
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 1;
        }
        case 1:
        {
            return 3;
        }
        case 2:
        {
            return 3;
        }
        case 3:
        {
            return 1;
        }
            break;
            
        default:
            break;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *id = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id];
        if (indexPath.section == 3) {
            NSMutableDictionary *attr = [NSMutableDictionary dictionary];
            attr[NSForegroundColorAttributeName] = [UIColor redColor];
            [cell.detailTextLabel setValue:attr forKey:nil];
        }
    }
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
