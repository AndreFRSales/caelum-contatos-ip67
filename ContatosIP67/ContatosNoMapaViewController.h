//
//  ContatosNoMapaViewController.h
//  ContatosIP67
//
//  Created by ios5994 on 18/06/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ContatosNoMapaViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property CLLocationManager *manager;

@end
