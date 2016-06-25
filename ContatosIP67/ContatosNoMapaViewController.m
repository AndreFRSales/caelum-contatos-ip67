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
        self.contatos = [[ContatoDao contatoDaoInstance] contatos];
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

-(void) viewWillAppear:(BOOL)animated{
    [self.mapa addAnnotations:self.contatos];
}

-(void) viewWillDisappear:(BOOL)animated{
    [self.mapa removeAnnotations:self.contatos];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    
    static NSString *identifier = @"pino";
    MKPinAnnotationView *pino = (MKPinAnnotationView *)[self.mapa dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(!pino){
        pino = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    } else {
        pino.annotation = annotation;
    }
    
    Contato *contato = (Contato *)annotation;
    pino.pinColor = MKPinAnnotationColorGreen;
    pino.canShowCallout = YES;
    
    if(contato.foto)
    {
        UIImageView *imagemContato = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 32.0, 32.0)];
        imagemContato.image = contato.foto;
        pino.leftCalloutAccessoryView = imagemContato;
    }
    
    return pino;
}


@end
