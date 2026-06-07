# Bitcoin Egan Trader
RSI(14) + EMA(9) + WMA(45) signal analyzer cho Bitcoin

## Setup
```bash
pip install -r requirements.txt
```

## Usage
```bash
# Phân tích tín hiệu hiện tại (4h)
python analyze.py --symbol BTCUSDT --timeframe 4h --mode signal

# Backtest 500 nến
python analyze.py --symbol BTCUSDT --timeframe 4h --mode backtest

# Alert mode (chỉ hiện khi có tín hiệu)
python analyze.py --symbol BTCUSDT --timeframe 1h --mode alert

# Daily trend check
python analyze.py --symbol BTCUSDT --timeframe 1d --mode signal

# JSON output (để tích hợp với agent)
python analyze.py --symbol BTCUSDT --timeframe 4h --mode json
```

## Methodology
- RSI(14): Wilder's RSI trên giá close
- EMA(9): Applied to RSI line
- WMA(45): Applied to RSI line
- BUY: RSI <= 25 + EMA cross up + bullish divergence
- SELL: RSI >= 75 + EMA cross down + bearish divergence
