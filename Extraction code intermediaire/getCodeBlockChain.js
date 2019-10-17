var Web3 = require('web3')
var url = 'https://mainnet.infura.io/v3/561105aae7554a15931df35a7e1500d7'
var web3 = new Web3(url)

var contracts =[
['1-Bytes32Lib','0x0fcf5a3884585e14fd2d8d131def18f598dfcc2b'],
['2-NePay','0x1f0480a66883de97d2b054929252aae8f664c15c'],
['3-SafeMathLibExt','0x2F78032912eF59a990264C4C06937dA4dBF550FD'],
['4-EC','0x005aae78c0de67642c728504dc9d264ecb9bb312'],
['5-AirDrop','0x20e2bf0fc47e65a3caa5e8e17c5cd730cc556db9'],
['6-EthTranchePricing','0x37a2e0cdcc3dec87042dedfd32daca45d2089ecd'],
['7-ChickenFarm','0x246a3CC8430909cB9b4ea2C55064045096656792'],
['8-Crowdsale','0x2029f1376726e9b1e59a9eb0c40656f1949e6684'],
['9-lockEtherPay','0x38383c8ef701938d52b98cbc818d923b38473f6d'],
['10-BarterCoin','0x3989167193214886330c3e4b5535428e168cf6bd'],
['11-NeobitTokens','0x4fe3c4e0c8fcf9ef23b1391cad0205b3e338e013'],
['12-LightYears','0x6a3d166e417f578c6fa6581e529fd407be0f76df'],
['13-DonationWallet','0x7a078d85ff5fb35e2595345c0a96a111f4c793f7'],
['14-COSHATokenCNY','0x44d2ff4a96ba416554951f28d239cad0abd2800d'],
['15-RequestBitcoinNodesValidation','0x60fc18f243656532fce2265a5278d95cb3afa034'],
['16-SetherToken','0x78b039921e84e726eb72e7b1212bb35504c645ca'],
['17-NVISIONCASH','0x643e7c00f3e3e67a635cfbbea615fba047af4f42'],
['18-GdprCrowdsale','0x6102a380791a5edfb04bb3e18ea15812a5b82e71'],
['19-ExploreCoin','0x78219a78b338ee760dff8d1f3e086ceb028a7aa5'],
['20-Anaco_Airdrop','0x791107901275227069ae882990a5aaff51cd658a'],
['21-OneMonthLockup','0x8f45471d4a900f91996871fbfbc2e1d076d936c0'],
['22-BancorMarketMaker','0x9fa14ed09da35b21a764e7c7f7724c70a26b6bfb'],
['23-CAVAsset','0x96b2cd70523aefe92e1cb56de72856ea30498547'],
['24-EtherScrolls','0x992d6d699d3f7c627a9be1a5f6020a05ecb86200'],
['25-MyAdvancedToken','0x8912358D977e123b51EcAd1fFA0cC4A7e32FF774'],
['26-AuctusPreSaleDistribution','0xa39ca2768a7b76aa3bcab68c4d4debf9a32c5434'],
['27-CGCGToken','0xaa561f3baafda7336d6830e5de58dc32f176f661'],
['28-GodviewChain','0xb3bc2C53a02B7c09a2A4957B195B202585138fb4'],
['29-LoopringProtocolImpl','0xb1170de31c7f72ab62535862c97f5209e356991b'],
['30-PixoArenaFounderToken','0xbdd021489de3f083e5aaa2d8cb6ba62db2902485'],
['31-KYC','0xc9e8045616abbdf535fda1fdbfe04b4f42101b2e'],
['32-YeedToken','0xca2796f9f61dc7b238aab043971e49c6164df375'],
['33-EtherGames','0xd2cbca4449adb54ecddb3a65faf204b5e1790c3e'],
['34-Lottery','0xd834bED9042c2004493f8c8f28C5AaAAb1f36780'],
['35-MetabaseCrowdSale','0xde0e95cd7572537842045e9d0051a2c3923794c8'],
['36-Tripy','0xe29cd51e9c816181bd51d1ab781c3556205d44ff'],
['37-BarrelAgedFOMO','0xeac97639bd994496c974040536f4e99cbd9d692e'],
['38-MEMESCrowdsale','0xf2cff4826bf8656173084e86ade7b65bf9aeef5b'],
['39-PlaakPreSale','0xf902b3a6daee738ef7d165d8d38a7edb1336fbfe'],
['40-Lottery2','0xffff0031d8768861b3172a7c7dc7d91b646f53db'],
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
        var path = '/mnt/c/Users/hong_/Google Drive/UdeS Génie Logiciel/Essai/Python/json/'
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