//
//  ContatoDao.h
//  ContatosIP67
//
//  Created by ios5994 on 28/05/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"
#import "BaseDao.h"

@interface ContatoDao : NSObject

@property (strong, readonly) NSMutableArray* contatos;
@property BaseDao* baseDao;

+(id) contatoDaoInstance;

- (void) adicionaContato:(Contato*) contato;
- (Contato *) buscaContatoDaPosicao:(NSInteger)posicao;
- (void) showListContacts;
- (void) removeContatoDaPosicao:(NSInteger) posicao;
- (NSInteger) buscaPosicaoDoContato:(Contato *) contato;

-(Contato *) novoContato;
-(void) saveContext;

@end
