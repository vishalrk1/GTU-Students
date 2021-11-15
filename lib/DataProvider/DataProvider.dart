import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gtu_students/DataProvider/FireBase_Constants.dart';
import 'package:gtu_students/models/BranchModel.dart';
import 'package:gtu_students/models/Homecategory.dart';
import 'package:gtu_students/models/StreamModel.dart';
import 'package:gtu_students/models/Video%20_Leacture.dart';
import 'package:gtu_students/models/pdfModel.dart';

class DataProvider with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;

  late pdfModel pdfmodel;

  late List<HomeCategory> homeCategoryList = [];
  late List<LeactureChannelModel> channelList = [];
  late List<StreamModel> streamsList = [];
  late List<BranchModel> branchList = [];

// Fetching Home page Data.............
  Future<void> getHomeData() async {
    try {
      isLoading = true;
      isError = false;
      QuerySnapshot _ref =
          await FirebaseFirestore.instance.collection(HOMECATEGORY).get();
      List<HomeCategory> items = [];
      _ref.docs.forEach((DocumentSnapshot doc) {
        HomeCategory cat =
            HomeCategory.fromJson(doc.data() as Map<String, dynamic>);
        items.add(cat);
      });
      homeCategoryList = items;
      print('home Categories :- ${homeCategoryList.length}');
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

// Fetching Youtube channel list
  Future<void> getLecturChannelData() async {
    try {
      isLoading = true;
      isError = false;
      QuerySnapshot _ref =
          await FirebaseFirestore.instance.collection(VIDEOCHANNEL).get();
      List<LeactureChannelModel> items = [];
      _ref.docs.forEach((DocumentSnapshot doc) {
        LeactureChannelModel channel =
            LeactureChannelModel.fromJson(doc.data() as Map<String, dynamic>);
        items.add(channel);
      });
      channelList = items;
      print('video channels :- ${channelList.length}');
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

// Fetching Streams name Data...........................................
  Future<void> getStreamData() async {
    try {
      isLoading = true;
      isError = false;
      QuerySnapshot _ref =
          await FirebaseFirestore.instance.collection(STREAMS).get();
      List<StreamModel> items = [];
      _ref.docs.forEach((DocumentSnapshot doc) {
        StreamModel stream =
            StreamModel.fromJson(doc.data() as Map<String, dynamic>);
        items.add(stream);
      });
      streamsList = items;
      print('total streams :- ${streamsList.length}');
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

// Fetching Branch name Data...........................................
  Future<void> getBranchData({required String streamId}) async {
    try {
      isLoading = true;
      isError = false;
      QuerySnapshot _ref = await FirebaseFirestore.instance
          .collection("streams")
          .doc(streamId)
          .collection("subStreams")
          .get();
      List<BranchModel> items = [];
      _ref.docs.forEach((DocumentSnapshot doc) {
        BranchModel branch = BranchModel(
          id: doc.id.toString(),
          branchName: doc.get('branch').toString(),
        );
        items.add(branch);
      });
      branchList = items;
      print('total streams :- ${streamsList.length}');
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // Fetching pdf details for study material name Data...........................................
  Future<void> getPdfData({
    required String streamId,
    required String branchId,
    required String semesterId,
    required String subject,
  }) async {
    try {
      isLoading = true;
      isError = false;
      DocumentSnapshot _ref = await FirebaseFirestore.instance
          .collection("streams")
          .doc(streamId)
          .collection("subStreams")
          .doc(branchId)
          .collection("semesters")
          .doc(semesterId)
          .collection("subjects")
          .doc(subject)
          .get();
      late pdfModel item;
      item = _ref.data() as pdfModel;
      pdfmodel = item;
      print('pdf data fetched sucessfully');
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
