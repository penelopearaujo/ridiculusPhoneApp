//
//  SearchViewController.m
//  ridiculusPhoneApp
//
//  Created by Penélope Araújo on 18/09/18.
//  Copyright © 2018 Penélope Araújo. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



// aqui, quando o telefone encontrar a tv, tem que chamar a proxima linha de codigo pra chamar a proxima tela.
// coloquei um botao pra funcionar so enquanto a gente ta testando, depois podemos excluir
//[self performSegueWithIdentifier:@"searchToTeams" sender:self];


- (IBAction)searchOkButton:(id)sender {
    [self performSegueWithIdentifier:@"searchToTeams" sender:self];
}
@end
