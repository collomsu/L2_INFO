#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#include "analyse_syntaxique.h"
#include "lecture_caracteres.h"
#include "analyse_lexicale.h"
#include "ast_construction.h"
#include "ast_parcours.h"

void rec_eag(Ast *A);
int Op1(TypeOperateur *op);
int Op2(TypeOperateur *op);

void affectation(Ast *A){
  Ast A1;
  TypeOperateur op;
  if(lexeme_courant().nature == IDF){
    A1 = creer_idf(lexeme_courant().chaine);
    avancer();
    int res = Op2(&op);
    if (res == 3) {
      rec_eag(A);
      *A = creer_operation(op,A1,*A);
      if(lexeme_courant().nature == SEPAFF){
        avancer();
      } else {
        printf("ERREUR Syntaxique: SEPAFF attendu non trouvé\n");
        exit(0);
      }
    } else {
      printf("ERREUR Syntaxique : AFF attendu non trouvé\n");
      exit(0);
    }
  } else {
    printf("ERREUR Syntaxique : IDF attendu non trouvé\n");
    exit(0);
  }
}

void seq_aff(Ast *A){
  Ast A2, A3;
  TypeOperateur op = N_ROWS;
  if(lexeme_courant().nature == IDF) {
    affectation(&A2);
    if(lexeme_courant().nature != FIN_SEQUENCE){
    seq_aff(&A3);
    *A = creer_operation(op,A2,A3);
    } else {
      *A = A2;
      avancer();
    }
  }
}

TypeOperateur Operateur(Nature_Lexeme n){
  switch (n) {
    case PLUS:
      return N_PLUS;
    case MOINS:
      return N_MOINS;
    case MUL:
      return N_MUL;
    case DIV:
      return N_DIV;
    case AFF:
      return N_AFF;
    default:
      printf("ERREUR Syntaxique : Operateur incorrect\n");
      exit(0);
  }
}

int Op1(TypeOperateur *op){
  switch(lexeme_courant().nature){
    case PLUS:
    case MOINS:
      *op = Operateur(lexeme_courant().nature);
      avancer();
      return 1;
    default:
      return 0;
  }
}

int Op2(TypeOperateur *op){
  switch(lexeme_courant().nature){
    case MUL:
      *op = Operateur(lexeme_courant().nature);
      avancer();
      return 1;
    case DIV:
      *op = Operateur(lexeme_courant().nature);
      avancer();
      return 2;
    case AFF:
      *op = Operateur(lexeme_courant().nature);
      avancer();
      return 3;
    default:
      return 0;
  }
}

void facteur(Ast *A1){
  switch (lexeme_courant().nature) {
    case IDF:
      *A1 = creer_idf(lexeme_courant().chaine);
      avancer();
      break;
    case ENTIER:
      *A1 = creer_valeur(lexeme_courant().valeur);
      avancer();
      break;
    case PARO:
      avancer();
      rec_eag(A1);
      if(lexeme_courant().nature == PARF){
        avancer();
      } else {
        printf("ERREUR Syntaxique : EAG incorrect (PARF manquante)\n");
        exit(0);
      }
      break;
    default:
      printf("%d\n", lexeme_courant().nature);
      printf("ERREUR Syntaxique : Facteur\n");
      exit(0);
  }
}

void suite_seq_facteur(Ast A1, Ast *A2){
  Ast A3, A4;
  TypeOperateur op;
  int res = Op2(&op);
  switch (res) {
    case 1:
      facteur(&A3);
      A4 = creer_operation(op, A1, A3);
      suite_seq_facteur(A4, A2);
      break;
    case 2:
      if(lexeme_courant().valeur == 0){
        printf("ERREUR Syntaxique : Division par 0 impossible\n");
        exit(0);
      }
      facteur(&A3);
      A4 = creer_operation(op, A1, A3);
      suite_seq_facteur(A4, A2);
      break;
    default:
      *A2 = A1;
  }
}

void seq_facteur(Ast *A1){
  Ast A2;
  facteur(&A2);
  suite_seq_facteur(A2,A1);
}

void terme(Ast *A){
  seq_facteur(A);
}

void suite_seq_terme(Ast A1, Ast *A2){
  Ast A3,A4;
  TypeOperateur op;
  if (Op1(&op)){
    terme(&A3);
    A4 = creer_operation(op, A1, A3);
    suite_seq_terme(A4, A2);
  } else {
    *A2 = A1;
  }
}

void seq_terme(Ast *A1){
  Ast A2;
  terme(&A2);
  suite_seq_terme(A2,A1);
}

void rec_eag(Ast *A){
  seq_terme(A);
}

/* etat initial : indifferent
etat final : une EAEP a ete lue dans le nom_fichier
si elle ne contient pas d'erreur de syntaxe un message est affiche
et la valeur de cette expression est fournie dans le parametre resultat
sinon le pgm termine sur un message d'erreur */

void analyser(char *fichier, Ast *arbre){
  demarrer(fichier);
  seq_aff(arbre);
  if(lexeme_courant().nature != FIN_SEQUENCE){
    printf("ERREUR Syntaxique : Syntaxe incorrect (fin de sequence non atteint)\n");
  }
}
