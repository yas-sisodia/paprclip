// ignore_for_file: public_member_api_docs, sort_constructors_first
class FirstModel {
  int id;
  String security;
  int industryId;
  String industry;
  int sectorId;
  String sector;
  double mCap;
  // String eV;
  double bookNavPerShare;
  double ttmPE;
  double pegRatio;
  double divYield;
  FirstModel(
    this.id,
    this.security,
    this.industryId,
    this.industry,
    this.sectorId,
    this.sector,
    this.mCap,
    // this.eV,
    this.bookNavPerShare,
    this.ttmPE,
    this.pegRatio,
    this.divYield,
  );

  factory FirstModel.fromMap(Map<String, dynamic> data) {
    return FirstModel(
        data['ID'],
        data['Security'],
        data['IndustryID'],
        data['Industry'],
        data['SectorID'],
        data['Sector'],
        data['MCAP'],
        // data['EV'],
        data['BookNavPerShare'],
        data['TTMPE'],
        data['PEGRatio'],
        data['Yield']);
  }
}
