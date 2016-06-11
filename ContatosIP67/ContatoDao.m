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
        _contatos = [NSMutableArray new];
    }
    return self;
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

@end
