#!/bin/bash

# 创建项目目录结构
create_d3_project() {
  # 创建根目录
  mkdir -p d3-stock-visualization
  
  # 创建public目录和文件
  mkdir -p d3-stock-visualization/public/assets/{images,fonts}
  touch d3-stock-visualization/public/index.html
  touch d3-stock-visualization/public/favicon.ico
  
  # 创建src目录
  mkdir -p d3-stock-visualization/src
  
  # 创建data相关目录
  mkdir -p d3-stock-visualization/src/data/{raw,processed,api}
  touch d3-stock-visualization/src/data/api/{api.js,mock.js}
  
  # 创建components目录
  mkdir -p d3-stock-visualization/src/components/{charts,ui,utils}
  
  # 创建图表组件文件
  touch d3-stock-visualization/src/components/charts/{CandlestickChart.js,VolumeChart.js,IndicatorChart.js,CompositeChart.js}
  
  # 创建UI组件文件
  touch d3-stock-visualization/src/components/ui/{Toolbar.js,Legend.js,Tooltip.js,Crosshair.js}
  
  # 创建工具组件文件
  touch d3-stock-visualization/src/components/utils/{Zoom.js,Brush.js,DateAxis.js}
  
  # 创建services目录和文件
  mkdir -p d3-stock-visualization/src/services
  touch d3-stock-visualization/src/services/{dataService.js,indicatorService.js,themeService.js}
  
  # 创建styles目录和文件
  mkdir -p d3-stock-visualization/src/styles
  touch d3-stock-visualization/src/styles/{main.scss,_variables.scss,_charts.scss,_ui.scss}
  
  # 创建utils目录和文件
  mkdir -p d3-stock-visualization/src/utils
  touch d3-stock-visualization/src/utils/{d3Helpers.js,formatters.js,constants.js}
  
  # 创建views目录和文件
  mkdir -p d3-stock-visualization/src/views
  touch d3-stock-visualization/src/views/{Dashboard.js,SingleStockView.js,ComparisonView.js}
  
  # 创建应用入口文件
  touch d3-stock-visualization/src/{App.js,index.js}
  
  # 创建tests目录
  mkdir -p d3-stock-visualization/tests/{unit,integration}
  
  # 创建配置文件
  touch d3-stock-visualization/{.gitignore,package.json,README.md,webpack.config.js,babel.config.js}
  
  # 填充基本内容
  fill_templates
}

# 填充基本内容
fill_templates() {
  # 填充.gitignore
  cat > d3-stock-visualization/.gitignore <<EOL
# Dependencies
node_modules/

# Build artifacts
dist/
build/

# Environment variables
.env

# Log files
*.log

# IDE files
.vscode/
.idea/

# System files
.DS_Store
EOL

  # 填充package.json
  cat > d3-stock-visualization/package.json <<EOL
{
  "name": "d3-stock-visualization",
  "version": "1.0.0",
  "description": "Interactive stock visualization using D3.js",
  "main": "src/index.js",
  "scripts": {
    "start": "webpack serve --config webpack.config.js --open",
    "build": "webpack --config webpack.config.js",
    "test": "jest"
  },
  "dependencies": {
    "d3": "^7.8.5"
  },
  "devDependencies": {
    "@babel/core": "^7.24.0",
    "@babel/preset-env": "^7.24.0",
    "babel-loader": "^9.1.3",
    "css-loader": "^6.8.1",
    "html-webpack-plugin": "^5.5.3",
    "jest": "^29.7.0",
    "sass": "^1.72.0",
    "sass-loader": "^14.0.0",
    "style-loader": "^3.3.3",
    "webpack": "^5.89.3",
    "webpack-cli": "^5.1.4",
    "webpack-dev-server": "^4.15.1"
  }
}
EOL

  # 填充index.html
  cat > d3-stock-visualization/public/index.html <<EOL
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>D3.js Stock Visualization</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap">
  <link rel="icon" href="favicon.ico" type="image/x-icon">
</head>
<body>
  <div id="app"></div>
</body>
</html>
EOL

  # 填充App.js
  cat > d3-stock-visualization/src/App.js <<EOL
import React from 'react';
import Dashboard from './views/Dashboard';
import SingleStockView from './views/SingleStockView';
import ComparisonView from './views/ComparisonView';
import ThemeProvider from './services/themeService';

function App() {
  return (
    <ThemeProvider>
      <div className="app-container">
        {/* App navigation logic will be added here */}
        <Dashboard />
      </div>
    </ThemeProvider>
  );
}

export default App;
EOL

  # 填充index.js
  cat > d3-stock-visualization/src/index.js <<EOL
import React from 'react';
import ReactDOM from 'react-dom/client';
import './styles/main.scss';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('app'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOL

  # 填充CandlestickChart.js
  cat > d3-stock-visualization/src/components/charts/CandlestickChart.js <<EOL
import React, { useRef, useEffect } from 'react';
import * as d3 from 'd3';
import useResizeObserver from '../utils/useResizeObserver';

const CandlestickChart = ({ data }) => {
  const svgRef = useRef();
  const wrapperRef = useRef();
  const dimensions = useResizeObserver(wrapperRef);
  
  useEffect(() => {
    if (!data || !dimensions) return;
    
    const svg = d3.select(svgRef.current);
    const { width, height } = dimensions;
    
    // Clear previous chart
    svg.selectAll("*").remove();
    
    // Create scales
    const xScale = d3.scaleTime()
      .domain(d3.extent(data, d => d.date))
      .range([0, width]);
    
    const yScale = d3.scaleLinear()
      .domain([d3.min(data, d => d.low) * 0.95, d3.max(data, d => d.high) * 1.05])
      .range([height, 0]);
    
    // Draw chart here...
    
  }, [data, dimensions]);
  
  return (
    <div ref={wrapperRef} className="chart-wrapper">
      <svg ref={svgRef} width="100%" height="100%">
        {/* D3 chart elements will be rendered here */}
      </svg>
    </div>
  );
};

export default CandlestickChart;
EOL

  # 填充indicatorService.js
  cat > d3-stock-visualization/src/services/indicatorService.js <<EOL
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
EOL

  # 填充README.md
  cat > d3-stock-visualization/README.md <<EOL
# D3.js Stock Visualization Project

This is a D3.js based application for visualizing stock data with technical indicators.

## Project Structure

\`\`\`
$(tree -d -L 3 d3-stock-visualization)
\`\`\`

## Getting Started

1. Clone the repository:
   \`\`\`bash
   git clone https://github.com/yourusername/d3-stock-visualization.git
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   cd d3-stock-visualization
   npm install
   \`\`\`

3. Run the development server:
   \`\`\`bash
   npm start
   \`\`\`

4. Open your browser to http://localhost:8080

## Features

- Interactive candlestick charts
- Volume indicators
- Technical indicators (SMA, EMA, RSI, MACD)
- Customizable time frames
- Light/dark theme support

## Contributing

Contributions are welcome! Please follow our contribution guidelines...
EOL

  echo -e "\n✅ Project structure created successfully at d3-stock-visualization/"
  echo -e "Next steps:"
  echo -e "1. cd d3-stock-visualization"
  echo -e "2. npm install"
  echo -e "3. npm start\n"
}

# 执行创建函数
create_d3_project