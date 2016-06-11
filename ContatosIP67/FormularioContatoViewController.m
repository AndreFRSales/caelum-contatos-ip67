
//
//  ViewController.m
//  ContatosIP67
//
//  Created by ios5994 on 28/05/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"

@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        _contatoDao = [ContatoDao contatoDaoInstance];
        self.navigationItem.title = @"Cadastro";
        UIBarButtonItem *adiciona = [[UIBarButtonItem alloc] initWithTitle:@"Adiciona" style:UIBarButtonItemStylePlain target:self action:@selector(criarContato)];
        self.navigationItem.rightBarButtonItem = adiciona;
    }
    
    return self;
}

- (void)pegaDadosDoFormulario {
    self.contato = [Contato new];
    
    self.contato.nome = self.nome.text;
    self.contato.endereco = self.endereco.text;
    self.contato.site = self.site.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email = self.email.text;
}

- (void) criarContato {
    [self pegaDadosDoFormulario];
    [self.contatoDao adicionaContato:self.contato];
    [self.contatoDao showListContacts];
    [self.navigationController popViewControllerAnimated:YES];
}

@end