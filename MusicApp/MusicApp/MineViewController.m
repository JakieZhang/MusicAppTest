//
//  MineViewController.m
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/17.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "SearchTableViewController.h"
#define kSongsPath [NSHomeDirectory() stringByAppendingString:@"/Documents/songs.arch"]
@interface MineViewController ()

@property (strong, nonatomic) IBOutlet UITableViewCell *localCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *recentPlayCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *redomListionCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *ziijanSongListCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *likeCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *shoucangCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *loginCell;
@property (nonatomic,strong)MineHeaderView *mv;
@property (nonatomic,strong)NSMutableArray *songs;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mv = [[[NSBundle mainBundle]loadNibNamed:@"MineHeaderView" owner:self options:0]firstObject];
    [self.mv.SearchHeader addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = self.mv;
    //这句话不懂
    [self.tableView bringSubviewToFront:self.tableView.subviews[0]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(searchAction:)];
    self.tableView.tableFooterView = [UIView new];
}

-(void)searchAction:sender{
    SearchTableViewController *vc = [[SearchTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.songs = [NSKeyedUnarchiver unarchiveObjectWithFile:kSongsPath];
    UILabel *countLabel = self.localCell.contentView.subviews[2];
    countLabel.text = [NSString stringWithFormat:@"共%ld首试试",(unsigned long)self.songs.count];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return self.localCell;
    }else if (indexPath.row == 1){
        return self.recentPlayCell;
    }else if (indexPath.row == 2){
        return self.redomListionCell;
    }else if (indexPath.row == 3){
        return self.ziijanSongListCell;
    }else if (indexPath.row == 4){
        return self.likeCell;
    }else if (indexPath.row == 5){
        return self.shoucangCell;
    }else if (indexPath.row == 6){
        return self.loginCell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (indexPath.row == 3 || indexPath.row == 5){
        return 40;
    }
    return 60;
}



@end
