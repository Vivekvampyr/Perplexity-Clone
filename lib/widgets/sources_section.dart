import 'package:flutter/material.dart';
import 'package:perplexity_clone_beta/services/chat_web_service.dart';
import 'package:perplexity_clone_beta/theme/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SourcesSection extends StatefulWidget {
  const SourcesSection({super.key});

  @override
  State<SourcesSection> createState() => _SourcesSectionState();
}

class _SourcesSectionState extends State<SourcesSection> {
  // List<Map<String, dynamic>> searchResults = [
  //   {
  //     'title': 'Ind vs Aus Live Score 4th Test',
  //     'url':
  //         'https://www.moneycontrol.com/sports/cricket/ind-vs-aus-live-score-4th-test',
  //   },
  //   {
  //     'title': 'India vs Australia 4th Test Highlights',
  //     'url':
  //         'https://www.espncricinfo.com/series/india-vs-australia-2026-4th-test-highlights',
  //   },
  //   {
  //     'title': 'IND vs AUS 4th Test Match Updates and Scorecard',
  //     'url': 'https://www.cricbuzz.com/live-cricket-score/ind-vs-aus-4th-test',
  //   },
  // ];
  bool isLoading = true;
  List searchResults = [
    {
      'title': 'Ind vs Aus Live Score 4th Test',
      'url':
          'https://www.moneycontrol.com/sports/cricket/ind-vs-aus-live-score-4th-test',
    },
    {
      'title': 'India vs Australia 4th Test Highlights',
      'url':
          'https://www.espncricinfo.com/series/india-vs-australia-2026-4th-test-highlights',
    },
    {
      'title': 'IND vs AUS 4th Test Match Updates and Scorecard',
      'url': 'https://www.cricbuzz.com/live-cricket-score/ind-vs-aus-4th-test',
    },
  ];
  @override
  void initState() {
    super.initState();
    ChatWebService().searchResultStream.listen((data) {
      setState(() {
        searchResults = data['data'];
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.source_outlined, color: Colors.white70),
            SizedBox(width: 8),
            Text(
              "Sources",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        Skeletonizer(
          enabled: isLoading,
          effect: ShimmerEffect(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            duration: Duration(seconds: 1),
          ),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children:
                searchResults.map((res) {
                  return Container(
                    width: 150,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          res['title'],
                          style: TextStyle(fontWeight: FontWeight.w400),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Text(
                          res['url'],
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
