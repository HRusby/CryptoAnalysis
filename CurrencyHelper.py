#!/usr/bin/env python
# -*- coding: utf-8 -*-
import Database.CurrencyDbAccess as cDb
import urllib.request as request
import json
import CurrencyClasses as cc

def GetCurrentPrices():
    conn = db.create_connection('Database/crypto.db')
    db.SelectShortNames(conn)


def GetAllCurrencies(): # Returns Success and Any Message
    contents = request.urlopen("https://min-api.cryptocompare.com/data/all/coinlist").read()
    currencyJSON = json.loads(contents)
    responseStatus = currencyJSON['Response']
    responseMessage =  currencyJSON['Message']
    if( responseStatus != "Success"):
        return responseStatus, responseMessage # Return error status and message
    responseData = currencyJSON['Data']
    for key, value in responseData.items():
        initCurrency = cc.CurrencyProperties(value)
        CurrencyDataObject = cDb.CurrencyData()
        CurrencyDataObject.CreateCurrencyProperties(initCurrency)
        CurrencyDataObject.commitAndClose()
    return
    # Get HTMl Response
    # Parse as JSON
    # foreach  if exists in db, update else create
