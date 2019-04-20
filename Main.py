#!/usr/bin/env python
# -*- coding: utf-8 -*-
import CurrencyHelper


def SelectModuleOption():
    print('Select a Module from the Options Below:\n')
    print('1. Current Currency Prices')
    print('2. Portfolio')
    print('3. Analysis')
    print('4. Get All Currencies')
    choice = input()
    if(choice == '1'):
        CurrencyHelper.GetCurrentPrices()
    elif(choice == '4'):
        print(CurrencyHelper.GetAllCurrencies())


def GetContinue():
    print('Do you want to enter another module? y/n\n')
    if(input() == 'y'):
        return True
    else:
        return False

def main():
    runProgram = True
    while(runProgram):
        SelectModuleOption()
        runProgram = GetContinue()

main()
