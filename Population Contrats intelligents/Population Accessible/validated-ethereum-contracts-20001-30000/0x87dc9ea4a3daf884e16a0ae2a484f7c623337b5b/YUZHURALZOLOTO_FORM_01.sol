pragma solidity 		^0.4.8	;						
											
		contract	Ownable		{						
			address	owner	;						
											
			function	Ownable	() {						
				owner	= msg.sender;						
			}								
											
			modifier	onlyOwner	() {						
				require(msg.sender ==		owner	);				
				_;							
			}								
											
			function 	transfertOwnership		(address	newOwner	)	onlyOwner	{	
				owner	=	newOwner	;				
			}								
		}									
											
											
											
		contract	YUZHURALZOLOTO_FORM_01				is	Ownable	{		
											
			string	public	constant	name =	"	YUZHURALZOLOTO_FORM_01		"	;
			string	public	constant	symbol =	"	UZU_01		"	;
			uint32	public	constant	decimals =		18			;
			uint	public		totalSupply =		0			;
											
			mapping (address => uint) balances;								
			mapping (address => mapping(address => uint)) allowed;								
											
			function mint(address _to, uint _value) onlyOwner {								
				assert(totalSupply + _value >= totalSupply && balances[_to] + _value >= balances[_to]);							
				balances[_to] += _value;							
				totalSupply += _value;							
			}								
											
			function balanceOf(address _owner) constant returns (uint balance) {								
				return balances[_owner];							
			}								
											
			function transfer(address _to, uint _value) returns (bool success) {								
				if(balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {							
					balances[msg.sender] -= _value; 						
					balances[_to] += _value;						
					return true;						
				}							
				return false;							
			}								
											
			function transferFrom(address _from, address _to, uint _value) returns (bool success) {								
				if( allowed[_from][msg.sender] >= _value &&							
					balances[_from] >= _value 						
					&& balances[_to] + _value >= balances[_to]) {						
					allowed[_from][msg.sender] -= _value;						
					balances[_from] -= _value;						
					balances[_to] += _value;						
					Transfer(_from, _to, _value);						
					return true;						
				}							
				return false;							
			}								
											
			function approve(address _spender, uint _value) returns (bool success) {								
				allowed[msg.sender][_spender] = _value;							
				Approval(msg.sender, _spender, _value);							
				return true;							
			}								
											
			function allowance(address _owner, address _spender) constant returns (uint remaining) {								
				return allowed[_owner][_spender];							
			}								
											
			event Transfer(address indexed _from, address indexed _to, uint _value);								
			event Approval(address indexed _owner, address indexed _spender, uint _value);								
										
											
											
											
//	1	Possible 1.1 � cr�dit��					� D�faut obligataire, obilgation (i), nominal��				
//	2	Possible 1.2 � cr�dit��					� D�faut obligataire, obilgation (i), int�r�ts��				
//	3	Possible 1.3 � cr�dit��					� D�faut obligataire, obilgation (iI), nominal��				
//	4	Possible 1.4 � cr�dit��					� D�faut obligataire, obilgation (ii), int�r�ts��				
//	5	Possible 1.5 � cr�dit��					� Assurance-cr�dit, support = police (i)��				
//	6	Possible 1.6 � cr�dit��					� Assurance-cr�dit, support = portefeuille de polices (j)��				
//	7	Possible 1.7 � cr�dit��					� Assurance-cr�dit, support = indice de polices (k)��				
//	8	Possible 1.8 � cr�dit��					� Assurance-cr�dit export, support = police (i)��				
//	9	Possible 1.9 � cr�dit��					� Assurance-cr�dit export, support = portefeuille de polices (j)��				
//	10	Possible 1.10 � cr�dit��					� Assurance-cr�dit export, support = indice de polices (k)��				
//	11	Possible 2.1 � liquidit頻					� Tr�sorerie libre��				
//	12	Possible 2.2 � liquidit頻					� Capacit� temporaire � g�n�rer des flux de tr�sorerie libre��				
//	13	Possible 2.3 � liquidit頻					� Capacit�s structurelles � g�n�rer ces flux��				
//	14	Possible 2.4 � liquidit頻					� Acc�s aux d�couverts � court terme��				
//	15	Possible 2.5 � liquidit頻					� Acc�s aux d�couverts � moyen terme��				
//	16	Possible 2.6 � liquidit頻					� Acc�s aux financements�bancaires �				
//	17	Possible 2.7 � liquidit頻					� Acc�s aux financements�institutionnels non-bancaires �				
//	18	Possible 2.8 � liquidit頻					� Acc�s aux financements�de pools pair � pair �				
//	19	Possible 2.9 � liquidit頻					� IP-Matrice entit�s��				
//	20	Possible 2.10 � liquidit頻					� IP-Matrice juridictions��				
//	21	Possible 3.1 � solvabilit頻					� Niveau du ratio de solvabilit� �				
//	22	Possible 3.2 � solvabilit頻					� Restructuration �				
//	23	Possible 3.3 � solvabilit頻					� Redressement �				
//	24	Possible 3.4 � solvabilit頻					� Liquidation �				
//	25	Possible 3.5 � solvabilit頻					� D�claration de faillite, statut (i) �				
//	26	Possible 3.6 � solvabilit頻					� D�claration de faillite, statut (ii) �				
//	27	Possible 3.7 � solvabilit頻					� D�claration de faillite, statut (iii) �				
//	28	Possible 3.8 � solvabilit頻					� Faillite effective / de fait �				
//	29	Possible 3.9 � solvabilit頻					� IP-Matrice entit�s��				
//	30	Possible 3.10 � solvabilit頻					� IP-Matrice juridictions��				
//	31	Possible 4.1 � �tats financiers��					� Chiffres d'affaires �				
//	32	Possible 4.2 � �tats financiers��					� Taux de rentabilit� �				
//	33	Possible 4.3 � �tats financiers��					� El�ments bilantiels �				
//	34	Possible 4.4 � �tats financiers��					� El�ments relatifs aux ngagements hors-bilan �				
//	35	Possible 4.5 � �tats financiers��					� El�ments relatifs aux engagements hors-bilan : assurances sociales �				
//	36	Possible 4.6 � �tats financiers��					� El�ments relatifs aux engagements hors-bilan : prestations de rentes �				
//	37	Possible 4.7 � �tats financiers��					� Capacit�s de titrisation �				
//	38	Possible 4.8 � �tats financiers��					� Simulations �l�ments OBS (i) �				
//	39	Possible 4.9 � �tats financiers��					� Simulations �l�ments OBS (ii) �				
//	40	Possible 4.10 � �tats financiers��					� Simulations �l�ments OBS (iii) �				
//	41	Possible 5.1 � fonctions march�s��					� Ressources informationnelles brutes �				
//	42	Possible 5.2 � fonctions march�s��					� Ressources prix indicatifs �				
//	43	Possible 5.3 � fonctions march�s��					� Ressources prix fermes �  / � Carnets d'ordres �				
//	44	Possible 5.4 � fonctions march�s��					� Routage �				
//	45	Possible 5.5 � fonctions march�s��					� N�goce �				
//	46	Possible 5.6 � fonctions march�s��					� Places de march� �				
//	47	Possible 5.7 � fonctions march�s��					� Infrastructures mat�rielles �				
//	48	Possible 5.8 � fonctions march�s��					� Infrastructures logicielles �				
//	49	Possible 5.9 � fonctions march�s��					� Services de maintenance �				
//	50	Possible 5.10 � fonctions march�s��					� Solutions de renouvellement �				
//	51	Possible 6.1 � m�tiers post-march�s��					� Acc�s contrepartie centrale �				
//	52	Possible 6.2 � m�tiers post-march�s��					� Acc�s garant �				
//	53	Possible 6.3 � m�tiers post-march�s��					� Acc�s d�positaire � / � Acc�s d�positaire-contrepartie centrale��				
//	54	Possible 6.4 � m�tiers post-march�s��					� Acc�s chambre de compensation��				
//	55	Possible 6.5 � m�tiers post-march�s��					� Acc�s op�rateur de r�glement-livraison��				
//	56	Possible 6.6 � m�tiers post-march�s��					� Acc�s teneur de compte��				
//	57	Possible 6.7 � m�tiers post-march�s��					� Acc�s march�s pr�ts-emprunts de titres��				
//	58	Possible 6.8 � m�tiers post-march�s��					� Acc�s r�mun�ration des comptes de devises en d�p�t��				
//	59	Possible 6.9 � m�tiers post-march�s��					� Acc�s r�mun�ration des comptes d'actifs en d�p�t��				
//	60	Possible 6.10 � m�tiers post-march�s��					� Acc�s aux m�canismes de d�p�t et appels de marge��				
//	61	Possible 7.1 � services financiers annexes��					� Syst�me international de notation�/ sph�re (i) �				
//	62	Possible 7.2 � services financiers annexes��					� Syst�me international de notation�/ sph�re (ii) �				
//	63	Possible 7.3 � services financiers annexes��					� Ressources informationnelles : �tudes et recherches�/ sph�re (i) �				
//	64	Possible 7.4 � services financiers annexes��					� Ressources informationnelles : �tudes et recherches�/ sph�re (ii) �				
//	65	Possible 7.5 � services financiers annexes��					� Eligibilit�, groupe (i) �				
//	66	Possible 7.6 � services financiers annexes��					� Eligibilit�, groupe (ii) �				
//	67	Possible 7.7 � services financiers annexes��					� Identifiant syst�me de pr�l�vements programmables �				
//	68	Possible 7.8 � services financiers annexes��					� Ressources actuarielles �				
//	69	Possible 7.9 � services financiers annexes��					� Services fiduciaires �				
//	70	Possible 7.10 � services financiers annexes��					� Standards de pr�vention et remise sur primes de couverture �				
//	71	Possible 8.1 � services financiers annexes��					� N�goce / front �				
//	72	Possible 8.2 � services financiers annexes��					� N�goce / OTC �				
//	73	Possible 8.3 � services financiers annexes��					� Contr�le / middle �				
//	74	Possible 8.4 � services financiers annexes��					� Autorisation / middle �				
//	75	Possible 8.5 � services financiers annexes��					� Comptabilit� / back �				
//	76	Possible 8.6 � services financiers annexes��					� R�vision interne �				
//	77	Possible 8.7 � services financiers annexes��					� R�vision externe �				
//	78	Possible 8.8 � services financiers annexes��					� Mise en conformit� �				
											
											
											
											
//	79	Possible 9.1 � syst�me bancaire��					� National��				
//	80	Possible 9.2 � syst�me bancaire��					� International��				
//	81	Possible 9.3 � syst�me bancaire��					� Holdings-filiales-groupes��				
//	82	Possible 9.4 � syst�me bancaire��					� Syst�me de paiement sph�re (i = pro)��				
//	83	Possible 9.5 � syst�me bancaire��					� Syst�me de paiement sph�re (ii = v)��				
//	84	Possible 9.6 � syst�me bancaire��					� Syst�me de paiement sph�re (iii = neutre)��				
//	85	Possible 9.7 � syst�me bancaire��					� Syst�me d'encaissement sph�re (i = pro)��				
//	86	Possible 9.8 � syst�me bancaire��					� Syst�me d'encaissement sph�re (ii = v)��				
//	87	Possible 9.9 � syst�me bancaire��					� Syst�me d'encaissement sph�re (iii = neutre)��				
//	88	Possible 9.10 � syst�me bancaire��					� Confer <fonctions march�> (*)��				
//	89	Possible 10.1 � syst�me financier��					� Confer <m�tiers post-march�> (**)��				
//	90	Possible 10.2 � syst�me financier��					� Configuration sp�cifique Mikola�ev��				
//	91	Possible 10.3 � syst�me financier��					� Configuration sp�cifique Donetsk��				
//	92	Possible 10.4 � syst�me financier��					� Configuration sp�cifique Louhansk��				
//	93	Possible 10.5 � syst�me financier��					� Configuration sp�cifique S�bastopol��				
//	94	Possible 10.6 � syst�me financier��					� Configuration sp�cifique Kharkiv��				
//	95	Possible 10.7 � syst�me financier��					� Configuration sp�cifique Makhachkala��				
//	96	Possible 10.8 � syst�me financier��					� Configuration sp�cifique Apraksin Dvor��				
//	97	Possible 10.9 � syst�me financier��					� Configuration sp�cifique Chelyabinsk��				
//	98	Possible 10.10 � syst�me financier��					� Configuration sp�cifique Oziorsk��				
//	99	Possible 11.1 � syst�me mon�taire��					� Flux de revenus et transferts courants�� / � IP��				
//	100	Possible 11.2 � syst�me mon�taire��					� Flux de revenus et transferts courants�� / � OP��				
//	101	Possible 11.3 � syst�me mon�taire��					� Changes, devise (i)��				
//	102	Possible 11.4 � syst�me mon�taire��					� Changes, devise (ii)��				
//	103	Possible 11.5 � syst�me mon�taire��					� Instruments mon�taires d�riv�s��				
//	104	Possible 11.6 � syst�me mon�taire��					� swaps��				
//	105	Possible 11.7 � syst�me mon�taire��					� swaptions��				
//	106	Possible 11.8 � syst�me mon�taire��					� solutions crois�es chiffr�es-fiat��				
//	107	Possible 11.9 � syst�me mon�taire��					� solutions de ponts inter-cha�nes��				
//	108	Possible 11.10 � syst�me mon�taire��					� solutions de sauvegarde inter-cha�nes��				
//	109	Possible 12.1 � march� assurantiel�& r�assurantiel �					� Juridique��				
//	110	Possible 12.2 � march� assurantiel�& r�assurantiel �					� Responsabilit� envers les tiers��				
//	111	Possible 12.3 � march� assurantiel�& r�assurantiel �					� Sanctions��				
//	112	Possible 12.4 � march� assurantiel�& r�assurantiel �					� G�opolitique��				
//	113	Possible 12.5 � march� assurantiel�& r�assurantiel �					� Expropriations��				
//	114	Possible 12.6 � march� assurantiel�& r�assurantiel �					� Compte s�questre��				
//	115	Possible 12.7 � march� assurantiel�& r�assurantiel �					� Acc�s r�seau de courtage��				
//	116	Possible 12.8 � march� assurantiel�& r�assurantiel �					� Acc�s titrisation��				
//	117	Possible 12.9 � march� assurantiel�& r�assurantiel �					� Acc�s syndicats��				
//	118	Possible 12.10 � march� assurantiel�& r�assurantiel �					� Acc�s pools mutuels de pair � pair��				
//	119	Possible 13.1 � instruments financiers �					� Matrice : march� primaire / march� secondaire / pools��				
//	120	Possible 13.2 � instruments financiers �					� Sch�ma de march� non-r�gul頻				
//	121	Possible 13.3 � instruments financiers �					� Sch�ma de march� non-organis頻				
//	122	Possible 13.4 � instruments financiers �					� Sch�ma de march� non-syst�matique��				
//	123	Possible 13.5 � instruments financiers �					� Sch�ma de march� contreparties institutionnelles��				
//	124	Possible 13.6 � instruments financiers �					� Sch�ma de chiffrement financier - Finance�/ �tats financiers �				
//	125	Possible 13.7 � instruments financiers �					� Sch�ma de chiffrement financier - Banque�/ ratio de cr�dit�				
//	126	Possible 13.8 � instruments financiers �					� Sch�ma de chiffrement financier - Assurance / provisions��				
//	127	Possible 13.9 � instruments financiers �					� Sch�ma de d�consolidation��				
//	128	Possible 13.10 � instruments financiers �					� Actions��				
//	129	Possible 13.11 � instruments financiers �					� Certificats��				
//	130	Possible 13.12 � instruments financiers �					� Droits associ�s��				
//	131	Possible 13.13 � instruments financiers �					� Obligations��				
//	132	Possible 13.14 � instruments financiers �					� Coupons��				
//	133	Possible 13.15 � instruments financiers �					� Obligations convertibles��				
//	134	Possible 13.16 � instruments financiers �					� Obligations synth�tiques��				
//	135	Possible 13.17 � instruments financiers �					� Instruments financiers d�riv�s classiques�/ <plain vanilla> �				
//	136	Possible 13.18 � instruments financiers �					� Instruments financiers d�riv�s sur-mesure, n�goci�s de gr� � gr頻				
//	137	Possible 13.19 � instruments financiers �					� Produits structur�s��				
//	138	Possible 13.20 � instruments financiers �					� Garanties��				
//	139	Possible 13.21 � instruments financiers �					� Cov-lite��				
//	140	Possible 13.22 � instruments financiers �					� Contrats adoss�s � des droits financiers��				
//	141	Possible 13.23 � instruments financiers �					� Contrats de permutation du risque d'impay� / cds��				
//	142	Possible 13.24 � instruments financiers �					� Contrats de rehaussement��				
//	143	Possible 13.25 � instruments financiers �					� Contrats commerciaux��				
//	144	Possible 13.26 � instruments financiers �					� Indices��				
//	145	Possible 13.27 � instruments financiers �					� Indices OP��				
//	146	Possible 13.28 � instruments financiers �					� Financements (i)��				
//	147	Possible 13.29 � instruments financiers �					� Financements (ii)��				
//	148	Possible 13.30 � instruments financiers �					� Financements (iii)��				
//	149	Empreinte 1.1 � document annexe �					� Couverture relative aux clauses �ventuelles de non-r�exportation��				
//	150	Empreinte 1.2 � document annexe �					� Couverture SDNs��				
//	151	Empreinte 1.3 � document annexe �					� Couverture investigations du r�gulateur��				
//	152	Empreinte 1.4 � document annexe �					� Couverture investigations priv�es��				
//	153	Empreinte 1.5 � document annexe �					� Couverture renseignement civil��				
//	154	Empreinte 1.6 � document annexe �					� Couverture renseignement militaire��				
//	155	Empreinte 1.7 � document annexe �					� Programmes d'apprentissage��				
//	156	Empreinte 1.8 � document annexe �					� Programmes d'apprentissage autonomes en intelligence �conomique��				
											
}