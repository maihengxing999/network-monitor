Chart.defaults.global.legend.display = false;
function draw(ctx, setname, labelset, dataset) {
    var data = {
        labels: labelset,
        datasets: [
        {
            label: setname,
            fill: false,
            lineTension: 0.3,
            backgroundColor: "rgba(75,192,192,0.4)",
            borderColor: "rgba(75,192,192,1)",
            borderCapStyle: 'butt',
            borderDash: [],
            borderDashOffset: 0.0,
            borderJoinStyle: 'miter',
            pointBorderColor: "rgba(75,192,192,1)",
            pointBackgroundColor: "#fff",
            pointBorderWidth: 1,
            pointHoverRadius: 5,
            pointHoverBackgroundColor: "rgba(75,192,192,1)",
            pointHoverBorderColor: "rgba(220,220,220,1)",
            pointHoverBorderWidth: 2,
            pointRadius: 1,
            pointHitRadius: 10,
            data: dataset,
            spanGaps: false
        }
        ]
    };
    var options = {};
    return new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });
}
