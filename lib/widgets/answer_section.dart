import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:perplexity_clone_beta/services/chat_web_service.dart';
import 'package:perplexity_clone_beta/theme/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnswerSection extends StatefulWidget {
  const AnswerSection({super.key});

  @override
  State<AnswerSection> createState() => _AnswerSectionState();
}

class _AnswerSectionState extends State<AnswerSection> {
  String fullResponse = """
    A new Flutter project.
    ## Getting Started
    This project is a starting point for a Flutter application.
    A few resources to get you started if this is your first Flutter project:

    - [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
    - [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

    For help getting started with Flutter development, view the
    [online documentation](https://docs.flutter.dev/), which offers tutorials,
    samples, guidance on mobile development, and a full API reference.

  ## Steps to Get Started

  ### Backend

  1. Install Python Virtual Environment inside server folder (eg: python -m venv venv)
  2. Install requirements.txt (eg: pip install requirements.txt)
  3. Create .env and Put your TAVILY_API_KEY and GEMINI_API_KEY
  4. inside server folder run (uvicorn main:app --reload) in Terminal

  ### Frontend
      """;
  // String fullResponse = "";
  bool isLoadingContent = true;
  @override
  void initState() {
    ChatWebService().contentStream.listen((data) {
      if (isLoadingContent) {
        fullResponse = "";
      }
      setState(() {
        fullResponse += data['data'];
        isLoadingContent = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Perplexity",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Skeletonizer(
          enabled: isLoadingContent,
          effect: ShimmerEffect(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            duration: Duration(seconds: 1),
          ),
          child: Markdown(
            data: fullResponse,
            shrinkWrap: true,
            styleSheet: MarkdownStyleSheet.fromTheme(
              Theme.of(context),
            ).copyWith(
              codeblockDecoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              code: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
