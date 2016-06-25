//
//  ContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by ios5994 on 18/06/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "ContatosNoMapaViewController.h"

@interface ContatosNoMapaViewController ()

@end

@implementation ContatosNoMapaViewController


-(id)init{
    self = [super init];
    
    if(self){
        UIImage *icone = [UIImage imageNamed:@"mapa-contatos.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:icone tag:0];
        
        self.tabBarItem = tabItem;
        self.navigationItem.title = @"Localização";
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    MKUserTrackingBarButtonItem *botaoLocalizacao = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    self.navigationItem.rightBarButtonItem = botaoLocalizacao;
    self.manager = [CLLocationManager new];
    [self.manager requestWhenInUseAuthorization];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
