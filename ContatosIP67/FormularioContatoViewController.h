//
//  ViewController.h
//  ContatosIP67
//
//  Created by ios5994 on 28/05/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Contato.h"
#import "ContatoDao.h"

@protocol FormularioContatoViewControllerDelegate <NSObject>

-(void) contatoAtualizado:(Contato *) contato;
-(void) contatoAdicionado:(Contato *) contato;

@end

@interface FormularioContatoViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (weak) IBOutlet UITextField *nome;
@property (weak) IBOutlet UITextField *telefone;
@property (weak) IBOutlet UITextField *email;
@property (weak) IBOutlet UITextField *endereco;
@property (weak) IBOutlet UITextField *site;
@property (weak) IBOutlet UITextField *campoLat;
@property (weak) IBOutlet UITextField *campoLong;
@property (weak) IBOutlet UIButton *botaoFoto;

@property ContatoDao *contatoDao;
@property (strong) Contato *contato;

@property (weak) id<FormularioContatoViewControllerDelegate> delegate;

@end