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
