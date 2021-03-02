import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/fab/apartment_fab_edit.dart';
import 'package:swipe/custom_app_widget/shimmer/shimmer_users.dart';
import 'package:swipe/model/notary.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';

import 'api/notary_firestore_admin_api.dart';
import 'custom_widget/add_edit_notary_admin.dart';
import 'custom_widget/notary_item_admin.dart';

class AdminNotaryScreen extends StatefulWidget {
  @override
  _AdminNotaryScreenState createState() => _AdminNotaryScreenState();
}

class _AdminNotaryScreenState extends State<AdminNotaryScreen> {
  bool _isOpen = false;
  NotaryBuilder _notaryBuilder;

  @override
  void initState() {
    _notaryBuilder = NotaryBuilder();
    super.initState();
  }

  void _addEditNotary({NotaryBuilder notaryBuilder}) {
    setState(() {
      _isOpen = true;
      _notaryBuilder = notaryBuilder;
    });
  }

  Widget _buildAddEditNotary() {
    return AnimatedContainer(
      width: _isOpen ? MediaQuery.of(context).size.width : 0,
      height: _isOpen ? 400 : 0,
      duration: Duration(milliseconds: 1500),
      curve: Curves.fastOutSlowIn,
      child: AddEditNotaryAdmin(
        isOpen: _isOpen,
        notaryBuilder: _notaryBuilder,
        switchState: () {
          setState(() => _isOpen = false);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle1(
        title: "Нотариусы",
        onTapLeading: () => Navigator.pop(context),
        onTapAction: () => Navigator.pop(context),
      ),
      body: NetworkConnectivity(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: NotaryFirestoreAdminApi.getNotary(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }

                if (!snapshot.hasData) {
                  return ShimmerUsers();
                }

                if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
                  return Stack(
                    children: [
                      ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 11.0),
                        itemBuilder: (BuildContext context, int index) {
                          return NotaryItemAdmin(
                            notaryBuilder: NotaryBuilder.fromMap(
                              snapshot.data.docs[index].data(),
                            ),
                            onTap: () {
                              _addEditNotary(
                                notaryBuilder: NotaryBuilder.fromMap(
                                  snapshot.data.docs[index].data(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text("Здесь пока ничего нет..."),
                  );
                }
              },
            ),
            _buildAddEditNotary(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedSwitcher(
        duration: Duration(milliseconds: 1500),
        switchOutCurve: Curves.fastOutSlowIn,
        child: _isOpen
            ? SizedBox()
            : ApartmentFABEdit(
                title: "Добавить",
                onTap: () => _addEditNotary(
                  notaryBuilder: NotaryBuilder(),
                ),
              ),
      ),
    );
  }
}
