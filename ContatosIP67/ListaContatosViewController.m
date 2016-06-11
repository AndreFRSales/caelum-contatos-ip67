//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios5994 on 04/06/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "ListaContatosViewController.h"

@interface ListaContatosViewController ()
@end

@implementation ListaContatosViewController

#pragma mark - Lifecycle

-(id) init {
    self = [super init];
    
    if(self) {
        self.navigationItem.title = @"Contatos";
        UIBarButtonItem *botaoExibirFormulario = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                            target:self
                                                                    action:@selector(exibeFormulario)];
        
        self.navigationItem.rightBarButtonItem = botaoExibirFormulario;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
        self.dao = [ContatoDao contatoDaoInstance];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - TableViewMethods

-(void) exibeFormulario {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FormularioContatoViewController *form = [storyBoard instantiateViewControllerWithIdentifier:@"Form-Contato"];
    if(self.contatoSelecionado){
        form.contato = self.contatoSelecionado;
    }

    [self.navigationController pushViewController:form animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dao.contatos count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
   
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Contato *contato = [self.dao buscaContatoDaPosicao:indexPath.row];
    cell.textLabel.text = contato.nome;
    
    return cell;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dao removeContatoDaPosicao:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.contatoSelecionado = [self.dao buscaContatoDaPosicao:indexPath.row];
    [self exibeFormulario];
    self.contatoSelecionado = nil;
}

@end
