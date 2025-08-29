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
