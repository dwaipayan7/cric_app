import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/match_bloc.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  void initState() {
    super.initState();
    context.read<MatchBloc>().add(FetchMatchDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Live Match Details",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          if (state is MatchLoadingState) {
            return _buildSkeletonLoader();
          }

          if (state is MatchLoadedState) {
            final matches = state.matchs;

            if (matches.isEmpty) {
              return const Center(
                child: Text(
                  "No match data available.",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              );
            }

            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(matches.length, (index) {
                  final match = matches[index];
                  return Card(
                    elevation: 8,
                    shadowColor: Colors.blueAccent,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            match.seriesName,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 5),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  match.matchTitle,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Venue: ${match.matchVenue}",
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            "Date: ${match.matchDate} | Time: ${match.matchTime}",
                            style: const TextStyle(fontSize: 14),
                          ),
                          const Divider(color: Colors.grey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Team 1",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(match.teamOneName),
                                  Text(
                                    "Score: ${match.teamOneScore}",
                                    style: const TextStyle(color: Colors.blueAccent),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Team 2",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(match.teamTwoName),
                                  Text(
                                    "Score: ${match.teamTwoScore}",
                                    style: const TextStyle(color: Colors.blueAccent),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Current Status: ${match.currentStatus.toUpperCase()}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          }

          if (state is MatchErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }

          return const Center(
            child: Text(
              "No match data available.",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonAnimation(
                  shimmerColor: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                  shimmerDuration: 1500,
                  child: Container(
                    height: 20,
                    width: 150,
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(height: 10),
                SkeletonAnimation(
                  shimmerColor: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                  shimmerDuration: 1500,
                  child: Container(
                    height: 16,
                    width: 200,
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(height: 10),
                SkeletonAnimation(
                  shimmerColor: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                  shimmerDuration: 1500,
                  child: Container(
                    height: 16,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(height: 10),
                SkeletonAnimation(
                  shimmerColor: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                  shimmerDuration: 1500,
                  child: Container(
                    height: 16,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
