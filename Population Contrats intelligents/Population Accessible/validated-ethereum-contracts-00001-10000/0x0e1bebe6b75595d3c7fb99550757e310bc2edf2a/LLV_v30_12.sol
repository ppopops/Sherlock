pragma solidity 		^0.4.21	;							
											
	interface IERC20Token {										
		function totalSupply() public constant returns (uint);									
		function balanceOf(address tokenlender) public constant returns (uint balance);									
		function allowance(address tokenlender, address spender) public constant returns (uint remaining);									
		function transfer(address to, uint tokens) public returns (bool success);									
		function approve(address spender, uint tokens) public returns (bool success);									
		function transferFrom(address from, address to, uint tokens) public returns (bool success);									
											
		event Transfer(address indexed from, address indexed to, uint tokens);									
		event Approval(address indexed tokenlender, address indexed spender, uint tokens);									
	}										
											
	contract	LLV_v30_12		{							
											
		address	owner	;							
											
		function	LLV_v30_12		()	public	{				
			owner	= msg.sender;							
		}									
											
		modifier	onlyOwner	() {							
			require(msg.sender ==		owner	);					
			_;								
		}									
											
											
											
	// IN DATA / SET DATA / GET DATA / UINT 256 / PUBLIC / ONLY OWNER / CONSTANT										
											
											
		uint256	ID	=	1000	;					
											
		function	setID	(	uint256	newID	)	public	onlyOwner	{	
			ID	=	newID	;					
		}									
											
		function	getID	()	public	constant	returns	(	uint256	)	{
			return	ID	;						
		}									
											
											
											
	// IN DATA / SET DATA / GET DATA / UINT 256 / PUBLIC / ONLY OWNER / CONSTANT										
											
											
		uint256	ID_control	=	1000	;					
											
		function	setID_control	(	uint256	newID_control	)	public	onlyOwner	{	
			ID_control	=	newID_control	;					
		}									
											
		function	getID_control	()	public	constant	returns	(	uint256	)	{
			return	ID_control	;						
		}									
											
											
											
	// IN DATA / SET DATA / GET DATA / UINT 256 / PUBLIC / ONLY OWNER / CONSTANT										
											
											
		uint256	Cmd	=	1000	;					
											
		function	setCmd	(	uint256	newCmd	)	public	onlyOwner	{	
			Cmd	=	newCmd	;					
		}									
											
		function	getCmd	()	public	constant	returns	(	uint256	)	{
			return	Cmd	;						
		}									
											
											
											
	// IN DATA / SET DATA / GET DATA / UINT 256 / PUBLIC / ONLY OWNER / CONSTANT										
											
											
		uint256	Cmd_control	=	1000	;					
											
		function	setCmd_control	(	uint256	newCmd_control	)	public	onlyOwner	{	
			Cmd_control	=	newCmd_control	;					
		}									
											
		function	getCmd_control	()	public	constant	returns	(	uint256	)	{
			return	Cmd_control	;						
		}									
											
											
											
	// IN DATA / SET DATA / GET DATA / UINT 256 / PUBLIC / ONLY OWNER / CONSTANT										
											
											
		uint256	Depositary_function	=	1000	;					
											
		function	setDepositary_function	(	uint256	newDepositary_function	)	public	onlyOwner	{	
			Depositary_function	=	newDepositary_function	;					
		}									
											
		function	getDepositary_function	()	public	constant	returns	(	uint256	)	{
			return	Depositary_function	;						
		}									
											
											
											
	// IN DATA / SET DATA / GET DATA / UINT 256 / PUBLIC / ONLY OWNER / CONSTANT										
											
											
		uint256	Depositary_function_control	=	1000	;					
											
		function	setDepositary_function_control	(	uint256	newDepositary_function_control	)	public	onlyOwner	{	
			Depositary_function_control	=	newDepositary_function_control	;					
		}									
											
		function	getDepositary_function_control	()	public	constant	returns	(	uint256	)	{
			return	Depositary_function_control	;						
		}									
											
											
											
		address	public	User_1		=	msg.sender				;
		address	public	User_2		;//	_User_2				;
		address	public	User_3		;//	_User_3				;
		address	public	User_4		;//	_User_4				;
		address	public	User_5		;//	_User_5				;
											
		IERC20Token	public	Securities_1		;//	_Securities_1				;
		IERC20Token	public	Securities_2		;//	_Securities_2				;
		IERC20Token	public	Securities_3		;//	_Securities_3				;
		IERC20Token	public	Securities_4		;//	_Securities_4				;
		IERC20Token	public	Securities_5		;//	_Securities_5				;
											
		uint256	public	Standard_1		;//	_Standard_1				;
		uint256	public	Standard_2		;//	_Standard_2				;
		uint256	public	Standard_3		;//	_Standard_3				;
		uint256	public	Standard_4		;//	_Standard_4				;
		uint256	public	Standard_5		;//	_Standard_5				;
											
		function	Eligibility_Group_1				(				
			address	_User_1		,					
			IERC20Token	_Securities_1		,					
			uint256	_Standard_1							
		)									
			public	onlyOwner							
		{									
			User_1		=	_User_1		;			
			Securities_1		=	_Securities_1		;			
			Standard_1		=	_Standard_1		;			
		}									
											
		function	Eligibility_Group_2				(				
			address	_User_2		,					
			IERC20Token	_Securities_2		,					
			uint256	_Standard_2							
		)									
			public	onlyOwner							
		{									
			User_2		=	_User_2		;			
			Securities_2		=	_Securities_2		;			
			Standard_2		=	_Standard_2		;			
		}									
											
		function	Eligibility_Group_3				(				
			address	_User_3		,					
			IERC20Token	_Securities_3		,					
			uint256	_Standard_3							
		)									
			public	onlyOwner							
		{									
			User_3		=	_User_3		;			
			Securities_3		=	_Securities_3		;			
			Standard_3		=	_Standard_3		;			
		}									
											
		function	Eligibility_Group_4				(				
			address	_User_4		,					
			IERC20Token	_Securities_4		,					
			uint256	_Standard_4							
		)									
			public	onlyOwner							
		{									
			User_4		=	_User_4		;			
			Securities_4		=	_Securities_4		;			
			Standard_4		=	_Standard_4		;			
		}									
											
		function	Eligibility_Group_5				(				
			address	_User_5		,					
			IERC20Token	_Securities_5		,					
			uint256	_Standard_5							
		)									
			public	onlyOwner							
		{									
			User_5		=	_User_5		;			
			Securities_5		=	_Securities_5		;			
			Standard_5		=	_Standard_5		;			
		}									
		//									
		//									
											
		function	retrait_1				()	public	{		
			require(	msg.sender == User_1			);				
			require(	Securities_1.transfer(User_1, Standard_1)			);				
			require(	ID == ID_control			);				
			require(	Cmd == Cmd_control			);				
			require(	Depositary_function == Depositary_function_control			);				
		}									
											
		function	retrait_2				()	public	{		
			require(	msg.sender == User_2			);				
			require(	Securities_2.transfer(User_2, Standard_2)			);				
			require(	ID == ID_control			);				
			require(	Cmd == Cmd_control			);				
			require(	Depositary_function == Depositary_function_control			);				
		}									
											
		function	retrait_3				()	public	{		
			require(	msg.sender == User_3			);				
			require(	Securities_3.transfer(User_3, Standard_3)			);				
			require(	ID == ID_control			);				
			require(	Cmd == Cmd_control			);				
			require(	Depositary_function == Depositary_function_control			);				
		}									
											
		function	retrait_4				()	public	{		
			require(	msg.sender == User_4			);				
			require(	Securities_4.transfer(User_4, Standard_4)			);				
			require(	ID == ID_control			);				
			require(	Cmd == Cmd_control			);				
			require(	Depositary_function == Depositary_function_control			);				
		}									
											
		function	retrait_5				()	public	{		
			require(	msg.sender == User_1			);				
			require(	Securities_5.transfer(User_5, Standard_5)			);				
			require(	ID == ID_control			);				
			require(	Cmd == Cmd_control			);				
			require(	Depositary_function == Depositary_function_control			);				
		}									
											
											
											
											
//	1	Descriptif									
//	2	Place de march� d�centralis�e									
//	3	Forme juridique									
//	4	Pool pair � pair d�ploy� dans un environnement TP/SC-CDC (*)									
//	5	D�nomination									
//	6	��LUEBECK_LA_VALETTE�� / ��LLV_gruppe_v30.12��									
//	7	Statut									
//	8	��D.A.O.�� (Organisation autonome et d�centralis�e)									
//	9	Propri�taires & responsables implicites									
//	10	Les Utilisateurs du pool									
//	11	Juridiction (i)									
//	12	��Lausanne, Canton de Vaud, Conf�d�ration Helv�tique��									
//	13	Juridiction (ii)									
//	14	��Wien, Bundesland Wien, Austria��									
//	15	Instrument mon�taire de r�f�rence (i)									
//	16	��ethchf��									
//	17	Instrument mon�taire de r�f�rence (ii)									
//	18	��etheur��									
//	19	Instrument mon�taire de r�f�rence (iii)									
//	20	��ethczk��									
//	21	Devise de r�f�rence (i)									
//	22	��CHF��									
//	23	Devise de r�f�rence (ii)									
//	24	��EUR��									
//	25	Devise de r�f�rence (iii)									
//	26	��CZK��									
//	27	Date de d�ployement initial									
//	28	19.09.2008 (date de reprise des actifs de la holding en liquidation)									
//	29	Environnement de d�ployement initial									
//	30	(1�: 19.09.2008-01.08.2017) OTC (Lausanne)�; (2�: 01.08.2017-29.04.2018) suite protocolaire sur-couche ��88.2�� 									
//	31	Objet principal (i)									
//	32	Services de place de march� et de teneur de march� sous la forme d�un pool mutuel									
//	33	Objet principal (ii)									
//	34	Gestion des activit�s post-march�, dont�: contrepartie centrale et d�positaire									
//	35	Objet principal (iii)									
//	36	Garant									
//	37	Objet principal (iv)									
//	38	Teneur de compte									
//	39	Objet principal (v)									
//	40	��Chambre de compensation��									
//	41	Objet principal (vi)									
//	42	Op�rateur ��r�glement-livraison��									
//	43	@ de communication additionnelle (i)									
//	44	0x49720E96dC488c75DFE1576b3b2965b4fED92575 (# 15)									
//	45	@ de communication additionnelle (ii)									
//	46	0x2DF6FfB4e9B27Df827a7c8DEb31555875e095b3e (# 16)									
//	47	@ de publication additionnelle (protocole PP, i)									
//	48	0xD1dEB350B3ea3FEF2d6f0Ece4F19419B1c37A43f (# 17)									
//	49	Entit� responsable du d�veloppement									
//	50	Programme d�apprentissage autonome ��EVA�� / ��KYOKO�� / MS (sign)									
//	51	Entit� responsable de l��dition									
//	52	Programme d�apprentissage autonome ��EVA�� / ��KYOKO�� / MS (sign)									
//	53	Entit� responsable du d�ployement initial									
//	54	Programme d�apprentissage autonome ��EVA�� / ��KYOKO�� / MS (sign)									
//	55	(*) Environnement technologique protocolaire / sous-couche de type ��Consensus Distribu� et Chiffr頻									
//	56	(**) @ Annexes et formulaires�: <<<< --------------------------------- >>>> (confer�: points 43 � 48)									
//	57	-									
//	58	-									
//	59	-									
//	60	-									
//	61	-									
//	62	-									
//	63	-									
//	64	-									
//	65	-									
//	66	-									
//	67	-									
//	68	-									
//	69	-									
//	70	-									
//	71	-									
//	72	-									
//	73	-									
//	74	-									
//	75	-									
//	76	-									
//	77	-									
//	78	-									
											
											
}