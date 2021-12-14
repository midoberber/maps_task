import 'package:flutter/material.dart';
import 'package:mtms_task/modules/destination_model.dart';
import 'package:provider/provider.dart';

class DestinationPage extends StatelessWidget {
  const DestinationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // use this page provider statmanagment
    final destinationModel =
        Provider.of<DestinationModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Destintion Places"),
      ),
      body: FutureBuilder(
        future: destinationModel.loadDestinationPlaces(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    var destinatinPlaces = snapshot.data[i];
                    String name = destinatinPlaces["name"];
                    String country = destinatinPlaces["country"];
                    // double long = double.parse(destinatinPlaces["lng"]);
                    // double lat = double.parse(destinatinPlaces["lat"]);
                    return ListTile(
                      onTap: () {
                        // destinationModel.setname(name);
                        // destinationModel.setLatitude(double.parse(destinatinPlaces["lat"]));
                        // destinationModel.setLongitude(double.parse(destinatinPlaces["lng"]));
                        Navigator.pop(context,destinatinPlaces);
                      },
                      title: Text(name),
                      subtitle: Text(country),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}
