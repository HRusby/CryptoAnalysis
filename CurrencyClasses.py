class CurrencyProperties:
     def __init__(self, data):
         self.Symbol = data['Symbol']
         self.Name = data['CoinName']
         self.TotalSupply = data['TotalCoinSupply']
         self.IsTrading = data['IsTrading']

class UpdateCurrency:
    def __init__(self, data):
        self.Price = data['price']
