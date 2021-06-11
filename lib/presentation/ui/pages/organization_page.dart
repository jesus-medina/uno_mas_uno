import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:uno_mas_uno/data/datasource/person_remote_datasource.dart';
import 'package:uno_mas_uno/data/person_data.dart';

class OrganizationPage extends StatelessWidget {
  final PersonRemoteDataSource _personRemoteDataSource =
      PersonRemoteDataSource(FirebaseFirestore.instance);

  final BuchheimWalkerConfiguration _builder = BuchheimWalkerConfiguration()
    ..orientation = BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: InteractiveViewer(
                constrained: false,
                boundaryMargin: EdgeInsets.all(100),
                minScale: 0.01,
                maxScale: 5.6,
                child: StreamBuilder<List<DataPerson>>(
                  stream: _personRemoteDataSource.getPeople(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError || !snapshot.hasData) {
                      return Text('');
                    }
                    List<DataPerson> dataPeople = snapshot.data;

                    return GraphView(
                      graph: _getGraph(dataPeople),
                      algorithm: BuchheimWalkerAlgorithm(
                        _builder,
                        TreeEdgeRenderer(_builder),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );

  Graph _getGraph(List<DataPerson> people) {
    Graph graph = Graph();

    people.forEach((person) {
      if (person.spiritualGuideId != null) {
        var spiritualGuide = people.firstWhere(
            (possibleGuide) => possibleGuide.id == person.spiritualGuideId);
        var source = _createNodeFrom(spiritualGuide);
        var node = _createNodeFrom(person);
        graph.addEdge(source, node);
      }
    });

    return graph;
  }

  Node _createNodeFrom(DataPerson person) {
    var genreColor = person.gender == "male" ? Colors.blue : Colors.pink;
    return Node(
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)),
          child: Container(
            color: genreColor,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text(person.firstName, style: TextStyle(color: Colors.white)),
                Text(person.lastName, style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
        key: Key(person.id));
  }
}
