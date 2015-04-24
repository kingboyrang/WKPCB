//
//  CompanyMapViewController.m
//  WKPCB
//
//  Created by wulanzhou-mini on 15-2-13.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import "CompanyMapViewController.h"

@interface CompanyMapViewController ()<MKMapViewDelegate>

@end

@implementation CompanyMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"查看地图";
    self.mkMap.delegate=self;
    //设置地图中心
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 22.542264;
    coordinate.longitude = 114.085947;
    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
    ann.coordinate = coordinate;
    [ann setTitle:@"深圳市福田区华强广场Q1A024"];
    //触发viewForAnnotation
    [self.mkMap addAnnotation:ann];
    
    //设置显示范围
    MKCoordinateRegion region;
    region.span.latitudeDelta = 0.001;
    region.span.longitudeDelta = 0.001;
    region.center = coordinate;
    // 设置显示位置(动画)
    [self.mkMap setRegion:region animated:YES];
    // 设置地图显示的类型及根据范围进行显示
    [self.mkMap regionThatFits:region];
    //預設選中
    [self.mkMap selectAnnotation:ann animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -MKMapViewDelegate Methods
- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = nil;
    
    static NSString *defaultPinID = @"com.invasivecode.pin";
    pinView = (MKPinAnnotationView *)[self.mkMap dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if ( pinView == nil ) pinView = [[MKPinAnnotationView alloc]
                                      initWithAnnotation:annotation reuseIdentifier:defaultPinID] ;
    pinView.pinColor = MKPinAnnotationColorRed;
    pinView.canShowCallout = YES;
    pinView.animatesDrop = YES;
    return pinView;
}

@end
