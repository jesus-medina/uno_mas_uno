import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:uno_mas_uno/presentation/ui/person_ui.dart';
import 'package:uno_mas_uno/presentation/ui/widget/person_card.dart';

class OrganizationPage extends StatelessWidget {
  final BuchheimWalkerConfiguration _builder = BuchheimWalkerConfiguration();

  @override
  Widget build(BuildContext context) => GraphView(
        graph: _getGraph(),
        algorithm:
            BuchheimWalkerAlgorithm(_builder, TreeEdgeRenderer(_builder)),
      );

  Graph _getGraph() {
    Graph graph = Graph();

    final supervisor = Node(Text("Supervisor"));
    final guia1 = Node(Text("Guía 1"));
    final guia2 = Node(Text("Guía 2"));
    final guia3 = Node(Text("Guía 3"));

    final pe1 = Node(Text("PE 1"));
    final pe2 = Node(Text("PE 2"));
    final pe3 = Node(Text("PE 3"));

    final pe4 = Node(Text("PE 4"));
    final pe5 = Node(Text("PE 5"));
    final pe6 = Node(Text("PE 6"));

    final pe7 = Node(Text("PE 7"));
    final pe8 = Node(Text("PE 8"));
    final pe9 = Node(Text("PE 9"));

    graph
      ..addEdge(supervisor, guia1)
      ..addEdge(supervisor, guia2)
      ..addEdge(supervisor, guia3)
      ..addEdge(guia1, pe1)
      ..addEdge(guia1, pe2)
      ..addEdge(guia1, pe3)
      ..addEdge(guia2, pe4)
      ..addEdge(guia2, pe5)
      ..addEdge(guia2, pe6)
      ..addEdge(guia3, pe7)
      ..addEdge(guia3, pe8)
      ..addEdge(guia3, pe9);

    return graph;
  }
}
