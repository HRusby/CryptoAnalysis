CREATE TABLE CURRENCY (
  CurrencyId Integer PRIMARY KEY, -- Identifier
  CurrencyShortName VarChar NOT NULL UNIQUE, -- Currency Market ShortName (e.g. BTC) -- INDEXED
  CurrencyName VarChar NOT NULL UNIQUE, -- Currency Full Name (e.g. BitCoin) -- INDEXED
  CurrencyValue Double Precision, -- Current Value
  Trend Integer, -- Current Trend as per Trend_Identity -- INDEXED
  Volatility Integer, -- Current Volatility as per VOLATILITY_IDENTITY
  PatternShort Integer, -- ShortTerm Pattern (Weekly)
  PatternMedium Integer, -- MidTerm Pattern (Monthly)
  PatternLong Integer, -- Long Term Pattern (Yearly)
  PatternHistoric Integer, -- Historic Pattern (All Time)
  FOREIGN KEY (Trend) REFERENCES TREND_IDENTITY(TrendId),
  FOREIGN KEY (Volatility) REFERENCES VOLATILITY_IDENTITY(VolatilityId),
  FOREIGN KEY (PatternShort) REFERENCES PATTERN_IDENTITY(PatternId),
  FOREIGN KEY (PatternMedium) REFERENCES PATTERN_IDENTITY(PatternId),
  FOREIGN KEY (PatternLong) REFERENCES PATTERN_IDENTITY(PatternId),
  FOREIGN KEY (PatternHistoric) REFERENCES PATTERN_IDENTITY(PatternId)
);

CREATE TABLE CURRENCY_HISTORY (
  HistoryId Integer PRIMARY KEY, -- Identifier
  CurrencyId Integer, -- Currency Identity - Foreign Key -- INDEXED
  TmStamp DateTime, -- Time Taken
  Value Double Precision, -- Value at the point in time stored
  %Change Double Precision, -- % Change from last store
  Volatility Integer, -- Volatility at the point in time calculated (As per VOLATILITY_IDENTITY)
  FOREIGN KEY(CurrencyId) REFERENCES CURRENCY_IDENTITY(CurrencyId),
  FOREIGN KEY(Volatility) REFERENCES VOLATILITY_IDENTITY(VolatilityId)
);

CREATE TABLE PATTERN_IDENTITY(
  PatternId Integer PRIMARY KEY, -- Identifier
  Name Varchar, -- Pattern Name
  Descriptor Varchar -- Natural Language Description of this pattern
);

CREATE TABLE TREND_IDENTITY (
  TrendId Integer PRIMARY KEY, -- Identifier
  TrendDescriptor Varchar, -- Human Readable Format
  TrendThreshold Integer -- Lower Bound for current Trend (-ve or positive)
);
-- Sharp Increase, Steady Increase, Marginal Increase,
-- Consistent,
-- Marginal Decrease, Steady Decrease, Sharp Decrease
INSERT INTO TREND_IDENTITY (TrendDescriptor, TrendThreshold) VALUES ('Sharp Increase', 5.0);
INSERT INTO TREND_IDENTITY (TrendDescriptor, TrendThreshold) VALUES ('Steady Increase', 2.5);
INSERT INTO TREND_IDENTITY (TrendDescriptor, TrendThreshold) VALUES ('Marginal Increase', 1.0);
INSERT INTO TREND_IDENTITY (TrendDescriptor, TrendThreshold) VALUES ('Consistent', 0.0);
INSERT INTO TREND_IDENTITY (TrendDescriptor, TrendThreshold) VALUES ('Marginal Decrease', -1.0);
INSERT INTO TREND_IDENTITY (TrendDescriptor, TrendThreshold) VALUES ('Steady Decrease', -2.5);
INSERT INTO TREND_IDENTITY (TrendDescriptor, TrendThreshold) VALUES ('Sharp Decrease', -5.0);

CREATE TABLE VOLATILITY_IDENTITY(
  VolatilityId Integer PRIMARY KEY, -- Identifier
  Descriptor Varchar, -- Human Readable Format
  MinChangePerDay Double, -- Minimum % value change per day for this classification
  MinDaysToClassify Integer -- Minimum days with the MinChangePerDay to fit this classification
);
-- Steady, Weakenening, Unstable, Fluctuating, Volatile
INSERT INTO VOLATILITY_IDENTITY (Descriptor, MinChangePerDay, MinDaysToClassify) VALUES ('Steady', 1, 10);
INSERT INTO VOLATILITY_IDENTITY (Descriptor, MinChangePerDay, MinDaysToClassify) VALUES ('Weakenening', 2, 8);
INSERT INTO VOLATILITY_IDENTITY (Descriptor, MinChangePerDay, MinDaysToClassify) VALUES ('Unstable', 5, 6);
INSERT INTO VOLATILITY_IDENTITY (Descriptor, MinChangePerDay, MinDaysToClassify) VALUES ('Fluctuating', 10, 4);
INSERT INTO VOLATILITY_IDENTITY (Descriptor, MinChangePerDay, MinDaysToClassify) VALUES ('Volatile', 20, 2);

CREATE TABLE USER (
  UserId Integer PRIMARY KEY, -- Identifier
  Username Varchar, -- Login Username -- INDEXED
  HashedPassword Varchar, -- Hashed password Via chosen hashing algorithm
  DateCreated DateTime, -- Date User profile created
  PortfolioId Integer, -- ID of User portfolio
  FOREIGN KEY (PortfolioId) REFERENCES PORTFOLIO_OVERVIEW(PortfolioId)
);

CREATE TABLE PORTFOLIO_OVERVIEW(
  PortfolioId Integer PRIMARY KEY, -- Portfolio Identifier
  UserId Integer, -- User Associated
  Current#Currencies Integer, -- Total Number of Currencies invested in
  TotalInvestment Double Precision, -- Total Investiture
  NetProfit Double Precision, -- Net gain/loss
  FOREIGN KEY (UserId) REFERENCES USER(UserId)
);

CREATE TABLE PORTFOLIO_LOGS(
  LogId Integer PRIMARY KEY, -- Log Identifier
  PortfolioId Integer, -- Foreign Key references associated portfolio
  Currency Integer, -- ForeignKey References CurrencyId
  Direction Varchar(3), -- True = In False = Out
  Amount Double Precision, -- Amount of currency bought
  Value Double Precision, -- Value of the amount bought
  FOREIGN KEY (PortfolioID) REFERENCES PORTFOLIO_OVERVIEW(PortfolioId),
  FOREIGN KEY (Currency) REFERENCES CURRENCY(CurrencyId),
  CONSTRAINT CHECK (Direction = 'BUY' OR Direction = 'SELL')
);
