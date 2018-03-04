var svgWidth = 650;
var svgHeight = 400;

var margin = { top: 20, right: 40, bottom: 60, left: 100 };

var width = svgWidth - margin.left - margin.right;
var height = svgHeight - margin.top - margin.bottom;

// Create an SVG wrapper, append an SVG group that will hold our chart, and shift the latter by left and top margins.
var svg = d3.select(".chart")
  .append("svg")
  .attr("width", svgWidth)
  .attr("height", svgHeight)
  .append("g")
  .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var chart = svg.append("g");

// Append a div to the body to create tooltips, assign it a class
d3.select(".chart")
  .append("div")
  .attr("class", "tooltip")
  .style("opacity", 0);
 

d3.csv("data.csv", function(err, data) {
  if (err) throw err;

  data.forEach(function(data) {
    data.poverty = +data.poverty;
    data.healthcare= +data.healthcare;
  });


  // Create scale functions
  var yLinearScale = d3.scaleLinear()
    .range([height, 0]);

  var xLinearScale = d3.scaleLinear()
    .range([0, width]);

  // Create axis functions
  var bottomAxis = d3.axisBottom(xLinearScale);
  var leftAxis = d3.axisLeft(yLinearScale);

  // Scale the domain
  xLinearScale.domain([7, d3.max(data, function(data) {
    return +data.poverty;
  })]);
  yLinearScale.domain([0, d3.max(data, function(data) {
    return +data.healthcare * 1.2;
  })]);

  var toolTip = d3.tip()
    .attr("class", "tooltip")
    .offset([80, -60])
    .html(function(data) {
      var state = data.abbr;
      var poverty = +data.poverty;
      var healthcare = +data.healthcare;
      return (state + "<br> poverty: " + poverty+"%" + "<br> healthcare: " + healthcare+"%");
    });

  chart.call(toolTip);

  var circle= chart.selectAll("circle")
    .data(data)
    .enter().append("circle")
      .attr("cx", function(data, index) {
        console.log(data.poverty);
        return xLinearScale(data.poverty);
      })
      .attr("cy", function(data, index) {
        return yLinearScale(data.healthcare);
      })
      .attr("r", "15")
      .attr("fill", "lightblue")
      .attr("stroke", "blue")
      //.text(data.abbr)
      .on("click", function(data) {
        toolTip.show(data);
      })
      // onmouseout event
      .on("mouseout", function(data, index) {
        toolTip.hide(data);
      });

  chart.append("g")
    .attr("transform", `translate(0, ${height})`)
    .call(bottomAxis);

  chart.append("g")
    .call(leftAxis);

  chart.append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 0 - margin.left + 40)
      .attr("x", 0 - (height / 2))
      .attr("dy", "1em")
      .attr("class", "axisText")
      .attr("fill", "black")
      .text("Healthcare (in %)");

// Append x-axis labels
  chart.append("text")
    .attr("transform", "translate(" + (width / 2) + " ," + (height + margin.top + 30) + ")")
    .attr("class", "axisText")
    .text("Poverty (in %)");


circle.append ("text")
      .text(function(d) {return d.abbr})
      .attr("fill","white");
});


