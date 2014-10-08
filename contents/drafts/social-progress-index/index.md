---
title: Correlations with SPI
author: franc
date: 2014-01-25
template: article.jade
---

I'm really excited by the number of initiatives coming up these last couple of years that introduce serious measures of "externalities" into our old measures of social and economical success. One of the ones which has got more attention and is in my opinion one of the most completes is the [Social Progress Index](http://www.socialprogressimperative.org) (SPI).

The SPI is a combined measure of more than 50 indicators that looks to provide a complete and accurate picture of the social progress, well-being, opportunity and respect for human rights that a country or region provides to its citizens.

If you're into data visualization, pay attention to the way the SPI is displayed. Interactive Things, a fantastic studio in data visualization based in Zurich, Switzerland, designed a perfectly crafted interface to explore the conclusions and results of the SPI.

And since the Social Progress Imperative (the organization behind SPI) publish all of their data, I thought it would be a good idea to use it and explore it a little, while using it for an introduction to d3.js tutorial from end-to-end.

Here's what we're going to do:

<div>
<div style="width: 30%; float: left">
<select id="indexX">Select an index to compare (X)</select>
<select id="indexY">Select an index to compare (Y)</select>
<button id="go">Go</button>
</div>

<div style="float: left; width: 70%; display: block">
<div id="chart" style="text-align: center"></div>
</div>
</div>

Let's get to it.

#### The SVG

The start we need a place in the DOM where we're going to insert our chart:

```html
<div id="chart"></div>
```
Let's start with some variables:

```javascript
var w = 500,
    h = 500,
    mg = {
        top: 10,
        right: 10,
        bottom: 50,
        left: 50
    };
```            

```javascript
// Select placeholder and append an SVG with the right measures
var svg = d3.select("#chart")
    .append("svg:svg")
    .attr("width", w)
    .attr("height", h);
```

Add drop-down menus to select indicators from, and a button to apply changes.

The HTML:
```html
<select id="indexX">Select an index to compare (X)</select>
<select id="indexY">Select an index to compare (Y)</select>
<button id="go">Go</button>
```

The JS:

```javascript
// Select the drop-down menus and insert an option for each SPI mearsure
var indexX = document.getElementById("indexX"),
    indexY = document.getElementById("indexY");

indexs.forEach(function (d) {
    indexX.options.add(new Option(d, d));
    indexY.options.add(new Option(d, d));
});

var inX = indexs[1],
    inY = indexs[2];

indexX.addEventListener("change", function (d) {
    inX = d.target.value;
});
indexY.addEventListener("change", function (d) {
    inY = d.target.value;
});
```

<script>
    d3.csv("spi2014.csv", function (csv) {

        var w = 500,
            h = 500,
            mg = {
                top: 10,
                right: 10,
                bottom: 50,
                left: 50
            },
            countries,
            box,
            boxText,
            boxW = 125,
            boxH = 50,
            xAxis, yAxis, yAxisDash, gXAxis, gYAxis, gYAxisDash;

        var indexs = _.keys(csv[0]);

        var indexX = document.getElementById("indexX"),
            indexY = document.getElementById("indexY");

        indexs.forEach(function (d) {
            indexX.options.add(new Option(d, d));
            indexY.options.add(new Option(d, d));
        });

        var inX = indexs[1],
            inY = indexs[2];

        indexX.addEventListener("change", function (d) {
            inX = d.target.value;
        });
        indexY.addEventListener("change", function (d) {
            inY = d.target.value;
        });

        // SVG
console.log(inX, inY)
        var svg = d3.select("#chart")
            .append("svg:svg")
            .attr("width", w)
            .attr("height", h);

        var bg = svg.append("rect")
            .attr("width", w)
            .attr("height", h)
            .attr("x", 0)
            .attr("y", 0)
            .style("fill", "#f3f3f3");

        var x = d3.scale.linear(),
            y = d3.scale.linear();

        var onHover = function (d) {
            var mouseX = d3.mouse(this)[0],
                mouseY = d3.mouse(this)[1],
                x = function () {
                    if (mouseX + 5 > (w - boxW)) {
                        return mouseX - 5 - boxW;
                    }
                    return mouseX + 5;
                };

            box.style("opacity", 1)
                .attr("x", x())
                .attr("y", mouseY + 5)

            boxText.style("opacity", 1)
                .attr("x", x() + 5)
                .attr("y", mouseY + 20)
                .text(d["Country"]);
        };

        var offHover = function () {
            box.style("opacity", 0);
            boxText.style("opacity", 0);
        };

        var doAxis = function () {
            // Define axis
            xAxis = d3.svg.axis()
                .orient("bottom")
                .scale(x)
                .ticks(6)
                .tickSize(10)
                .tickPadding(10);

            // Define axis
            yAxis = d3.svg.axis()
                .orient("left")
                .scale(y)
                .ticks(6)
                .tickSize(10)
                .tickPadding(10);

            yAxisDash = d3.svg.axis()
                .orient("right")
                .scale(y)
                .ticks(6)
                .tickSize(w - mg.left)
                .tickFormat("");

            // Append axis
            gXAxis = svg.append("g")
                .attr("class", "axisX axis")
                .attr("transform", "translate(0," + (h - mg.bottom) + ")")
                .style("color", "#888")
                .style("font-family", "Arial")
                .style("font-size", 11)
                .call(xAxis);

            gYAxis = svg.append("g")
                .attr("class", "axisY axis")
                .attr("transform", "translate(" + mg.left + ",0)")
                .style("color", "#888")
                .style("font-family", "Arial")
                .style("font-size", 11)
                .call(yAxis);

            gYAxisDash = svg.append("g")
                .attr("class", "axisY axis")
                .attr("transform", "translate(" + mg.left + ",0)")
                .style("stroke", "#ffffff")
                .style("stroke-width", 2)
                .call(yAxisDash);

            // Style axis
                gXAxis.select("path.domain")
                    .style("fill", "none");
                gYAxis.select("path.domain")
                    .style("fill", "none");
                gYAxisDash.select("path.domain")
                    .style("fill", "none");
        };

        var doAxisTitles = function  () {
            svg.append("text")
                .attr("class", "XaxisTitle")
                .attr("x", 0)
                .attr("y", 0)
                .attr("transform", "translate(" + (mg.left / 3) + ", " + ((h - mg.bottom) / 2) + ")rotate(270)")
                .style("text-anchor", "middle")
                .style("color", "#888")
                .style("font-family", "Arial")
                .style("font-size", 11)
                .text("EYS");

            svg.append("text")
                .attr("class", "YaxisTitle")
                .attr("x", 0)
                .attr("y", 0)
                .attr("transform", "translate(" + (mg.left + (w - mg.right - mg.left) / 2) + ", " + (h - 10) + ")")
                .style("text-anchor", "middle")
                .style("color", "#888")
                .style("font-family", "Arial")
                .style("font-size", 11)
                .text("EYS");                
        }

        var doCountries = function () {
            countries = svg.selectAll(".countries")
                .data(csv)
                .enter().append("circle")
                .attr("data-country", function (d) { return d["country"]; })
                .style("fill", "rgb(254, 200, 98)")
                .style("stroke", "#888888")
                .style("stroke-width", 1)
                .style("cursor", "pointer")
                .on("mouseover", onHover)
                .on("mousemove", onHover)
                .on("mouseout", offHover);
        };

        var doBox = function () {
            box = svg.append("rect")
                .attr("x", 0)
                .attr("y", 0)
                .attr("rx", 5)
                .attr("ry", 5)
                .attr("width", boxW)
                .attr("height", boxH)
                .style("fill", "rgba(34,34,34,0.98)")
                .style("opacity", 0);

            boxText = svg.append("text")
                .attr("class", "boxText")
                .attr("x", 0)
                .attr("y", 0)
                .style("fill", "#e8e8e8")
                .style("font-family", "Arial")
                .style("font-size", 11)                
                .text("");
        };

        var plot = function () {
            var xLims = [d3.min(_.pluck(csv, inX)), d3.max(_.pluck(csv, inX))],
                yLims = [d3.min(_.pluck(csv, inY)), d3.max(_.pluck(csv, inY))];

            x.domain(xLims)
                .range([mg.left, w - mg.right]),
            y.domain(yLims)
                .range([h - mg.bottom, mg.top]);

            countries
                .data(csv)
                .transition()
                .attr("cx", function (d) { return x(d[inX]); })
                .attr("cy", function (d) { return y(d[inY]); })
                .attr("r", 5);

            gXAxis
                .transition()
                .call(xAxis);
            gYAxis
                .transition()
                .call(yAxis);
            gYAxisDash
                .transition()
                .call(yAxisDash);

            d3.selectAll(".axisY .axisX line")
                .style("fill", "none")
                .style("stroke", "#232323")
                .style("stroke-width", 1);

            d3.select(".YaxisTitle").text(inY);
            d3.select(".XaxisTitle").text(inX);
        };

        document.getElementById("go")
            .addEventListener("click", plot);

        doAxis();
        doAxisTitles();
        doCountries();
        doBox();
        plot();
    });
</script>