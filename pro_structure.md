d3-stock-visualization/
├── public/                  # 静态资源
│   ├── index.html           # 主入口HTML文件
│   ├── favicon.ico          # 网站图标
│   └── assets/              # 静态资源
│       ├── images/          # 图片资源
│       └── fonts/           # 字体文件
│
├── src/                     # 源代码目录
│   ├── data/                # 数据相关文件
│   │   ├── raw/             # 原始数据文件
│   │   ├── processed/       # 处理后的数据文件
│   │   └── api/             # API相关文件
│   │       ├── api.js       # API请求封装
│   │       └── mock.js      # 模拟数据
│   │
│   ├── components/          # 可复用组件
│   │   ├── charts/          # 图表组件
│   │   │   ├── CandlestickChart.js
│   │   │   ├── VolumeChart.js
│   │   │   ├── IndicatorChart.js
│   │   │   └── CompositeChart.js
│   │   │
│   │   ├── ui/              # UI组件
│   │   │   ├── Toolbar.js
│   │   │   ├── Legend.js
│   │   │   ├── Tooltip.js
│   │   │   └── Crosshair.js
│   │   │
│   │   └── utils/           # 工具组件
│   │       ├── Zoom.js
│   │       ├── Brush.js
│   │       └── DateAxis.js
│   │
│   ├── services/            # 服务层
│   │   ├── dataService.js   # 数据处理服务
│   │   ├── indicatorService.js # 指标计算服务
│   │   └── themeService.js  # 主题管理服务
│   │
│   ├── styles/              # 样式文件
│   │   ├── main.scss        # 主样式文件
│   │   ├── _variables.scss  # SCSS变量
│   │   ├── _charts.scss     # 图表专用样式
│   │   └── _ui.scss         # UI组件样式
│   │
│   ├── utils/               # 工具函数
│   │   ├── d3Helpers.js     # D3辅助函数
│   │   ├── formatters.js    # 数据格式化
│   │   └── constants.js     # 常量定义
│   │
│   ├── views/               # 页面视图
│   │   ├── Dashboard.js     # 主仪表盘视图
│   │   ├── SingleStockView.js # 单只股票视图
│   │   └── ComparisonView.js # 股票比较视图
│   │
│   ├── App.js               # 主应用组件
│   └── index.js             # 应用入口文件
│
├── tests/                   # 测试文件
│   ├── unit/                # 单元测试
│   └── integration/         # 集成测试
│
├── .gitignore               # Git忽略文件
├── package.json             # 项目配置和依赖
├── README.md                # 项目说明文档
├── webpack.config.js        # Webpack配置
└── babel.config.js          # Babel配置