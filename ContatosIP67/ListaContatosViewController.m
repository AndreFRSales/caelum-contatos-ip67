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

-(id) init {
    self = [super init];
    
    if(self) {
        self.navigationItem.title = @"Contatos";
        UIBarButtonItem *botaoExibirFormulario = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                            target:self
                                                                    action:@selector(exibeFormulario)];
        
        self.navigationItem.rightBarButtonItem = botaoExibirFormulario;
        self.dao = [ContatoDao contatoDaoInstance];
    }
    
    return self;
}

-(void) exibeFormulario {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FormularioContatoViewController *form = [storyBoard instantiateViewControllerWithIdentifier:@"Form-Contato"];
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

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

@end
