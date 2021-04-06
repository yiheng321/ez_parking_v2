import 'package:flutter_test/flutter_test.dart';
import 'package:ezparking/Controller/Validation.dart';

void main() {
  test('non empty string', () {
    final validator = Validation();
    expect(validator.validatePassWord('test'), null);
  });

  test('empty string', () {
    final validator = Validation();
    expect(validator.validatePassWord(''), "password can not be none");
  });

  test('non empty string', () {
    final validator = Validation();
    expect(validator.validateUserName('test'), null);
  });

  test('non empty string less tan 4', () {
    final validator = Validation();
    expect(validator.validateUserName('tes'), "username < 4 digits");
  });

  test('empty string', () {
    final validator = Validation();
    expect(validator.validateUserName(''), "username can not be empty");
  });
  test('non empty string', () {
    final validator = Validation();
    expect(validator.validateConfirmPassWord('test'), 'password not the same');
  });

  test('empty string', () {
    final validator = Validation();
    expect(validator.validatePassWord(''), "password can not be none");
  });

}
