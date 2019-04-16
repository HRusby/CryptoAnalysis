CREATE TABLE CURRENCY_IDENTITY (
  CurrencyId Integer, -- Identifier
  CurrencyShortName VarChar, -- Currency Market ShortName (e.g. BTC) -- INDEXED
  CurrencyName VarChar, -- Currency Full Name (e.g. BitCoin) -- INDEXED
  CurrencyValue Double Precision, -- Current Value
  Trend Integer, -- Current Trend as per Trend_Identity -- INDEXED
  Volatility Integer -- Current Volatility as per VOLATILITY_IDENTITY
);

CREATE TABLE CURRENCY_HISTORY (
  HistoryId Integer, -- Identifier
  CurrencyId Integer, -- Currency Identity - Foreign Key -- INDEXED
  TmStamp DateTime, -- Time Taken
  Value Double Precision, -- Value at the point in time stored
  %Change Double Precision, -- % Change from last store
  Volatility Integer -- Volatility at the point in time calculated (As per VOLATILITY_IDENTITY)
);

CREATE TABLE TREND_IDENTITY (
  TrendId Integer, -- Identifier
  TrendDescriptor Varchar, -- Human Readable Format
  TrendThreshold Integer -- Lower Bound for current Trend
);
-- Sharp Increase, Steady Increase, Marginal Increase,
-- Consistent,
-- Marginal Decrease, Steady Decrease, Sharp Decrease

CREATE TABLE VOLATILITY_IDENTITY(
  VolatilityId Integer, -- Identifier
  Descriptor Varchar, -- Human Readable Format
  MinChangePerDay Double, -- Minimum % value change per day for this classification
  MinDaysToClassify Integer -- Minimum days with the MinChangePerDay to fit this classification
);
-- Steady, Weakenening, Unstable, Fluctuating, Volatile

CREATE TABLE USER (
  UserId Integer, -- Identifier
  Username Varchar, -- Login Username -- INDEXED
  HashedPassword Varchar, -- Hashed password Via chosen hashing algorithm
  DateCreated DateTime, -- Date User profile created
  PortfolioId Integer -- ID of User portfolio
);

CREATE TABLE PORTFOLIO_OVERVIEW(
  PortfolioId Integer, -- Portfolio Identifier
  UserId Integer, -- User Associated
  Current#Currencies Integer, -- Total Number of Currencies invested in
  TotalInvestment Double Precision, -- Total Investiture
  NetProfit Double Precision -- Net gain/loss
);
