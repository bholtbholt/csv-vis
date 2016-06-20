var margin = {top: 20, right: 10, bottom: 30, left: 30},
width = 980 - margin.left - margin.right,
height = 500 - margin.top - margin.bottom;

var parseDate = d3.time.format("%Y-%m-%d").parse;

var x = d3.time.scale().range([0, width]);
var y = d3.scale.linear().range([0, height]);

var color = d3.scale.ordinal()
  .range(["#00baf2", "#fa6848", "#74bc4c", "#efbb1f"]);

var xAxis = d3.svg.axis()
  .scale(x)
  .orient("bottom");

var yAxis = d3.svg.axis()
  .scale(y)
  .orient("left");

var line = d3.svg.line()
  .x(function(d) { return x(d.date); })
  .y(function(d) { return y(d.rank); });

var svg = d3.select(".js-line-chart").append("svg")
  .attr("width", width + margin.left + margin.right)
  .attr("height", height + margin.top + margin.bottom)
  .append("g")
  .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

d3.tsv("keyword-entry-data.tsv", function(error, data) {
  if (error) throw error;

  // Assign colours to search engines
  // Ignore additional columns in the row
  color.domain(d3.keys(data[0]).filter(function(key) {
    return key !== "GlobalMonthlySearches" && key !== "Keyword" && key !== "Site" && key !== "date";
  }));

  data.forEach(function(d) {
    d.date = parseDate(d.date);
  });

  var searchEngines = color.domain().map(function(name) {
    return {
      name: name,
      values: data.map(function(d) {
        return {date: d.date, rank: +d[name]};
      })
    };
  });

  x.domain(d3.extent(data, function(d) { return d.date; }));

  y.domain([
    d3.min(searchEngines, function(c) { return d3.min(c.values, function(v) { return v.rank; }); }),
    d3.max(searchEngines, function(c) { return d3.max(c.values, function(v) { return v.rank; }); })
  ]);

  svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis);

  svg.append("g")
    .attr("class", "y axis")
    .call(yAxis)

  var searchEngine = svg.selectAll(".search-engine")
    .data(searchEngines)
    .enter().append("g")
    .attr("class", "search-engine");

  searchEngine.append("path")
    .attr("class", "hidden-line")
    .attr("d", function(d) { return line(d.values); });

  searchEngine.append("path")
    .attr("class", "line")
    .attr("d", function(d) { return line(d.values); })
    .style("stroke", function(d) { return color(d.name); });

  searchEngine.append("g").selectAll("circle")
    .data(function(d){return d.values})
    .enter()
    .append("circle")
    .attr("r", 4)
    .attr("cx", function(dd){return x(dd.date)})
    .attr("cy", function(dd){return y(dd.rank)})
    .attr("stroke", "none")
    .attr("fill", function(d){return color(this.parentNode.__data__.name)});

  // Adds text to the end of the line
  searchEngine.append("text")
    .attr("class", "line-title")
    .datum(function(d) { return {name: d.name, value: d.values[d.values.length - 1]}; })
    .attr("transform", function(d) { return "translate(" + x(d.value.date) + "," + y(d.value.rank) + ")"; })
    .attr("x", -50)
    .attr("dy", -10)
    .text(function(d) { return d.name; });

});
