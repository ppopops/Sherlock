#!/usr/bin/env python3
import sys
import json
from mythril.laser.ethereum import svm 
from mythril.solidity.soliditycontract import SolidityContract
from mythril.ethereum.evmcontract import EVMContract
from mythril.analysis import solver
from mythril.exceptions import UnsatError
from mythril.disassembler.disassembly import Disassembly
from tabulate import tabulate
import time
from z3  import * 

# ---------------------------------------------------------------------------------------
# Paramètres Solveur Z3
# ---------------------------------------------------------------------------------------
z3.set_param('model_compress', False)

# ---------------------------------------------------------------------------------------
# Paramètres fichier de sortie pour résultats
# ---------------------------------------------------------------------------------------
#outputPath = "Output/test/"
outputPath = "Output/"


# ---------------------------------------------------------------------------------------
# Paramètres pour Laser EVM
# ---------------------------------------------------------------------------------------
transactionCount = 1
executionTimeOut = 600
createTimeOut = 100
#maxDept = float("inf")   # infini
maxDept = 20


# ---------------------------------------------------------------------------------------
# Fonction pour recevoir l'addresse un programme Solidity. Effectue le désassemblable 
# programme avant l'analyse
# ---------------------------------------------------------------------------------------
def AnalyseSherlockSolidity (nameContract, addressContract, locationContract):

    startTime = time.time() # pour calculer temps exécution

    accounts = {}
    contractAddress = addressContract
    contractName = nameContract
    contract = SolidityContract(locationContract ) 

    account = svm.Account(contractAddress, contract.disassembly)
    accounts = {contractAddress: account}

    laser = svm.LaserEVM(accounts, max_depth = maxDept, execution_timeout = executionTimeOut, create_timeout = createTimeOut, transaction_count=transactionCount)
    ExecutionSymbolique(laser,contractAddress, contractName,startTime)
    
# ---------------------------------------------------------------------------------------
# Fonction pour recevoir le code intermédiaire d'un contrat intelligent.
#
# ---------------------------------------------------------------------------------------
def AnalyseSherlockJson (fileAddress):
    
    startTime = time.time() # pour calculer temps exécution

    accounts = {}
    contractAddress = ""
    contractName = ""
    firstContract = True

    with open(fileAddress) as json_file:  
        data = json.load(json_file)
        #print (data)
        for p in data['contract']:
            contract = EVMContract(code = p['contractBytecode'], name = p['contractName'])
            address = p['contractAddress']
            account = svm.Account(address, contract.disassembly)
            accounts[address] = account
            if firstContract == True :
                contractAddress = p['contractAddress']
                contractName = p['contractName']
                firstContract = False
            print('contract name: ' + p['contractName'])
            print('contract address: ' + p['contractAddress'])
            #print('contract bytecote: ' + p['contractBytecode'])
            print('')

    
    laser = svm.LaserEVM(accounts, max_depth = maxDept, execution_timeout = executionTimeOut, create_timeout = createTimeOut, transaction_count=transactionCount)
    ExecutionSymbolique(laser,contractAddress, contractName,startTime)

# ---------------------------------------------------------------------------------------
# Exécute l'analyse symbolique du programme reçu en entrée
#
# ---------------------------------------------------------------------------------------
def ExecutionSymbolique(laser,contractAddress, contractName,startTime):
    laser.sym_exec(contractAddress)

    #Listes contenant les resultats de l'analyse
    resultList = []
    volEssenceFunction = []
    appelAutreContrat = []

    for k in laser.nodes:
        for state in laser.nodes[k].states:
            #Détection des instructions indiquant la fin d'un chemin
            if (state.get_current_instruction()['opcode'] == 'STOP' or 
                state.get_current_instruction()['opcode'] == 'RETURN' or 
                state.get_current_instruction()['opcode'] == 'REVERT' or 
                state.get_current_instruction()['opcode'] == 'SUICIDE' or 
                state.get_current_instruction()['opcode'] == 'ASSERT_FAIL' or 
                state.get_current_instruction()['opcode'] == 'CALL' or 
                state.get_current_instruction()['opcode'] == 'CALLCODE' or 
                state.get_current_instruction()['opcode'] == 'DELEGATECALL' or 
                state.get_current_instruction()['opcode'] == 'STATICCALL' or 
                (state.get_current_instruction()['opcode'] == 'JUMP' and state.mstate.stack[-1] == 0) ): 

                volEssenceList = []
                proposition = laser.nodes[k].constraints
                proposition_list = laser.nodes[k].constraints.as_list   
                solvable = False
                valeursProposition = ''
                nomFonction = ''
                transaction = '' 

                #détection des jump invalide et des appels
                if (state.get_current_instruction()['opcode'] == 'JUMP') :
                    volEssenceList.append('Jump invalide')
                if (state.get_current_instruction()['opcode'] == 'ASSERT_FAIL') :
                    volEssenceList.append('Instruction Invalide ')
                if (state.get_current_instruction()['opcode'] == 'CALL') :
                    appelAutreContrat.append('CALL detecte ') 
                if (state.get_current_instruction()['opcode'] == 'CALLCODE') :
                    appelAutreContrat.append('CALLCODE detecte ') 
                if (state.get_current_instruction()['opcode'] == 'DELEGATECALL') :
                    appelAutreContrat.append('DELEGATECALL detecte ')
                if (state.get_current_instruction()['opcode'] == 'STATICCALL') :
                    appelAutreContrat.append('STATICCALL detecte ')

                #détection des cas de vol d'essences
                for s in proposition_list :
                    if ( 'coinbase' in str(s)) :
                        volEssenceList.append('Coinbase ')
                    if ( 'block_difficulty' in str(s)) :
                        volEssenceList.append('BlockDifficulty ')
                    if ( 'blockhash' in str(s)) :
                        volEssenceList.append('BlockHash ')
                    if ( 'block_number' in str(s)) :
                        volEssenceList.append('BlockNumber ')
                    if ( 'timestamp' in str(s)) :
                        volEssenceList.append('Time ')
                    #if ( 'gasprice' in str(s)) :
                        #volEssence = volEssence + 'GasPrice '
                        #volEssenceList.append('GasPrice')

                # Appel au Solveur Z3 pour voir si la propostion peut être résolue
                # Détermination du code hash de la fonction appelée et des valeurs des propositions
                try:    
                    transaction = solver.get_transaction_sequence(state, proposition)
                    #import pdb; pdb.set_trace()
                    model = solver.get_model(constraints = proposition, enforce_execution_time=False) 
                    for    d in model.decls():
                        if (type(model[d]) == z3.z3.FuncInterp) :
                            numberElement = model[d].num_entries()
                            l1 =[]
                            l2 = []
                            for x in range (0, numberElement) :
                                l1.append(model[d].entry(x).as_list())

                            l1Sorted = sorted(l1,key=lambda l:l[0].as_long(), reverse=False)

                            for x in l1Sorted :
                                l2.append(x[1].as_long())

                            r = ''.join('%02x'%i for i in l2)
                            s = r[0:8]

                            if (str(s) != '01010101') :
                                nomFonction = str(s)
                            else :
                                nomFonction = 'fallback'
                            
                            if 'k!' not in str(d.name()) :
                                valeursProposition = valeursProposition + str(d.name()) + ' = ' +  str(s) + '<br>'
                        else :
                            if 'k!' not in str(d.name()) :
                                valeursProposition = valeursProposition + str(d.name()) + ' = ' + str(model[d]) + '<br>'
                    solvable = True
                except UnsatError:
                    transaction = {}
                    print("UnsatError")
                    solvable = False

                resultState = [nomFonction,str(k),str(state.get_current_instruction()['opcode']),str(state.get_current_instruction()['address']),str(state.mstate.as_dict['pc']),str(state.mstate.as_dict['min_gas_used']),str(state.mstate.as_dict['max_gas_used']), volEssenceList, str(solvable),valeursProposition + '<br>' + '<br>',str(laser.nodes[k].constraints.as_list) + '<br>'+ '<br>',transaction,len(transaction)]
                resultList.append(resultState)

                if (len(volEssenceList) > 0) :
                    volEssenceFunction.append(nomFonction)

    elapsedTime = time.time() - startTime
                
    #Impression des résultats
    printOutput(resultList,volEssenceFunction, appelAutreContrat,contractName,elapsedTime)
    
# ---------------------------------------------------------------------------------------
# Impression des résultats
# - Version longue dans un fichier HTML (comprend version courte également)
# - Version courte dans la console
# ---------------------------------------------------------------------------------------
def printOutput(resultList,volEssenceFunction, appelAutreContrat,contractName,elapsedTime):

    nomFichierSortie = outputPath + contractName + ".html"

    #Impression de la version longue dans un fichier HTML
    print(tabulate(resultList,     headers=['Fonction','Node', 'Instruction', 'Instruction Address', 'Program Counter', 'Minimum Gas Used', 'Maximum Gas Used', 'volEssence', 'Solvable', 'Valeurs', 'Constraint', 'Transaction', 'number transaction'],tablefmt ='html'), file=open(outputPath + contractName + ".html", "a"))

    #Enlever doublons dans les fonctions de vol d'essence
    volEssenceFunctionNoDup = list(set(volEssenceFunction))

    # Regroupement des vols d'essence par fonction. La version courte est également imprimée dans la fichier HTML.
    if (len(volEssenceFunctionNoDup) > 0) :
        print("Bifurcations frauduleuses dans les fonctions ci-dessous dans le contrat " + contractName, file=open(nomFichierSortie, "a")) 
        print("Bifurcations frauduleuses dans les fonctions ci-dessous dans le contrat " + contractName)
        for x in volEssenceFunctionNoDup :
            print('Fonction: ' + x )
            print('Fonction: ' + x + '<br>', file=open(outputPath + contractName  + ".html", "a"))
            nombreChemin = 0 
            essenceMinimale = 0
            essenceMaximale = 0
            for y in resultList :
                if y[0] == x :
                    if (nombreChemin == 0 ) :
                        essenceMinimale = int(y[6])
                        essenceMaximale = int(y[6])
                    else :
                        if ( int(y[6]) > essenceMaximale ) :
                            essenceMaximale = int(y[6])
                        if ( int(y[6]) < essenceMinimale  ) :
                            essenceMinimale = int(y[6])
                    nombreChemin = nombreChemin + 1
                    # Si type de vol existant, imprimer type de vol
                    if (len(y[7]) > 0):
                        print ( '   Instruction: ' + y[2] + ' Solvable: '+ y[8] +  ' Essence Maximum: '+ y[6] + ' Type Vol: ' +  ''.join(y[7]) )
                        print ( '   Instruction: ' + y[2] + ' Solvable: '+ y[8] + ' Essence minimum: ' + y[5] + ' Essence Maximum: '+ y[6] + ' Type Vol: ' +  ''.join(y[7])+ '<br>', file=open(nomFichierSortie, "a"))
                    else :
                        print ( '   Instruction: ' + y[2] + ' Solvable: '+ y[8] + ' Essence Maximum: '+ y[6] )
                        print ( '   Instruction: ' + y[2] + ' Solvable: '+ y[8] + ' Essence minimum: ' + y[5] + ' Essence Maximum: '+ y[6] + '<br>', file=open(nomFichierSortie, "a"))
            print(' Nombre total de chemins: ' + str(nombreChemin) + '\n'   + '   Essence Minimale: ' + str(essenceMinimale) + '\n'  + '   Essence Maximale: ' + str(essenceMaximale) + '\n')
            print(' Nombre total de chemins: ' + str(nombreChemin) + '<br>' + '   Essence Minimale: ' + str(essenceMinimale) + '<br>'+ '   Essence Maximale: ' + str(essenceMaximale) + '<br>'+ '<br>', file=open(nomFichierSortie, "a"))
    else : 
        print("Aucun vol d'essences détecté dans le contrat " + contractName, file=open(nomFichierSortie, "a")) 
        print("Aucun vol d'essences détecté dans le contrat " + contractName)

    if (len(appelAutreContrat) > 0) :
        for y in appelAutreContrat :
            print('Appels autre contract:  ' + y )
            print('Appels autre contract:  ' + y + '<br>', file=open(nomFichierSortie, "a"))
    
    print("Temps execution: " + str(elapsedTime), file=open(nomFichierSortie, "a"))
    print("Temps execution: " + str(elapsedTime))

    print("Analyse terminée")
    print("----------------------------------------------------------------------------")
    print("")
    startTime = time.time() 
