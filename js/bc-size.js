function get_chart(chartData) {
    chartData.shift();

    for (var i = 0; i < chartData.length; ++i) {
        chartData[i].date = new Date(1000 * chartData[i][0]);
        chartData[i].height = i + 1;
        chartData[i].bc_size = chartData[i][3];
        if (i > 0)
          chartData[i].bc_size += chartData[i - 1].bc_size;
        chartData[i].bc_size_str = formatBytes(chartData[i].bc_size, 3);
    }

    var chart = AmCharts.makeChart("chartdiv", {
        "type": "serial",
        "theme": "light",
        "marginRight": 80,
        "autoMarginOffset": 20,
        "marginTop": 7,
        "dataProvider": chartData,
        "valueAxes": [{
            "axisAlpha": 0,
        }],
        "mouseWheelZoomEnabled": true,
        "graphs": [{
            "id": "g1",
            "lineColor": "#07ab82",
            "balloonText": "Size: [[bc_size_str]]\nHeight: <b>[[height]]</b>",
            "bullet": "round",
            "bulletBorderAlpha": 1,
            "bulletColor": "#FFFFFF",
            "hideBulletsCount": 50,
            "title": "block size",
            "valueField": "bc_size",
            "useLineColorForBulletBorder": true,
            "balloon":{
                "cornerRadius": 10,
            }
        }],
        "chartScrollbar": {
            "autoGridCount": true,
            "graph": "g1",
            "scrollbarHeight": 40
        },
        "chartCursor": {
           "pan": false
        },
        "categoryField": "date",
        "categoryAxis": {
            "parseDates": true,
            "minPeriod": "ss",
            "axisColor": "#DADADA",
            "dashLength": 1,
            "minorGridEnabled": true
        },
        "export": {
            "enabled": true,
            "position": "bottom-right"
        }
    });

    // this method is called when chart is first inited as we listen for "rendered" event
    function zoomChart() {
        // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
        chart.zoomToIndexes(0, chartData.length - 1);
    }
    chart.addListener("rendered", zoomChart);
    zoomChart();

    return chart;
}
