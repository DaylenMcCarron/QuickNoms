import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

FirebaseAuth auth = FirebaseAuth.instance;
ImagePicker picker = ImagePicker();
Uuid uuid = Uuid();
FirebaseStorage storage = FirebaseStorage.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
final geo = GeoFlutterFire();
DatabaseReference realTimeDatabaseRef = FirebaseDatabase.instance.ref();
