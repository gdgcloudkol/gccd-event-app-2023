import 'package:ccd2023/configurations/configurations.dart';
import 'package:ccd2023/features/app/presentation/navigation/appbar.dart';
import 'package:ccd2023/features/app/presentation/navigation/drawer.dart';
import 'package:ccd2023/utils/launch_url.dart';
import 'package:ccd2023/utils/size_util.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight! * 0.07),
            child: const CCDAppBar(),
          ),
          drawer: const CCDDrawer(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth! * 0.08,
                      top: screenWidth! * 0.1,
                      bottom: screenWidth! * 0.05),
                  child: Text(
                    FAQDetails["title"].toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: GCCDColor.googleBlue, fontSize: 28),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenWidth! * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FAQDetails["description1"].toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      InkWell(
                        onTap: () => launchExternalUrl(
                            "mailto:${FAQDetails["sponsorMail"].toString()}"),
                        child: Text(
                          FAQDetails["sponsorMail"].toString(),
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: GCCDColor.googleBlue,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        FAQDetails["description2"].toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      InkWell(
                        onTap: () => launchExternalUrl(
                            "mailto:${FAQDetails["generalMail"].toString()}"),
                        child: Text(
                          FAQDetails["generalMail"].toString(),
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: GCCDColor.googleBlue,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: int.parse(FAQDetails['length'].toString()),
                    itemBuilder: (context, index) {
                      return GetSingleFAQWidget(
                        question: FAQQuestions[index],
                        answer: FAQAnswers[index],
                      );
                    }),
              ],
            ),
          )),
    );
  }
}

class GetSingleFAQWidget extends StatelessWidget {
  const GetSingleFAQWidget({
    super.key,
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: 6, horizontal: screenWidth! * 0.08),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          title: Text(
            question,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 20),
              child: Text(
                answer,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
