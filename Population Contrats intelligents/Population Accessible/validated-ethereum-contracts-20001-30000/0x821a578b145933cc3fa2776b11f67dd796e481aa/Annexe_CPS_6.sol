pragma solidity 		^0.4.21	;							
												
		contract	Annexe_CPS_6		{							
												
			address	owner	;							
												
			function	Annexe_CPS_6		()	public	{				
				owner	= msg.sender;							
			}									
												
			modifier	onlyOwner	() {							
				require(msg.sender ==		owner	);					
				_;								
			}									
												
												
												
		// IN DATA / SET DATA / GET DATA / STRING / PUBLIC / ONLY OWNER / CONSTANT										
												
												
			string	Compte_1	=	"	une premi�re phrase			"	;	
												
			function	setCompte_1	(	string	newCompte_1	)	public	onlyOwner	{	
				Compte_1	=	newCompte_1	;					
			}									
												
			function	getCompte_1	()	public	constant	returns	(	string	)	{
				return	Compte_1	;						
			}									
												
												
												
		// IN DATA / SET DATA / GET DATA / STRING / PUBLIC / ONLY OWNER / CONSTANT										
												
												
			string	Compte_2	=	"	une premi�re phrase			"	;	
												
			function	setCompte_2	(	string	newCompte_2	)	public	onlyOwner	{	
				Compte_2	=	newCompte_2	;					
			}									
												
			function	getCompte_2	()	public	constant	returns	(	string	)	{
				return	Compte_2	;						
			}									
												
												
												
		// IN DATA / SET DATA / GET DATA / STRING / PUBLIC / ONLY OWNER / CONSTANT										
												
												
			string	Compte_3	=	"	une premi�re phrase			"	;	
												
			function	setCompte_3	(	string	newCompte_3	)	public	onlyOwner	{	
				Compte_3	=	newCompte_3	;					
			}									
												
			function	getCompte_3	()	public	constant	returns	(	string	)	{
				return	Compte_3	;						
			}									
												
												
												
		// IN DATA / SET DATA / GET DATA / STRING / PUBLIC / ONLY OWNER / CONSTANT										
												
												
			string	Compte_4	=	"	une premi�re phrase			"	;	
												
			function	setCompte_4	(	string	newCompte_4	)	public	onlyOwner	{	
				Compte_4	=	newCompte_4	;					
			}									
												
			function	getCompte_4	()	public	constant	returns	(	string	)	{
				return	Compte_4	;						
			}									
												
												
												
												
//	Descriptif :											
//	Relev� ��Teneur de Compte�� positions ��OTC-LLV��											
//	Edition initiale :											
//	03.05.2018											
//												
//	Teneur de Compte Interm�diaire :											
//	��C****** * P******* S********** Soci�t� Autonome et d�centralis�e (D.A.C.)��											
//	Titulaire des comptes (principal) / Groupe											
//	��C****** * P******* S********** Soci�t� Autonome et d�centralis�e (D.A.C.)��											
//												
//	-											
//	-											
//	-											
//	-											
//												
//	Place de march� :											
//	��LLV_v30_12��											
//	Teneur de march� (sans obligation contractuelle) :											
//	-											
//	Courtier / Distributeur :											
//	-											
//	Contrepartie centrale :											
//	��LLV_v30_12��											
//	D�positaire :											
//	��LLV_v30_12��											
//	Teneur de compte (principal) / Holding :											
//	��LLV_v30_12��											
//	Garant :											
//	��LLV_v30_12��											
//	��Chambre de Compensation�� :											
//	��LLV_v30_12��											
//	Op�rateur ��R�glement-Livraison�� :											
//	��LLV_v30_12��											
//												
//	Fonctions d'�dition de comptes :											
//	Input : [ _Compte_i ]											
//	Outputs : [ _Compte ; _Contrat ; _Cotation ; _Quantit� ; _Notionnel ; _Deposit ]											
//												
//												
//	��Compte��											
//	Compte du groupe C****** * P*******, par titulaire et ayant-droit-�conomique											
//	��Contrat��											
//	D�nomination du contrat											
//	��Cotation��											
//	Cours initial lors de la souscription du contrat											
//	��Quantit頻											
//	Nombre d'unit�s de compte en volume											
//	��Notionnel��											
//	Valeur notionnelle totale couverte											
//	��Deposit��											
//	Montant initial apport� en garantie lors de la souscription du contrat											
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
//												
												
												
	}