import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_codeforces_app/styles/list_tiles.dart';
import 'package:my_codeforces_app/styles/text_styles.dart';
import '../constants.dart';
import '../services/codeforces_services.dart';

class ContestInfoScreen extends StatefulWidget {
  const ContestInfoScreen({super.key});

  @override
  State<ContestInfoScreen> createState() => _ContestInfoScreenState();
}

class _ContestInfoScreenState extends State<ContestInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Container(
        color: kwhite,
        child: FutureBuilder(
          future: CodeforcesServices().contestInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "No upcoming contests",
                    style: style1(),
                  ),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final int id = snapshot.data![index].id;
                    final String name = snapshot.data![index].name;
                    final String phase = snapshot.data![index].phase;
                    final int duration = snapshot.data![index].duration;
                    final int startTime = snapshot.data![index].startTime ?? 0;
                    return tile1(
                        id: id,
                        name: name,
                        phase: phase,
                        duration: duration,
                        startTime: startTime,
                        context: context);
                  },
                  itemCount: min(snapshot.data!.length, 20),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
