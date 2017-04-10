//
//  HomeViewController.m
//  nongji
//
//  Created by tobo on 17/3/27.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "HomeViewController.h"
#import "MoreUserListConteoller.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface HomeViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapView* _mapView;//地图界面
    BMKLocationService* _locService;
    BMKPinAnnotationView *_newAnnotation;
}

@property (nonatomic,strong) UIView * locationView;

@property (nonatomic,strong) UIImageView * locImageView;

@property (nonatomic,strong) UIView * messageView;

@property (nonatomic,strong) UILabel * addressLabel;

@property (nonatomic, strong)BMKGeoCodeSearch* searchAddress;
@property (nonatomic, assign)BOOL messageViewIsHidden;
@property (nonatomic,assign) CLLocationCoordinate2D location2D;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    self.vcTitle = @"地图";
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth(), ScreenHeight() - 64 -44)];
    _mapView.zoomLevel = 19.0;
    _mapView.showMapScaleBar = YES;//显示比例尺
    [self.view addSubview: _mapView];
    _searchAddress = [[BMKGeoCodeSearch alloc]init];
    _searchAddress.delegate = self;
    [self crateLocation];
    [self createNVC];
}

- (void)createNVC{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    button.frame = CGRectMake(ScreenWidth() - ViewWidth(80), MinY(_titileLabel), ViewWidth(50), viewHeight(_titileLabel));
    [button setImage:[UIImage imageNamed:@"ic_more"] forState:UIControlStateNormal];
    button.backgroundColor = UIColorFromRGB(0xeeeeee);
    [_nvView addSubview: button];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    //    _locService.delegate = self;
    //    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [BMKMapView enableCustomMapStyle:NO];//关闭个性化地图
    [_mapView viewWillDisappear];
    _locService.delegate = nil;
    _mapView.delegate = nil; // 不用时，置nil
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

#pragma mark ------- 定位----
- (void)crateLocation{
    //
    _locService = [[BMKLocationService alloc]init];
    NSLog(@"进入普通定位态");
    
    [_locService startUserLocationService];
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    _locService.delegate = self;
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc] init];
    displayParam.locationViewOffsetX=0;//定位偏移量(经度)
    displayParam.locationViewOffsetY=0;//定位偏移量（纬度）
    //这里替换自己的图标路径，必须把图片放到百度地图SDK的Resources/mapapi.bundle/images 下面
    //还有一种方法就是获取到_locationView之后直接设置图片
    displayParam.locationViewImgName=@"ic_action_position";
    [_mapView updateLocationViewWithParam:displayParam];
}
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    BMKCoordinateRegion region;
    
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0;
    region.span.longitudeDelta = 0;
    
    NSLog(@"当前的坐标是:%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    [_locService stopUserLocationService];//取消定位  这个一定要写，不然无法移动定位了
    _mapView.centerCoordinate = userLocation.location.coordinate;
    NSLog(@" _mapView.centerCoordinate------%f-----%f", _mapView.centerCoordinate.latitude, _mapView.centerCoordinate.longitude);
    [self createLocationSignImage];
    
}
/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}
/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}
//改变标注图片和自定义气泡
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    BMKAnnotationView *annotationView=[[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
    
    
    //自定义内容气泡
    UIView *areaPaoView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    areaPaoView.layer.cornerRadius=8;
    areaPaoView.layer.masksToBounds=YES;
    areaPaoView.layer.backgroundColor = UIColorFromRGB(0xffffff).CGColor;//这张图片是做好的透明
    //areaPaoView.backgroundColor=[UIColor whiteColor];
    if ([annotation.title isEqualToString:@"1"]) { //假设title的标题为1，那么就把添加上这个自定义气泡内容
        UILabel * labelNo = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 30)];
        labelNo.text =[NSString stringWithFormat:@"机车编号:%@",@11111];
        labelNo.textColor = [UIColor blackColor];
        labelNo.backgroundColor = [UIColor clearColor];
        [areaPaoView addSubview:labelNo];
        
        UILabel * labelStationName = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 200, 30)];
        labelStationName.text = [NSString stringWithFormat:@"机主姓名:张三三"];
        labelStationName.textColor = [UIColor blackColor];
        labelStationName.backgroundColor = [UIColor clearColor];
        [areaPaoView addSubview:labelStationName];
        
        UILabel * labelSumNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 200, 30)];
        labelSumNum.text = [NSString stringWithFormat:@"联系电话:15888888888"];
        labelSumNum.textColor = [UIColor blackColor];
        labelSumNum.backgroundColor = [UIColor clearColor];
        [areaPaoView addSubview:labelSumNum];
        
        UILabel * labelBicycleNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 200, 30)];
        labelBicycleNum.text = [NSString stringWithFormat:@"信誉:89"];
        labelBicycleNum.textColor = [UIColor blackColor];
        labelBicycleNum.backgroundColor = [UIColor clearColor];
        [areaPaoView addSubview:labelBicycleNum];
        annotationView.image =[UIImage imageNamed:@"ic_launcher"];
    }
    BMKActionPaopaoView *paopao=[[BMKActionPaopaoView alloc]initWithCustomView:areaPaoView];
    annotationView.paopaoView=paopao;
    
    
    return annotationView;
}
//这里是创建中心显示的图片和显示详细地址的View

- (void)createLocationSignImage{
    
    //LocationView定位在当前位置，换算为屏幕的坐标，创建的定位的图标
    
    self.locationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 28, 35)];
    self.locImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 28, 35)];
    self.locImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgrAction:)];
    [self.locImageView addGestureRecognizer:tgr];
    self.locImageView.image = [UIImage imageNamed:@"ic_action_position"];
    [self.locationView addSubview:self.locImageView];
    
    //messageView 展示定位信息的View和Label和button
    
    self.messageView = [[UIView alloc]init];
    self.messageView.backgroundColor = [UIColor whiteColor];
    
    //把当前定位的经纬度换算为了View上的坐标
    
    CGPoint point = [_mapView convertCoordinate:_mapView.centerCoordinate toPointToView:_mapView];
    
    //当解析出现错误的时候，会出现超出屏幕的情况，一种是大于了屏幕，一种是小于了屏幕
    if(point.x > ScreenWidth() || point.x < ScreenWidth()/5){
        
        point.x = _mapView.center.x;
        point.y = _mapView.center.y - 64;
        
    }
    
    NSLog(@"Point------%f-----%f",point.x,point.y);
    //重新定位了LocationView
  
    [_mapView addSubview:self.messageView];
    self.locationView.center = point;
    
    [self.locationView setFrame:CGRectMake(point.x-14, point.y-18, 28, 35)];
    //重新定位了messageView
    [self.messageView setFrame:CGRectMake(ScreenWidth()/4, point.y - 60 - 20, ScreenWidth() / 2, 60)];
    //展示地址信息的label
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.messageView.frame.size.width , 60)];
    self.addressLabel.numberOfLines = 0;
    self.addressLabel.font = [UIFont systemFontOfSize:13.0f];
    
    [self.messageView addSubview:self.addressLabel];
    
    [_mapView addSubview:self.locationView];
    
}

//地图被拖动的时候，需要时时的渲染界面，当渲染结束的时候我们就去定位然后获取图片对应的经纬度

- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus*)status{
   

    NSLog(@"onDrawMapFrame");
}

- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    NSLog(@"regionWillChangeAnimated");
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"regionDidChangeAnimated");
    
    
    CGPoint touchPoint = self.locationView.center;
    
    CLLocationCoordinate2D touchMapCoordinate =
    [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];//这里touchMapCoordinate就是该点的经纬度了
    NSLog(@"touching %f,%f",touchMapCoordinate.latitude,touchMapCoordinate.longitude);
     [_mapView removeAnnotations:_mapView.annotations];
    for (NSInteger i = 0; i<5; i++) {
        BMKPointAnnotation *item = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(touchMapCoordinate.latitude + arc4random() % 10/100.0,touchMapCoordinate.longitude + arc4random() % 10/100.0);//纬度，经度//纬度，经度
        item.coordinate = coords;
        item.title = @"1";
        [_mapView addAnnotation:item]; //添加大头针(每添加一次会调用 -)
    }
    BMKReverseGeoCodeOption * option = [[BMKReverseGeoCodeOption alloc]init];
    option.reverseGeoPoint = touchMapCoordinate;
    BOOL flag=[_searchAddress reverseGeoCode:option];
    
    if (flag) {
                _mapView.showsUserLocation=NO;//不显示自己的位置
    }
}
//点击地图中的背景有标记的区域
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi{
    NSLog(@"点击onClickedMapPoi---%@",mapPoi.text);
    
    CLLocationCoordinate2D coordinate = mapPoi.pt;
    //长按之前删除所有标注
    NSArray *arrayAnmation=[[NSArray alloc] initWithArray:_mapView.annotations];
    [_mapView removeAnnotations:arrayAnmation];
    //设置地图标注
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    annotation.title = mapPoi.text;
    [_mapView addAnnotation:annotation];
    BMKReverseGeoCodeOption *re = [[BMKReverseGeoCodeOption alloc] init];
    re.reverseGeoPoint = coordinate;
    //    [SVProgressHUD show];
    [_searchAddress reverseGeoCode:re];
    BOOL flag =[_searchAddress reverseGeoCode:re];
    if (!flag){
        NSLog(@"search failed!");
    }
}
//根据经纬度返回点击的位置的名称
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    //    [SVProgressHUD dismiss];
    NSString * resultAddress = @"";
    NSString * houseName = @"";
    
    CLLocationCoordinate2D  coor = result.location;
    
    if(result.poiList.count > 0){
        BMKPoiInfo * info = result.poiList[0];
        if([info.name rangeOfString:@"-"].location != NSNotFound){
            houseName = [info.name componentsSeparatedByString:@"-"][0];
        }else{
            houseName = info.name;
        }
        resultAddress = [NSString stringWithFormat:@"%@%@",result.address,info.name];
    }else{
        resultAddress =result.address;
    }
    
    if(resultAddress.length == 0){
       self.addressLabel.text = @"未知区域";
        return;
    }
    
  
    self.addressLabel.text = resultAddress;
    self.location2D = coor;

}
//点击一个大头针
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    NSLog(@"点击didSelectAnnotationView-");
}
- (void)tgrAction:(UITapGestureRecognizer *)tgr{
   
    if ([tgr.view isEqual:self.locImageView] && _messageViewIsHidden) {
        [_mapView addSubview:self.messageView];
        _messageViewIsHidden = NO;
    }else if([tgr.view isEqual:self.locImageView]){
        [self.messageView removeFromSuperview];
        
        _messageViewIsHidden = YES;
    }
}
- (void)buttonAction:(UIButton *)button{
    MoreUserListConteoller *vc = [[MoreUserListConteoller alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
