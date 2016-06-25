//
//  ContatosNoMapaViewController.h
//  ContatosIP67
//
//  Created by ios5994 on 18/06/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ContatoDao.h"
#import "Contato.h"

@interface ContatosNoMapaViewController : UIViewController<MKMapViewDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property CLLocationManager *manager;
@property (weak, nonatomic) NSMutableArray *contatos;
@property ContatoDao *dao;

@end
