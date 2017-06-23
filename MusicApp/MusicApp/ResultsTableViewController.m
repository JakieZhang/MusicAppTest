//
//  ResultsTableViewController.m
//  MusicApp
//
//  Created by idaoben idaoben on 2017/6/19.
//  Copyright © 2017年 idaoben. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "SongsListCell.h"
#import "PlayingView.h"
#import "ViewUtils.h"
#import "BangDanDetailModel.h"
@interface ResultsTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic)  UIView *naviView;
@property (strong, nonatomic)  UITableView *tableViewNew;
@property (nonatomic, strong)NSArray *songs;
@end

@implementation ResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.name;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    [self.tableView bringSubviewToFront:self.tableView.subviews[0]];
    [self.tableView registerNib:[UINib nibWithNibName:@"SongsListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [NetWorking getObjFromNetWorkWithPagram:nil andURL:[NSString stringWithFormat:kBangdanURL ,self.name] andCompletion:^(id obj) {
         NSArray *songs = [BangDanDetailModel arrayOfModelsFromDictionaries:obj[@"song_list"] error:nil];
        self.songs = songs;
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.songs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    BangDanDetailModel *model = self.songs[indexPath.row];
    cell.bdm = model;
    
    return cell;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return [[[NSBundle mainBundle]loadNibNamed:@"BangdanDetailSectionView" owner:self options:0]firstObject];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [PlayingView shareView].songs = self.songs;
    [[PlayingView shareView].songListTableView reloadData];
    [PlayingView shareView].currentIndex = indexPath.row;
    [[PlayingView shareView]show];
    [PlayingView shareView].song = self.songs[indexPath.row];
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
