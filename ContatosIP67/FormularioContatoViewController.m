
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
        UIBarButtonItem *confirmar = [[UIBarButtonItem alloc]
                                      initWithTitle:@"Confirmar"
                                      style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(atualizaContato)];
        
        self.navigationItem.rightBarButtonItem = confirmar;
        [self preencheDadosDoContato];
    }
}

#pragma mark - Methods Form Contact

- (void)pegaDadosDoFormulario {

    if(!self.contato){
        self.contato = [self.contatoDao novoContato];
    }
    
    if([self.botaoFoto backgroundImageForState:UIControlStateNormal]){
        self.contato.foto = [self.botaoFoto backgroundImageForState:UIControlStateNormal];
    }
    
    self.contato.nome = self.nome.text;
    self.contato.endereco = self.endereco.text;
    self.contato.site = self.site.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email = self.email.text;
    self.contato.latitude = [NSNumber numberWithFloat:[self.campoLat.text floatValue]];
    self.contato.longitude = [NSNumber numberWithFloat:[self.campoLong.text floatValue]];
}

- (void) criarContato {
    [self pegaDadosDoFormulario];
    [self.contatoDao adicionaContato:self.contato];
    
    if(self.delegate) {
        [self.delegate contatoAdicionado:self.contato];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) preencheDadosDoContato {
    self.nome.text = self.contato.nome;
    self.telefone.text = self.contato.telefone;
    self.endereco.text = self.contato.endereco;
    self.email.text = self.contato.email;
    self.site.text = self.contato.site;
    self.campoLat.text = [self.contato.latitude stringValue];
    self.campoLong.text = [self.contato.longitude stringValue];
    
    if(self.contato.foto){
        [self.botaoFoto setBackgroundImage:self.contato.foto forState:UIControlStateNormal];
        [self.botaoFoto setTitle:nil forState:UIControlStateNormal];
    }
}

-(void) atualizaContato {
    [self pegaDadosDoFormulario];
    
    if(self.delegate) {
        [self.delegate contatoAtualizado:self.contato];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)selecionaFoto:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Escolha a foto do contato" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar foto", @"Escolhe da biblioteca" ,nil];
        [sheet showInView:self.view];
    } else {
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

-(IBAction)buscarCoordenadas:(UIButton *)botao{
    [self.loading startAnimating];
    botao.hidden = YES;
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:self.endereco.text completionHandler:
     ^(NSArray *resultados, NSError *error){
         if((!error) && [resultados count] > 0){
             CLPlacemark *resultado = resultados.firstObject;
             CLLocationCoordinate2D coordenada = resultado.location.coordinate;
             self.campoLat.text = [NSString stringWithFormat:@"%f", coordenada.latitude];
             self.campoLong.text = [NSString stringWithFormat:@"%f", coordenada.longitude];
         }
         [self.loading stopAnimating];
         botao.hidden = NO;
     }];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [self.botaoFoto setBackgroundImage:imagemSelecionada forState:UIControlStateNormal];
    [self.botaoFoto setTitle:nil forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    
    switch (buttonIndex) {
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            break;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}

@end