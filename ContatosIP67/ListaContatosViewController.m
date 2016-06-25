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
        
        UIImage *icone = [UIImage imageNamed:@"lista-contatos.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Contato" image:icone tag:0];
        self.tabBarItem  = tabItem;
    
        self.dao = [ContatoDao contatoDaoInstance];
        self.linhaDestacada = -1;
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibirMaisAcoes:)];
        [self.tableView addGestureRecognizer:longPress];
        
    }
    
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated {
    if(self.linhaDestacada >= 0){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.linhaDestacada inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        self.linhaDestacada = -1;
    }
}


#pragma mark - Local Methods

-(void) exibeFormulario {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FormularioContatoViewController *form = [storyBoard instantiateViewControllerWithIdentifier:@"Form-Contato"];
    form.delegate = self;
    if(self.contatoSelecionado){
        form.contato = self.contatoSelecionado;
    }

    [self.navigationController pushViewController:form animated:YES];
}

- (void) exibirMaisAcoes:(UIGestureRecognizer *)gesture {
    if(gesture.state == UIGestureRecognizerStateBegan){
        CGPoint ponto = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:ponto];
        
        self.contatoSelecionado = [self.dao buscaContatoDaPosicao:index.row];
        self.gerenciador = [[GerenciadorDeAcoes alloc] initWithContato:self.contatoSelecionado];
        [self.gerenciador acoesDoController:self];
    }
}

#pragma mark - TableViewMethods

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

#pragma -mark Delegate methods

- (void) contatoAtualizado:(Contato *)contato{
    self.linhaDestacada = [self.dao buscaPosicaoDoContato:contato];

}

- (void) contatoAdicionado:(Contato *)contato {
    self.linhaDestacada = [self.dao buscaPosicaoDoContato:contato];
}

@end
