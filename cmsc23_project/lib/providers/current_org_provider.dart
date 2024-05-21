import 'package:cmsc23_project/api/firebase_org_api.dart';
import 'package:cmsc23_project/models/organization.dart';
import 'package:flutter/material.dart';

class CurrentOrgProvider with ChangeNotifier {
  final FirebaseOrgAPI _firebaseOrgAPI = FirebaseOrgAPI();
  late Organization _currentOrg;

  CurrentOrgProvider() {
    _currentOrg = _firebaseOrgAPI.orgs[0];
  }

  Organization get currentOrg => _currentOrg;
}
