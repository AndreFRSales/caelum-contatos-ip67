//
//  ContatoDao.m
//  ContatosIP67
//
//  Created by ios5994 on 28/05/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "ContatoDao.h"

@implementation ContatoDao

static ContatoDao *defaultDao = nil;

+(id) contatoDaoInstance{
    if(!defaultDao){
        defaultDao = [ContatoDao new];
    }
    return defaultDao;
}

- (id) init {
    self = [super init];
    if(self){
        self.baseDao = [BaseDao new];
        [self carregarContatos];
    }
    return self;
}

-(Contato *) novoContato;{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.baseDao.managedObjectContext];
}

- (void) adicionaContato:(Contato *)contato {
    [self.contatos addObject:contato];
}

- (Contato *) buscaContatoDaPosicao:(NSInteger )posicao {
    return [self.contatos objectAtIndex:posicao];
}

- (void) showListContacts{
    for(Contato* contato in _contatos){
        NSLog(@"Nome: %@", contato);
    }
}

- (void) carregarContatos{
    NSFetchRequest *buscaContatos = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    NSSortDescriptor *ordernarPorNome = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
    
    buscaContatos.sortDescriptors = @[ordernarPorNome];
    NSArray *contatosImutaveis = [self.baseDao.managedObjectContext executeFetchRequest:buscaContatos error:nil];
    _contatos = [contatosImutaveis mutableCopy];
}

- (void) removeContatoDaPosicao:(NSInteger)posicao {
    [self.contatos removeObjectAtIndex:posicao];
}

- (NSInteger) buscaPosicaoDoContato:(Contato *) contato{
    return [self.contatos indexOfObject:contato];
}

-(void) saveContext{
    [self.baseDao saveContext];
}


@end
