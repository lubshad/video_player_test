import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore instance = FirebaseFirestore.instance;
final videosRef = instance.collection("videos");
  