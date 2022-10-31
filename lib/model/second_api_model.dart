// ignore_for_file: public_member_api_docs, sort_constructors_first
class SecondModel {
  List<Chart> chart;
  SecondModel(
    this.chart,
  );

  factory SecondModel.fromMap(List<dynamic> map) {
    return SecondModel(map.map((e) => Chart.fromMap(e)).toList());
  }
}

class Chart {
  int id;
  String label;
  String chartPeriodCode;
  double changePercent;
  Chart(
    this.id,
    this.label,
    this.chartPeriodCode,
    this.changePercent,
  );

  factory Chart.fromMap(Map<String, dynamic> data) {
    return Chart(
      data['ID'],
      data['Label'],
      data['ChartPeriodCode'],
      data['ChangePercent'],
    );
  }
}
