import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SorcePage extends StatefulWidget {
  const SorcePage({Key? key}) : super(key: key);

  @override
  State<SorcePage> createState() => _SorcePageState();
}

class _SorcePageState extends State<SorcePage> {
  String? name;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: (name != "" && name != null)
              ? firestore
                  .collection('Source')
                  .where("name", isGreaterThanOrEqualTo: name)
                  .where("name", isLessThanOrEqualTo: "$name\uf7ff")
                  .snapshots()
              : firestore.collection('Source').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final places = snapshot.data!.docs;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              // height: 200,
              child: snapshot.data!.docs.isNotEmpty
                  ? ListView.builder(
                      itemCount: places.length,
                      itemBuilder: (context, i) {
                        Map<String, dynamic> place =
                            places[i].data()! as Map<String, dynamic>;

                        return ListTile(
                          title: Text(place['name']),
                          onTap: () {
                            // sourceModel.setname(place['name']);
                            // sourceModel.setLatitude(place['latitude']);
                            // sourceModel.setLongitude(place['longitude']);
                            Navigator.pop(context, place);
                          },
                        );
                      },
                    )
                  : Center(child: Text("No Places")),
            );
          }),
    );
  }
}
