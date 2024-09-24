class validOdList{
  String? reason;
  String? stdate;
  String? enddate;
  String? stTime;
  String? endTime;
  String? cstatus;
  String? astatus;
  String? hodstatus;

  // validOdList({this.reason, this.stdate, this.enddate, this.stTime, this.endTime,
  //     this.cstatus, this.astatus, this.hodstatus});
  validOdList.fromJson(Map json){
    reason=json['reason'];
    stdate=json['start_date'];
    enddate=json['end_date'];
    stTime=json['start_time'];
    endTime=json['end_time'];
    cstatus=json['class_incharge_status'];
    astatus=json['academic_head_status'];
    hodstatus=json['hod_status'];
  }

  Map toJson() {
    return {'reason': reason, 'start_date': stdate, 'end_date': enddate, 'start_time': stTime, 'end_time':endTime, 'class_incharge_status':cstatus,'academic_head_status':astatus,'hod_status':hodstatus};
  }
}