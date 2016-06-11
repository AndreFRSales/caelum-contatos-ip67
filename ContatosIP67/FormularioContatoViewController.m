
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

#pragma mark - Setup ViewController

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

-(void) viewDidLoad {
    [super viewDidLoad];
    if([self contato]) {
        UIBarButtonItem *confirmar = [[UIBarButtonItem alloc] initWithTitle:@"Confirmar" style:UIBarButtonItemStylePlain target:self action:@selector(atualizaContato)];
        self.navigationItem.rightBarButtonItem = confirmar;
        [self preencheDadosDoContato];
    }
}

#pragma mark - Methods Form Contact

- (void)pegaDadosDoFormulario {

    if(!self.contato){
        self.contato = [Contato new];
    }
    
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

- (void) preencheDadosDoContato {
    self.nome.text = self.contato.nome;
    self.telefone.text = self.contato.telefone;
    self.endereco.text = self.contato.endereco;
    self.email.text = self.contato.email;
    self.site.text = self.contato.site;
}

-(void) atualizaContato {
    [self pegaDadosDoFormulario];
    [self.navigationController popViewControllerAnimated:YES];
}

@end