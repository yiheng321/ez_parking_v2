import 'package:firebase_auth/firebase_auth.dart';

class Review{

  int _id;
  String _carParkNo;
  int _cost;
  int _convenience;
  int _security;
  int _numOfReview;


  Review.fromMap(Map<String, dynamic> map) {
    _id = map["id"];
    _carParkNo = map['carParkNo'];
    _cost = map['cost'];
    _convenience = map['convenience'];
    _security = map['security'];
    _numOfReview = map["numOfReview"];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': _id,
      'carParkNo': _carParkNo,
      'cost': _cost,
      'convenience' : _convenience,
      'security': _security,
      'numOfReview': _numOfReview,
    };
    return map;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get numOfReview => _numOfReview;

  set numOfReview(int value) {
    _numOfReview = value;
  }

  int get security => _security;

  set security(int value) {
    _security = value;
  }

  int get convenience => _convenience;

  set convenience(int value) {
    _convenience = value;
  }

  int get cost => _cost;

  set cost(int value) {
    _cost = value;
  }

  String get carParkNo => _carParkNo;

  set carParkNo(String value) {
    _carParkNo = value;
  }

  Review(this._id, this._carParkNo, this._cost, this._convenience,
      this._security, this._numOfReview);
}