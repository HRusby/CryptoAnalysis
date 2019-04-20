#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sqlite3
from sqlite3 import Error

class CurrencyData:

    def __init__(self):
        self.connection = self.create_connection('Database/crypto.db')

    def create_connection(self, db_file):
        try:
            conn = sqlite3.connect(db_file)
            return conn
        except Error as e:
            print(e)
        return None

    def CurrencyIsPreexisting(self, symbol):
        cursor = self.connection.cursor()
        cursor.execute(
            "SELECT * FROM Currency WHERE CurrencySymbol = ?",
            (symbol,)
        )
        data=cursor.fetchone()
        if data is None:
            return False
        else:
            return True

    def GetCurrencyId(self, symbol):
        cursor = self.connection.cursor()
        cursor.execute("SELECT CurrencyId FROM CURRENCY WHERE CurrencySymbol = ?".
        symbol)
        data = cursor.fetchone()
        return data

    def CreateCurrencyProperties(self, dataObject):
        cursor = self.connection.cursor()
        if(self.CurrencyIsPreexisting(dataObject.Symbol)): # Update Existing Currency
            print('Updating')
            cursor.execute("""
                UPDATE CURRENCY SET (TotalSupply = ?, IsTrading = ?)
                WHERE CurrencySymbol = ?
            """,
            (dataObject.TotalSupply,
            dataObject.IsTrading,
            symbol))
        else: # Create Currency
            print('Inserting')
            cursor.execute("""
            INSERT INTO CURRENCY
            (CurrencySymbol, CurrencyName, TotalSupply, IsTrading)
            VALUES (?,?,?,?)
            """,
            (dataObject.Symbol,
            dataObject.Name,
            dataObject.TotalSupply,
            dataObject.IsTrading))
        return

    def commitAndClose(self):
        self.connection.commit()
        self.connection.close()
        return
