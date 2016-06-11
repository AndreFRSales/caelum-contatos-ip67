//
//  ViewController.h
//  ContatosIP67
//
//  Created by ios5994 on 28/05/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "ContatoDao.h"

@interface FormularioContatoViewController : UIViewController

@property (weak) IBOutlet UITextField *nome;
@property (weak) IBOutlet UITextField *telefone;
@property (weak) IBOutlet UITextField *email;
@property (weak) IBOutlet UITextField *endereco;
@property (weak) IBOutlet UITextField *site;
@property ContatoDao *contatoDao;
@property (strong) Contato *contato;
 
@end