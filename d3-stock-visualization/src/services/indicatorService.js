/**
 * Technical indicator calculation service
 */
const indicatorService = {
  /**
   * Calculate Simple Moving Average (SMA)
   * @param {Array} data - Stock data
   * @param {number} period - Period for SMA
   * @param {string} field - Field to calculate on (default: 'close')
   * @returns {Array} Data with SMA values
   */
  calculateSMA: (data, period, field = 'close') => {
    return data.map((point, idx) => {
      if (idx < period - 1) return {...point, sma: null};
      
      const sum = data.slice(idx - period + 1, idx + 1)
        .reduce((total, item) => total + item[field], 0);
      
      return {...point, sma: sum / period};
    });
  },
  
  /**
   * Calculate Exponential Moving Average (EMA)
   * @param {Array} data - Stock data
   * @param {number} period - Period for EMA
   * @param {string} field - Field to calculate on (default: 'close')
   * @returns {Array} Data with EMA values
   */
  calculateEMA: (data, period, field = 'close') => {
    const k = 2 / (period + 1);
    return data.reduce((result, point, idx) => {
      if (idx === 0) {
        return [{...point, ema: point[field]}];
      }
      
      const prevEMA = result[idx - 1].ema;
      const ema = point[field] * k + prevEMA * (1 - k);
      return [...result, {...point, ema}];
    }, []);
  },
  
  /**
   * Calculate Relative Strength Index (RSI)
   * @param {Array} data - Stock data
   * @param {number} period - Period for RSI (default: 14)
   * @returns {Array} Data with RSI values
   */
  calculateRSI: (data, period = 14) => {
    return data.map((point, idx) => {
      if (idx < period) return {...point, rsi: null};
      
      let gains = 0;
      let losses = 0;
      
      for (let i = idx - period + 1; i <= idx; i++) {
        const change = data[i].close - data[i - 1].close;
        if (change >= 0) {
          gains += change;
        } else {
          losses -= change;
        }
      }
      
      const avgGain = gains / period;
      const avgLoss = losses / period;
      const rs = avgLoss === 0 ? Infinity : avgGain / avgLoss;
      
      return {...point, rsi: 100 - (100 / (1 + rs))};
    });
  },
  
  // Add more indicator methods as needed...
};

export default indicatorService;
