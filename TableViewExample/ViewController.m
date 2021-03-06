//
//  ViewController.m
//  TableViewExample
//
//  Created by Jerry on 22/01/15.
//  Copyright (c) 2015 Jerry. All rights reserved.
//

#import "ViewController.h"
#import "MyViewController.h"
#import "Car.h"
#import "CarCell.h"

#define CELL_ID @"CarCell"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if(self) {
        //custom initialization
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableData = [NSArray arrayWithObjects:@"Jozko", @"Misko", @"Anka", @"Ferko", @"Zuzka", @"Jarko", @"Miska", nil];
    self.images = [NSArray arrayWithObjects:@"AutoRacing_TouringCar.png",
                   @"executive.png",
                   @"ferrari.png",
                   @"hyundai_coupe.png",
                   @"car_black.png",
                   @"Car.png",
                   @"pagani.png",
                   nil];
    self.cars = [NSMutableArray arrayWithCapacity:self.tableData.count];
    
    for (int i = 0; i < self.tableData.count; i++) {
        Car *car = [[Car alloc] init];
        car.title = [self.tableData objectAtIndex:i];
        car.imagePath = [self.images objectAtIndex:i];
        [self.cars addObject:car];
    }
    
    [self.tableView registerClass:[CarCell class] forCellReuseIdentifier:@"Cell"];
    self.navigationItem.title = @"Cars";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                              target:self
                                              action:@selector(showAlert)];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor
                                                            colorWithRed:255.0/255
                                                            green:135.0/255
                                                            blue:0.0/255
                                                            alpha:1.0];
    self.tabBarController.tabBar.tintColor = [UIColor
                                               colorWithRed:255.0/255 green:135.0/255 blue:0.0/255 alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = CELL_ID;

    CarCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];
    Car *currCar = [self.cars objectAtIndex:indexPath.row];
    cell.titleLabel.text = currCar.title;
    cell.imageView.image = [UIImage imageNamed:currCar.imagePath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSLog(@"%@", cell.titleLabel.text);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    UIAlertView *uiAlertView = [[UIAlertView alloc]
                                initWithTitle:@"Clicked"
                                message:[NSString stringWithFormat:@"Just clicked %@",
                                         [self.tableData objectAtIndex:indexPath.row]]
                                delegate:self
                                cancelButtonTitle:@"Cancel"
                                otherButtonTitles:@"Yeah", nil];
    [uiAlertView show];
    MyViewController *myViewController = [[MyViewController alloc] initWithNibName:@"MyViewController" bundle:nil];
    MyViewController *myViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"myViewController"];
    [self.navigationController pushViewController:myViewController animated:YES];
     */
    
    self.name = [self.tableData objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showDetailSegue" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        MyViewController *myViewController = (MyViewController*)[segue destinationViewController];
        NSLog(@"Name = %@", self.name);
        myViewController.name = self.name;
    }
}

- (void)showAlert {
    
    UIAlertView *uiAlertView = [[UIAlertView alloc]
                                initWithTitle:@"Clicked"
                                message: @"Alert showed up :)"
                                delegate:self
                                cancelButtonTitle:@"Cancel"
                                otherButtonTitles:@"Yeah", nil];
    [uiAlertView show];
    
}

@end
