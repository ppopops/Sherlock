pragma solidity ^0.4.18;

// ----------------------------------------------------------------------------
// 'dCHF' token contract
//
// Deployed to : 0x0000F70bC78af03f14132c68b59153E4788bAb20  on march 20th 2018 somewhere after Block 52911611
// Symbol      : dCH
// Name        : private digitale Schweizer Franken - private digital Swiss Franc 
// Total supply: 15000,00
// Decimals    : 2
//
// based on code made by
//
//  Moritz Neto with BokkyPooBah / Bok Consulting Pty Ltd Au 2017. The MIT Licence.
// ----------------------------------------------------------------------------
//
// ----------------------------------------------------------------------------
// ALLGEMEINE GESCHAEFTSBEDINGUNGEN f�r die Nutzung von privaten digitalen Schweizer Franken
// ----------------------------------------------------------------------------
//
// -----------------------------
// 1. Diese Allgemeinen Gesch�ftsbedingungen gelten ausschliesslich f�r Rechtsgesch�fte zwischen der Scenic Swisscoast GmbH, 3012 Bern (CH-ID:  CH03540319700) und dem Kunden im Rahmen des Verkaufs und der Annahme von privaten digitalen Schweizer Franken. Diese Dienstleitungen der Scenic Swisscoast GmbH ba-sieren ausschliesslich auf der Grundlage dieser Allgemeinen Gesch�ftsbedingungen.
// -----------------------------
// 2. Definition: 
// -----------------------------
//     Bei der Scenic Swisscoast GmbH handelt es sich um ein privates Schweizer Unternehmen. Sie verkauft die privaten digitalen Schweizer Franken als Kryptow�hrung in eigenem Namen und auf eigene Rechnung. Sce-nic Swisscoast GmbH ist keine Beh�rde und handelt weder als Beh�rde noch in einem amtlichen Auftrag. Sce-nic Swisscoast GmbH ist auch keine Bank. Die privaten digitalen Schweizer Franken sind ein privates digitales Zahlungsmittel in Schweizer Franken, das von der Scenic Swisscoast GmbH auf einer Blockchain geschaffen und verkauft wird. Solche privaten Zah-lungsmittel werden auch als �digitales Geld�, �virtuelles Geld� oder �Kryptow�hrungen� bezeichnet. Bei den privaten digitalen Schweizer Franken handelt es sich weder um staatliches Geld noch um ein gesetz-liches Zahlungsmittel. Es ist ein privates digitales Zahlungsmittel. F�r die privaten digitalen Schweizer Fran-ken besteht in der Schweiz keine Pflicht zur Annahme als Zahlungsmittel. Sie k�nnen nur bei der Scenic Swisscoast GmbH f�r den Kauf von Tickets f�r das 1. International Innovation Film Festival in Bern, das vom 14.-18. Februar 2019 stattfinden wird, sowie f�r Dienstleistungen der Scenic Swisscoast GmbH zur Zahlung verwendet werden. Bei den privaten digitalen Schweizer Franken handelt es sich nicht um sog. �elektronisches Geld� im engeren Sinne. Der K�ufer der privaten digitalen Schweizer Franken hat keine Forderung gegen die Scenic Swisscoast GmbH und kann diese bei der Scenic Swisscoast GmbH nicht gegen gesetzliche Zahlungsmittel umtauschen. Kryptow�hrungen wie Bitcoin oder Ether werden �blicherweise in einer eigenen W�hrung ausgegeben. Die privaten digitalen Schweizer Franken werden in Schweizer Franken als W�hrung ausgegeben. Damit entf�llt das bei Kryptow�hrungen bestehende Wechselkursrisiko. Der K�ufer der privaten digitalen Schweizer Fran-ken kann diese beim Kauf von Tickets f�r das 1. International Innovation Film Festival in Bern oder bei der Bezahlung von Dienstleistungen der Scenic Swisscoast GmbH 1:1 in Schweizer Franken verwenden. Die privaten digitalen Schweizer Franken sind ein eindeutiger, ERC-20 standardisierter Token auf der Ethereum-Blockchain mit der eindeutigen Ethereumcontract - nummer von diesem Smart Contract hier: Alle Vertragsdetails k�nnen mit einem Blockchainexplorer wie zum Beispiel etherscan.io eingesehen werden: 
// -----------------------------
// 3. Verkauf des Digitalen Schweizer Frankens:
// -----------------------------
//     Verk�ufer:
//      Verk�ufer der privaten digitalen Schweizer Franken ist die Scenic Swisscoast GmbH. Diese verkauft die priva-ten digitalen Schweizer Franken auf der Webseite www.innovationfilmfestival.ch.
//
//  Der K�ufer: 
// 1.	muss beim bei der Bestellung Name, Vorname, Adresse inklusive Wohnort sowie Email und Mobil-Telefonnummer angeben 
// 2.	kann f�r 100, 500 oder 750 Franken private digitale Schweizer Franken kaufen 
// 3.	kann f�r maximal 750 Franken private digitale Schweizer Franken kaufen 
// 4.	muss �ber eine Ethereumadresse verf�gen oder eine erstellen, um die privaten digitalen Schweizer Fran-ken entgegenzunehmen 
// 5.	verliert beim Verlust des private Keys zur Ethereumadresse oder bei Verlust des Wallets mit der Ethereumadresse seine privaten digitalen Schweizer Franken, sofern er kein Backup erstellt hat. Weder die Scenic Swisscoast GmbH noch sonst eine Institution ist technisch in der Lage, verlorengegangene pri-vate digitale Schweizer Franken oder private Keys widerherzustellen oder r�ckzuverg�ten. 
// 6.	muss sich der Risiken der Ethereumblockchaintechnologie bewusst sein: insbesondere muss sich der Kun-de bewusst sein, dass die Scenic Swisscoast GmbH nicht f�r die Ethereumblockchain und/oder das Eth-reumnetzwerk noch die Verf�gbarkeit verantwortlich ist. 
// 7.	muss sich bewusst sein, dass er nur mit den privaten digitalen Schweizer Franken bezahlen kann, wenn er auf das Internet zugreifen kann. 
// 8.	muss sich der Risiken bewusst sein, die ein allf�lliger Entwicklungsschub in der Quantenkryptografie zu bedeuten h�tte. 
// 9.	muss sich der grunds�tzlichen Risiken der Blockchaintechnologie bewusst sein. Sowohl die Technologie selbst als auch der Umgang mit der Technologie k�nnen die Sicherheit der privaten digitalen Schweizer Franken beeintr�chtigen. 
// 10.	muss sich der Risiken, die Software und Webseiten Dritter bergen, bewusst sein. Insbesondere sind da Walletgeneratoren, mobile Apps und Betriebssysteme von mobilen Ger�ten und sonstiger Hardware zu erw�hnen.
// 11.	muss sich unerwarteter Risiken bewusst sein. Die Ethereumtechnologie ist noch verh�ltnism�ssig jung und es k�nnen unerwartete Risiken auftreten. 
// 12.	kann w�hlen, wie er die privaten digitalen Schweizer Franken bezahlen will. M�glich ist eine Zahlung auf das Postkonto der Scenic Swisscoast GmbH oder eine Zahlung via PayPal oder eine Bezahlung mit Ether.
// 13.	muss sich bewusst sein, dass es f�r den Transfer von privaten digitalen Schweizer Franken einen kleinen Betrag Ether braucht. Dieser Betrag h�ngt von verschiedenen Faktoren ab, auf welche Scenic Swisscoast GmbH keinen Einfluss hat (z.B. Gaspreis, Geschwindigkeit der Transaktion, Traffic auf der Ethereumblock-chain). Scenic Swisscoast GmbH wird bei jedem Verkauf von privaten digitalen Schweizer Franken dem K�ufer zus�tzlich und freiwillig 0.0001 Ether auf die vom Kunden genannte Ethereumadresse mit�berwei-sen. Dieser Betrag erm�glich dem Kunden (Stand: Ausgabe der AGB) mindestens eine �berweisung von privaten digitalen Schweizer Franken. Dar�ber hinaus tr�gt der Kunde die Kosten f�r weitere �berwei-sungen von privaten digitalen Schweizer Franken auf der Ethereumblockchain selber.
// 14.	muss sich bewusst sein, dass �berweisungen von privaten digitalen Schweizer Franken auf falsche Ethereumadressen nicht r�ckg�ngig gemacht werden k�nnen und somit verloren sind. Der Kunde muss insbesondere bei der Bezahlung via Bankeinzahlung oder PayPal sicherstellen, dass er der Scenic Swisscoast GmbH die richtige Ethereumadresse angibt. 

// Bei der Bezahlung auf das Postkonto oder via PayPal
// stellt die Scenic Swisscoast GmbH innert 24h eine Rechnung per Mail zu, die innert 7 Tagen bezahlt sein muss. Die privaten digitalen Schweizer Franken werden innert 7 Tagen nach Eingang der Zahlung (Post/Paypal) auf die angegebene Ethereumadresse �berwiesen. 

// Bei der Bezahlung mit Ether 
// -	berechnet die Scenic Swisscoast GmbH den Etherwechselkurs gem�ss Angaben von Kraken (in ETH/EUR mit einem CHF/Euro-Wechselkurs gem�ss http://www.finanzen.ch/devisen/eurokurs).
// -	erstellt die Scenic Swisscoast GmbH eine Rechnung und einen Smartcontract f�r den Umtausch von Ether in private digitale Schweizer Franken.
// - 	auf dieser Rechnung ist die Ethereumadresse des Smartcontracts aufgef�hrt.
// -    Der Smartcontract tauscht automatisch Ether in private digitale Schweizer Franken zum berechneten Wechselkurs um. Der Kunde muss den in Rechnung gestellten Betrag in Ether an die Ethereumadresse des Smartcontracts senden und erh�lt automatisch vom Smartcontract die privaten digitalen Schweizer Fran-ken auf sein Ethereumwallet. Der Kunde muss den Betrag von einem Wallet aus senden, auf das er vollen Zugriff hat (zum Beispiel mittels private Key).
// -    Auf Wunsch kann der Kunde bei der Bezahlung mit Ether die Alternative ohne Smartcontract w�hlen. Er 
// 1) bezahlt den verrechneten Betrag in Ether auf die Ethereumadresse von Scenic Swisscoast GmbH, 
// 2) gibt der Scenic Swisscoast GmbH seine eigene Ethereumadresse an, auf die er vollen Zugriff hat (zum Beispiel mittels private Key)
// 3) erh�lt von der Scenic Swisscoast GmbH innert 7 Tagen die ihm zustehenden Digitalen Schweizer Franken auf das angegeben Wallet.
// Bei einer Bezahlung mit Ether ist die Bezahlung mittels Smartcontract unmittelbar.
// 
// Verkaufsbeschr�nkung
// Der Verkauf ist auf 15�000 private digitale Schweizer Franken mit je zwei Nachkommastellen beschr�nkt. Die Scenic Swisscoast GmbH beh�lt sich vor, zu einem sp�teren Zeitpunkt weitere private digitale Schweizer Fran-ken zu verkaufen.
// 
// Die privaten digitalen Schweizer Franken werden ausschliesslich an Personen mit Wohnsitz in der Schweiz verkauft.
//
// -----------------------------
//4.	Verwendung der privaten digitalen Schweizer Franken / Akzeptanzstellen: 
// -----------------------------
// Die Scenic Swisscoast GmbH ist Mitveranstalterin des 1. International Innovation Film Festival in Bern das vom 14.-18. Februar stattfindet. Sie hat das Vorkaufsrecht auf alle Tickets der 9 Kinovorf�hrungen im Rahmen des Filmfestivals. Die privaten digitalen Schweizer Franken werden am Festival f�r den Kinoticketkauf als Zahlungsmittel zum Nennwert akzeptiert werden. Im Weiteren akzeptiert die Scenic Swisscoast GmbH die privaten digitalen Schweizer Franken als Zahlungsmittel f�r ihre eigenen Dienstleistungen. Die Scenic Swisscoast GmbH beh�lt sich vor, weitere Akzeptanzstellen f�r die privaten digitalen Schweizer Franken zu schaffen.
//
//4.1		Keine R�ckgabe der privaten digitalen Schweizer Franken: Die R�ckgabe nicht gebrauchter privater digitaler Schweizer Franken an die Scenic Swisscoast GmbH ist aus-geschlossen.
//
// -----------------------------
//5.	Preise: 
// -----------------------------
//Der Digitale Schweizer Franken wird zu folgenden Preisen verkauft: 
//vor dem 25. M�rz 2018:115 private digitale Schweizer Franken f�r 100 Schweizer Franken 
//vor dem 31.M�rz 2018:	110 private digitale Schweizer Franken f�r 100 Schweizer Franken 
//vor dem 1. August 2018: 105 private digitale Schweizer Franken f�r 100 Schweizer Franken 
//nach dem 1. August 2018: 100 private digitale Schweizer Franken f�r 100 Schweizer Franken
//
//
// -----------------------------
//6.	Verantwortung der Scenic Swisscoast GmbH: 
// -----------------------------
//Die Scenic Swisscoast GmbH hat die privaten digitalen Schweizer Franken nach g�ngigem Standard entwi-ckelt und auf der Ethereum Blockchain ver�ffentlicht. 
//Die Scenic Swisscoast GmbH ist weder verantwortlich noch zust�ndig f�r die Verf�gbarkeit des Internetzu-griffs, des Zustandes des Ethereumnetzwerks oder die Sicherheit des ERC-20 Standards.
//
//
// -----------------------------
//7.	Sorgfaltspflichten des Kunden:
// -----------------------------
//Der Kunde verpflichtet sich, wahrheitsgem�sse, exakte, aktuelle und vollst�ndige Angaben zu seiner Person und seiner Ethereumadresse auf dem Bestellformular zu machen. Scenic Swisscoast GmbH schliesst f�r Verlus-te und Sch�den, die sich aus der Nichterf�llung dieser Verpflichtungen ergeben, jegliche Haftung aus. Scenic Swisscoast GmbH beh�lt sich vor, diese Angaben durch R�ckruf oder �hnliche geeignete Massnahmen zu �berpr�fen und bei Missachtung unserer AGB einzelne Personen vom Verkauf auszuschliessen.
//
// -----------------------------
//8.	Datenschutz:
// -----------------------------
//Scenic Swisscoast GmbH ist berechtigt, die Anmeldedaten im Rahmen der Erf�llung der Vertragszwecke zu speichern, zu ver�ndern oder zu �bermitteln. Scenic Swisscoast GmbH weist den Kunden darauf hin, dass per-sonenbezogene Daten im Rahmen der Vertragsdurchf�hrung gespeichert werden. Der Kunde willigt mit der Akzeptierung dieser AGB ein, dass die erhobenen Daten, insbesondere auch die Ethereumadresse, von Scenic Swisscoast GmbH verarbeitet und genutzt werden k�nnen. Der Kunde kann der Verwendung seiner Daten je-derzeit widersprechen.
//
// -----------------------------
//9.	Gew�hrleistung, Haftung:
// -----------------------------
//Der Kunde erkl�rt sich ausdr�cklich damit einverstanden, dass die Nutzung des von Scenic Swisscoast GmbH zur Verf�gung gestellten Dienstes auf eigene Gefahr erfolgt. Scenic Swisscoast GmbH haftet nicht im Falle h�herer Gewalt, insbesondere bei Ausfall von Telefonleitungen oder Internetleitungen, Arbeitskampfmass-nahmen, Hochwasser, beh�rdlichen Massnahmen, unvorhersehbarem Ausfall von Transportmitteln oder Energie oder sonstigen unabwendbaren Ereignissen. Dies gilt auch, wenn die vorstehenden Ereignisse bei ei-nem Erf�llungsgehilfen der Scenic Swisscoast GmbH eintreten.
//
//
// -----------------------------
//10.	�nderung des Angebotes:
// -----------------------------
//Die Scenic Swisscoast GmbH beh�lt sich vor, die angebotenen Dienste mit oder ohne Mitteilung an den Kun-den zeitweilig oder auf Dauer zu �ndern, zu unterbrechen oder einzustellen. Die Scenic Swisscoast GmbH haf-tet dem Kunden gegen�ber nicht f�r die �nderung, Unterbrechung oder Einstellung des Dienstes.
//
// -----------------------------
//11.	Links:
// -----------------------------
//Auf den Internetseiten von innovationfilmfestival.ch kann die Scenic Swisscoast GmbH Links zu anderen, frem-den Internetseiten oder fremden Quellen erstellen. Die Scenic Swisscoast GmbH hat hinsichtlich dieser Inter-netseiten oder Quellen keine Kontrollm�glichkeiten in Bezug auf Verf�gbarkeit oder Inhalt. Aus diesem Grunde ist die Scenic Swisscoast GmbH f�r den Inhalt solcher Internetseiten oder Quellen nicht verantwortlich.
//
// -----------------------------
//12.	Anzuwendendes Recht, Gerichtsstand:
// -----------------------------
//Bei Streitf�llen findet das schweizerische Recht Anwendung. Als Gerichtsstand wird Thun vereinbart.
//
//
//
//
//
//


// ----------------------------------------------------------------------------
// Safe maths
// ----------------------------------------------------------------------------
contract SafeMath {
    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function safeMul(uint a, uint b) public pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function safeDiv(uint a, uint b) public pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}


// ----------------------------------------------------------------------------
// ERC Token Standard #20 Interface
// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
// ----------------------------------------------------------------------------
contract ERC20Interface {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}


// ----------------------------------------------------------------------------
// Contract function to receive approval and execute function in one call
//
// Borrowed from MiniMeToken
// ----------------------------------------------------------------------------
contract ApproveAndCallFallBack {
    function receiveApproval(address from, uint256 tokens, address token, bytes data) public;
}


// ----------------------------------------------------------------------------
// Owned contract
// ----------------------------------------------------------------------------
contract Owned {
    address public owner;
    address public newOwner;

    event OwnershipTransferred(address indexed _from, address indexed _to);

    function Owned() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        newOwner = _newOwner;
    }
    function acceptOwnership() public {
        require(msg.sender == newOwner);
        OwnershipTransferred(owner, newOwner);
        owner = newOwner;
        newOwner = address(0);
    }
}


// ----------------------------------------------------------------------------
// ERC20 Token, with the addition of symbol, name and decimals and assisted
// token transfers
// ----------------------------------------------------------------------------
contract dCHF is ERC20Interface, Owned, SafeMath {
    string public symbol;
    string public  name;
    uint8 public decimals;
    uint public _totalSupply;

    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;


    // ------------------------------------------------------------------------
    // Constructor
    // ------------------------------------------------------------------------
    function dCHF() public {
        symbol = "dCHF";
        name = "private digitale Schweizer Franken - private digital Swiss Franc";
        decimals = 2;
        _totalSupply = 1500000;
        balances[0x0000F70bC78af03f14132c68b59153E4788bAb20] = _totalSupply;
        Transfer(address(0),0x0000F70bC78af03f14132c68b59153E4788bAb20 , _totalSupply);
    }


    // ------------------------------------------------------------------------
    // Total supply
    // ------------------------------------------------------------------------
    function totalSupply() public constant returns (uint) {
        return _totalSupply  - balances[address(0)];
    }


    // ------------------------------------------------------------------------
    // Get the token balance for account tokenOwner
    // ------------------------------------------------------------------------
    function balanceOf(address tokenOwner) public constant returns (uint balance) {
        return balances[tokenOwner];
    }


    // ------------------------------------------------------------------------
    // Transfer the balance from token owner's account to to account
    // - Owner's account must have sufficient balance to transfer
    // - 0 value transfers are allowed
    // ------------------------------------------------------------------------
    function transfer(address to, uint tokens) public returns (bool success) {
        balances[msg.sender] = safeSub(balances[msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        Transfer(msg.sender, to, tokens);
        return true;
    }


    // ------------------------------------------------------------------------
    // Token owner can approve for spender to transferFrom(...) tokens
    // from the token owner's account
    //
    // https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
    // recommends that there are no checks for the approval double-spend attack
    // as this should be implemented in user interfaces 
    // ------------------------------------------------------------------------
    function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        Approval(msg.sender, spender, tokens);
        return true;
    }


    // ------------------------------------------------------------------------
    // Transfer tokens from the from account to the to account
    // 
    // The calling account must already have sufficient tokens approve(...)-d
    // for spending from the from account and
    // - From account must have sufficient balance to transfer
    // - Spender must have sufficient allowance to transfer
    // - 0 value transfers are allowed
    // ------------------------------------------------------------------------
    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        balances[from] = safeSub(balances[from], tokens);
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        Transfer(from, to, tokens);
        return true;
    }


    // ------------------------------------------------------------------------
    // Returns the amount of tokens approved by the owner that can be
    // transferred to the spender's account
    // ------------------------------------------------------------------------
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }


    // ------------------------------------------------------------------------
    // Token owner can approve for spender to transferFrom(...) tokens
    // from the token owner's account. The spender contract function
    // receiveApproval(...) is then executed
    // ------------------------------------------------------------------------
    function approveAndCall(address spender, uint tokens, bytes data) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        Approval(msg.sender, spender, tokens);
        ApproveAndCallFallBack(spender).receiveApproval(msg.sender, tokens, this, data);
        return true;
    }


    // ------------------------------------------------------------------------
    // Don't accept ETH
    // ------------------------------------------------------------------------
    function () public payable {
        revert();
    }


    // ------------------------------------------------------------------------
    // Owner can transfer out any accidentally sent ERC20 tokens
    // ------------------------------------------------------------------------
    function transferAnyERC20Token(address tokenAddress, uint tokens) public onlyOwner returns (bool success) {
        return ERC20Interface(tokenAddress).transfer(owner, tokens);
    }
}