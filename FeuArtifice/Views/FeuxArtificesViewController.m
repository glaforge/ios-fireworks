//
//  FeuxArtificesViewController.m
//  FeuArtifice
//
//  Created by Patrice Trognon on 11/07/2015.
//  Copyright (c) 2015 Patrice Trognon. All rights reserved.
//

#import "FeuxArtificesViewController.h"
#import "AppDelegate.h"

#import "LoadFeuxArticicesWSOperation.h"

#import "Departement+Extensions.h"
#import "FeuArtifice+Extensions.h"

#import "DepartementHeaderView.h"
#import "FeuArtificeTableViewCell.h"

#import "FeuArtificeDetailsViewController.h"

#import "UIButtonDepartement.h"

@interface FeuxArtificesViewController () <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak)   IBOutlet        UITableView                 *       tableViewFeux;

@property(nonatomic,strong)                 NSArray                     *       arrayOfDepartements;

@property(nonatomic,strong)                 UIAlertView                 *       alertViewRefresh;

@property(nonatomic,strong)                 NSMutableDictionary         *       dictOfHeaderViewByDepartement;
@property(nonatomic,strong)                 NSMutableDictionary         *       dictOfDepartementsByNumero;

-(IBAction)actionRefresh:(id)sender;
-(IBAction)actionDepartementHeader:(id)sender;

@end

@implementation FeuxArtificesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dictOfHeaderViewByDepartement = [NSMutableDictionary dictionary];
    self.dictOfDepartementsByNumero = [NSMutableDictionary dictionary];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceivedFeuxLoaded:)
                                                 name:kFeuxContentLoaded object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceivedFeuxFailed:)
                                                 name:kFeuxContentFailed object:nil];

    
    [self loadDepartementsFromLocalDatabase];
    
    if ( self.arrayOfDepartements == nil || self.arrayOfDepartements.count == 0 ) {
        [self callRefreshFeuxArtifices];
    }
}

-(void)loadDepartementsFromLocalDatabase {
    self.arrayOfDepartements = [Departement getAllDepartements];
    for(Departement *departement in self.arrayOfDepartements) {
        [self.dictOfDepartementsByNumero setObject:departement forKey:departement.numero];
        
        /*
        NSLog(@"%@",departement);
        for(FeuArtifice *feu in [departement.feux allObjects]) {
            NSLog(@"    %@",feu);
        }
         */
    }
}

#pragma mark -
#pragma mark Actions
-(IBAction)actionRefresh:(id)sender {
    [self callRefreshFeuxArtifices];
}

-(IBAction)actionDepartementHeader:(id)sender {
    UIButtonDepartement *btn = (UIButtonDepartement*)sender ;
    NSString *numeroDepartement = btn.numeroDepartement;
    
    DepartementHeaderView *headerView = [self.dictOfHeaderViewByDepartement objectForKey:numeroDepartement];
    Departement *departement = [self.dictOfDepartementsByNumero objectForKey:numeroDepartement];
    
    if ( headerView.isExpanded == NO ) {
        headerView.isExpanded = YES ;
        NSArray *arrayOfFeux = [departement.feux allObjects];
        
        NSMutableArray *ma = [NSMutableArray array];
        
        for(int row=0; row<arrayOfFeux.count; row++) {
            [ma addObject:[NSIndexPath indexPathForRow:row inSection:headerView.section]];
        }
        [self.tableViewFeux insertRowsAtIndexPaths:ma withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } else {
        headerView.isExpanded = NO ;
        NSArray *arrayOfFeux = [departement.feux allObjects];
        
        NSMutableArray *ma = [NSMutableArray array];
        
        for(int row=0; row<arrayOfFeux.count; row++) {
            [ma addObject:[NSIndexPath indexPathForRow:row inSection:headerView.section]];
        }
        [self.tableViewFeux deleteRowsAtIndexPaths:ma withRowAnimation:UITableViewRowAnimationAutomatic];
  
    }
}

#pragma mark -
#pragma mark Call WebService
-(void)callRefreshFeuxArtifices {
    NSString *title = NSLocalizedString(@"Merci de patienter",@"");
    NSString *message = NSLocalizedString(@"Récupération des feux d'artifice",@"");
    self.alertViewRefresh = [[UIAlertView alloc] initWithTitle:title
                                                       message:message
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:nil];
    [self.alertViewRefresh show];
    
    LoadFeuxArticicesWSOperation *operation = [[LoadFeuxArticicesWSOperation alloc]init];
    [[AppDelegate sharedAppDelegate].operationQueue addOperation:operation];
}

-(void)didReceivedFeuxLoaded:(NSNotification*)notification {
    [self.alertViewRefresh dismissWithClickedButtonIndex:0 animated:YES];
    self.alertViewRefresh = nil ;
    
    [self loadDepartementsFromLocalDatabase];
    [self.tableViewFeux reloadData];
}

-(void)didReceivedFeuxFailed:(NSNotification*)notification {
    [self.alertViewRefresh dismissWithClickedButtonIndex:0 animated:YES];
    self.alertViewRefresh = nil ;
}

#pragma mark -
#pragma mark UITableViewDataSource,UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayOfDepartements.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0 ;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    Departement *departement = self.arrayOfDepartements[section];
    DepartementHeaderView *headerView = [self.dictOfHeaderViewByDepartement objectForKey:departement.numero];
    if ( headerView == nil ) {

        headerView = [[DepartementHeaderView alloc]initWithLabel:departement.label
                                        expandOrCollapseSelector:@selector(actionDepartementHeader:)
                                                  withController:self
                                               numeroDepartement:departement.numero
                                                         section:(int)section
                                                           frame:CGRectMake(0, 0, self.view.bounds.size.width, 44.0)];
        [self.dictOfHeaderViewByDepartement setObject:headerView forKey:departement.numero];
    }

    return headerView ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Departement *departement = self.arrayOfDepartements[section];
    DepartementHeaderView *headerView = [self.dictOfHeaderViewByDepartement objectForKey:departement.numero];

    if ( headerView.isExpanded == YES ) {
        return departement.feux.count ;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Departement *departement = self.arrayOfDepartements[indexPath.section];
    DepartementHeaderView *headerView = [self.dictOfHeaderViewByDepartement objectForKey:departement.numero];
    
    if ( headerView.isExpanded == YES ) {
        return 44.0 ;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifierFeuArtifice = @"FeuArtificeTableViewCell";
    
    FeuArtificeTableViewCell *cell = nil ;
    Departement *departement = self.arrayOfDepartements[indexPath.section];
    NSArray *arrayOfFeux = departement.sortedFeux ;
    
    FeuArtifice *feuArtifice = arrayOfFeux[indexPath.row];
    cell =  [tableView dequeueReusableCellWithIdentifier:CellIdentifierFeuArtifice forIndexPath:indexPath];

    [cell populateWithFeuArtifice:feuArtifice];
    
    return cell;
}

#pragma mark -
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ( [segue.identifier isEqualToString:@"showDetailsFeuArtifice"] ) {
        FeuArtificeDetailsViewController *detailsViewController ;

        NSIndexPath *selectedIndexPath = [self.tableViewFeux indexPathForSelectedRow];
        
        detailsViewController = (FeuArtificeDetailsViewController*)segue.destinationViewController ;
        
        Departement *departement = self.arrayOfDepartements[selectedIndexPath.section];
        NSArray *arrayOfFeux = departement.sortedFeux ;
        
        FeuArtifice *feuArtifice = arrayOfFeux[selectedIndexPath.row];
        
        
        [detailsViewController populateWithFeuArtifice:feuArtifice];
    }
}


@end
