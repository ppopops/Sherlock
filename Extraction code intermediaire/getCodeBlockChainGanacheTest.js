var Web3 = require('web3')
//var url = 'https://mainnet.infura.io/v3/561105aae7554a15931df35a7e1500d7'
var url = 'http://127.0.0.1:7545'
var web3 = new Web3(url)

var contracts =[
['1-VolEssenceBlockHashBlockChainGanache','0xe418CeEa4cDfA6fda84E7731a3e681DeE0D6c94A'],
['2-PasVolEssenceBlockHashBlockChainGanache','0xeE486dd61991fB05C4E9ab07bE0CBe6236B64be1'],
['3-VolEssenceBlockTimeBlockChainGanache','0x085d1a3556d0f270C6caD0aA427B4c468D982DEc'],
['4-PasVolEssenceBlockTimeBlockChainGanache','0x792A6a0Ece0408d8F999ab2DdBF94372b09c49cd'],
['5-VolEssenceBlockDifficultyBlockChainGanache','0x2D039B964ae5641C6F973a663b00Ff5a0EC80b4A'],
['6-PasVolEssenceBlockDifficultyBlockChainGanache','0x80755c786501E7163136371Bf98337C8688598cB'],
['7-VolEssenceBlockNumberBlockChainGanache','0x684F71Afe56Ec00b70d952Ad64F7b4Fe06E05E4f'],
['8-PasVolEssenceBlockNumberBlockChainGanache','0x786235D934275C79E269fc6Ff111a6db5546d62f'],
['9-VolEssenceBlockCoinbaseBlockChainGanache','0xe673ee1A993D155D852b0d03AAC1F33BBe0E0e35'],
['10-PasVolEssenceBlockCoinbaseBlockChainGanache','0x0511161C0C4B73F7e4d2FE519a8F943300b03FF8'],
['11-PasVolEssenceGasPriceBlockChainGanache','0xDe870AeB855226d1fB47e0f572111A2C83DEd24E'],
['12-VolEssenceBlockDifficulty1BlockChainGanache','0x0B17E0b500F9F40487Ab8bFc5477696195E7D751'],
['13-VolEssenceBlockHashBlockChainGanache1','0x7BA445fd16631D0278c5D3aAe527340B0cBDEc8b'],
['14-VolEssenceBlockHashCallBlockChainGanache','0x4B5228C226a030b227B9600760bc53D1a5C976F9'],
['15-VolEssenceBlockHashPlusGasBlockChainGanache','0x23525BDd8051C6a2FFb3b33Fb85756990Df2455D'],
/* //use with truffle 0409
['16-VolEssenceThrowBlockChainGanache','0xe418CeEa4cDfA6fda84E7731a3e681DeE0D6c94A'],
*/
];
//console.log(contracts.length);

//getCode('1-Bytes32LibBC','0x0fcf5a3884585e14fd2d8d131def18f598dfcc2b')

for (var x in contracts){
    getCode(contracts[x][0],contracts[x][1]);
}

function getCode(name, address) {

    var code = web3.eth.getCode(address);
    
    code.then(function(result){
        //console.log(result)
        var contractobj = new Object();
        contractobj.contractName = name;
        contractobj.contractBytecode  = result;
        contractobj.contractAddress  = "0x0000000000000000000000000000000000000000";
    
        var obj = new Object();
        obj.contract = [contractobj];
    
        var jsonString= JSON.stringify(obj, null , 4);
        //console.log(jsonString)
        var fs = require('fs');
        //var path = 'C:\\Users\\hong_\\Google Drive\\UdeS Génie Logiciel\\Essai\\Python\\json\\'
        var path = '/mnt/c/Users/hong_/Google Drive/UdeS Génie Logiciel/Essai/Python/json/test/'
        fs.writeFile(path + name + '.json', jsonString, 'utf8', function(error){
            console.log(error)
        });
    })
    //outputPath = "/mnt/c/Users/hong_/Google Drive/UdeS Génie Logiciel/Essai/Python/Output/"
}
/*
var code = web3.eth.getCode("0x1f0480a66883de97d2b054929252aae8f664c15c");
code.then(function(result){
    //console.log(result)
    var obj = new Object();
    obj.contractName = "contract1";
    obj.contractBytecode  = result;
    obj.contractAddress  = "0x0000000000000000000000000000000000000000";

    var obj2 = new Object();
    obj2.contract = [obj];

    var jsonString= JSON.stringify(obj2, null , 4);
    //console.log(jsonString)
    var fs = require('fs');
    fs.writeFile('myjsonfile.json', jsonString, 'utf8', function(q){});
})

 for (var x in contracts)
 */
//console.log(code);