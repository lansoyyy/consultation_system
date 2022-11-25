import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class FeedbackTab extends StatelessWidget {
  const FeedbackTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, bottom: 20),
          child: BoldText(label: 'Feedbacks', fontSize: 32, color: primary),
        ),
        Expanded(
          child: SizedBox(
            child: ListView.builder(itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  title: NormalText(
                      label: 'John Doe', fontSize: 24, color: primary),
                  leading: const CircleAvatar(
                    minRadius: 30,
                    maxRadius: 30,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  children: [
                    NormalText(
                        label: 'Feedback', fontSize: 18, color: Colors.black),
                    NormalText(
                        label:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        fontSize: 14,
                        color: Colors.grey),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            })),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    ));
  }
}
