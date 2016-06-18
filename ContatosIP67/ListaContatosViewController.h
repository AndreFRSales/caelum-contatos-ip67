
//
//  ListaContatosViewController.h
//  ContatosIP67
//
//  Created by ios5994 on 04/06/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormularioContatoViewController.h"
#import "ContatoDao.h"
#import "GerenciadorDeAcoes.h"

@interface ListaContatosViewController : UITableViewController<FormularioContatoViewControllerDelegate>

@property ContatoDao *dao;
@property Contato *contatoSelecionado;
@property NSInteger linhaDestacada;
@property GerenciadorDeAcoes *gerenciador;

@end
