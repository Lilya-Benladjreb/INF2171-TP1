;===================================================================================
;
; Ce programme permet de compter le nombre de 1 et de 0 d'une chaine 
; donnée par l'utilisateur. Selon son choix, les caracteres illegaux
; sont ignore ou pas.
;
; @auteur: Lilya Benladjreb
; @code permanent: BENL28549807
; @courriel: benladjreb.lilya@courrier.uqam.ca
;
; @groupe: 30
; @date: 2022-10-05
;===================================================================================
         LDA     0,i 
         LDX     0,i

debut:   STRO    messDeb,d   ;Affiche message initial
prompt:  CHARI   input,d     ;Prend le 1er char du input
         LDBYTEA input,d
         CPA     '$',i       ;comparaison avec plus petit caractere ASCII
         CPA     '1',i
         BREQ    menu        ;envoie au menu s'il trouve le caractere '1'
         CPA     '2',i
         BREQ    menu        ;envoie au menu s'il trouve le caractere '2'
         CPA     '0',i
         BREQ    menu      
         BRNE    illegalc    ;Si char n'est pas $,0,1,2 => c'est donc un char illegal  

illegalc:STRO    mauvaisC,d
         BR      prompt      ;retourne au input pour charger le prochain caractere
         

menu:    STA     choixmen,d  ;stock le choix dans une variable
         CPA     '1',i
         BREQ    choix1      ;envoie a la boucle approprie  
         CPA     '2',i
         BREQ    choix2      ;envoie a la boucle approprie

choix1:  CHARI   input,d     ;prend le prochain caractere du input
         LDBYTEA input,d     
         CPA     '0',i       
         BREQ    compte0     ;si trouve 0, rentre dans accumulateur de 0
         CPA     '1',i
         BREQ    compte1     ;si trouve 1, rentre dans accumulateur de 1
         CPA     '$',i       
         BREQ    aff         ;si trouve $, affiche le resultat
         BR      choix1      ;si ne trouve ni 1 ni 0, passe au suivant
                        

choix2:  CHARI   input,d     ;prend le prochain caractere du input
         LDBYTEA input,d
         CPA     '\n',i
         BREQ    choix2      ;si trouve saut de ligne, passe par dessus
         CPA     '$',i       
         BREQ    aff         ;si trouve $, affiche le resultat
         CPA     '0',i               
         BREQ    compte0     ;si trouve 0, rentre dans accumulateur de 0
         CPA     '1',i
         BREQ    compte1     ;si trouve 1, rentre dans accumulateur de 1 
         BRNE    carinv      ;si trouve caractere illegal               
         BR      choix2      ;si trouve 1, 0 ou $, fait un nouveau tour de boucle

compte0: LDA     cpt0,d      ;load la variable pour le compteur
         ADDA    1,i         ;ajoute 1
         STA     cpt0,d      ;stock la nouvelle valeur du compteur dans la variable
         LDA     0,i         ;initie l'accumulateur à 0
         LDA     cpt0,d      ;reprend la variable du compteur pour la mettre dans une variable resultat
         STA     res0,d
         LDA     choixmen,d  ;prend la variable du choix de menu pour retourner dans la boucle qui lui appartient
         CPA     '1',i
         BREQ    choix1      ;retourne a la boucle approprie
         CPA     '2',i
         BREQ    choix2      ;retourne a la boucle approprie
         
compte1: LDA     cpt1,d      ;load la variable pour le compteur
         ADDA    1,i         ;ajoute 1
         STA     cpt1,d      ;stock la nouvelle valeur du compteur dans la variable
         LDA     0,i         ;initie l'accumulateur à 0
         LDA     cpt1,d      ;reprend la variable du compteur pour la mettre dans une variable resultat
         STA     res1,d
         LDA     choixmen,d  ;prend la variable du choix de menu pour retourner dans la boucle qui lui appartient
         CPA     '1',i
         BREQ    choix1      ;retourne a la boucle approprie
         CPA     '2',i
         BREQ    choix2      ;retourne a la boucle approprie

carinv:  STRO    entreinv,d  ;affiche qu'il y a une entree invalide dans choix 2
         BR      fin
         
aff:     STRO    messRes0,d  ;affiche le message de resultat pour les 0
         DECO    res0,d      ;insere le resultat des 0 apres la phrase
         STRO    messRes1,d  ;affiche le message de resultat pour les 1
         DECO    res1,d      ;insere le resultat des 1 apres la phrase

fin:     STOP

messDeb: .ASCII  "Choisir quoi faire en cas de caractere invalide:\n1)Ignorer \n2)Rejeter\nChoix?\n\x00"
mauvaisC:.ASCII  "Mauvaise entree\n\x00"
messRes0:.ASCII  "Nombre de 0: \x00"
messRes1:.ASCII  "\nNombre de 1: \x00"
entreinv:.ASCII  "Entree invalide\n\x00"
input:   .BYTE   0
choixmen:.WORD   0       
cpt1:    .WORD   0
cpt0:    .WORD   0
res0:    .WORD   0
res1:    .WORD   0
         .END