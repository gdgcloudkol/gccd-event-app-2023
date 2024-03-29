import 'package:ccd2023/configurations/configurations.dart';
import 'package:ccd2023/features/app/presentation/gccd_border.dart';
import 'package:ccd2023/features/auth/auth.dart';
import 'package:ccd2023/features/speaker/bloc/cfs_cubit.dart';
import 'package:ccd2023/features/speaker/bloc/technology_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:progress_builder/progress_builder.dart';

class TalkListPage extends StatelessWidget {
  const TalkListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final format = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Submitted Talks'),
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(CFSRoute());
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<CFSCubit>()
              .getTalksList(AuthCubit.instance.state.accessToken!);
        },
        child: BlocBuilder<CFSCubit, CFSState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Note: Talks can be edited only upto 72 hours post submission',
                  style: textTheme.titleLarge?.copyWith(
                    color: GCCDColor.googleYellow,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: kPadding * 2,
                ),
                if (state.loading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else if (state.talks.isEmpty)
                  Center(
                    child: Text(
                      'No talks submitted',
                      style: textTheme.headlineSmall,
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.talks.length,
                      itemBuilder: (context, index) {
                        final talk = state.talks[index];
                        final talkSubmittedDate =
                            DateTime.parse(talk.addedAt ?? '');
                        return Padding(
                          padding: const EdgeInsets.all(kPadding * 2),
                          child: GCCDBorder(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: kPadding * 2,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.date_range),
                                      const SizedBox(
                                        width: kPadding,
                                      ),
                                      Text(
                                        format.format(
                                          DateTime.parse(talk.addedAt ?? ''),
                                        ),
                                        style: textTheme.titleLarge,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: kPadding,
                                  ),
                                  Text(
                                    talk.title,
                                    style: textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    height: kPadding,
                                  ),
                                  Text(
                                    'Description',
                                    style: textTheme.titleMedium?.copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  Text(
                                    talk.description,
                                    style: textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    height: kPadding,
                                  ),
                                  Text(
                                    'Overview',
                                    style: textTheme.titleMedium?.copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  Text(
                                    talk.overview,
                                    style: textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    height: kPadding * 2,
                                  ),
                                  Container(
                                    color: _getStatusColor(
                                      talk.status ?? '',
                                    ),
                                    padding: const EdgeInsets.all(kPadding),
                                    child: Text(
                                      toBeginningOfSentenceCase(talk.status) ??
                                          '',
                                      style: textTheme.bodyLarge,
                                    ),
                                  ),
                                  if (_shouldShowActionButtons(
                                    talkSubmittedDate,
                                    talk.status ?? '',
                                  )) ...[
                                    const SizedBox(
                                      height: kPadding * 2,
                                    ),
                                    Row(
                                      children: [
                                        BlocBuilder<TechnologyCubit,
                                            TechnologyState>(
                                          builder: (context, state) {
                                            return state.maybeWhen(
                                              loaded: (_) => _TalkActionButtons(
                                                color: GCCDColor.googleBlue,
                                                iconData: Icons.edit,
                                                onPressed: () {
                                                  context.router.push(
                                                    CFSRoute(
                                                      talkDescription:
                                                          talk.description,
                                                      talkType: talk.format,
                                                      talkId: talk.id,
                                                      talkEvent: talk.event,
                                                      talkOverview:
                                                          talk.overview,
                                                      talkTitle: talk.title,
                                                      topicsOfExpertise:
                                                          talk.technologies,
                                                      addedAt: talk.addedAt,
                                                      status: talk.status,
                                                    ),
                                                  );
                                                },
                                              ),
                                              orElse: () => const Center(
                                                child: SizedBox(
                                                  height: kPadding * 2,
                                                  width: kPadding * 2,
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          width: kPadding,
                                        ),
                                        CircularProgressBuilder(
                                          action: (_) async {
                                            await context
                                                .read<CFSCubit>()
                                                .deleteTalk(
                                                  authToken: AuthCubit.instance
                                                      .state.accessToken!,
                                                  id: talk.id!,
                                                );
                                          },
                                          builder: (context, action, error) =>
                                              _TalkActionButtons(
                                            color: GCCDColor.googleRed,
                                            iconData: Icons.delete,
                                            onPressed: action,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: kPadding * 2,
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Color _getStatusColor(String status) {
  switch (status) {
    case 'review':
      return GCCDColor.googleYellow;
    case 'accepted':
      return GCCDColor.googleGreen;
    case 'rejected':
      return GCCDColor.googleRed;
    default:
      return GCCDColor.googleYellow;
  }
}

bool _shouldShowActionButtons(
  DateTime talkSubmittedDate,
  String status,
) {
  if (DateTime.now().difference(talkSubmittedDate).inDays >= 3) {
    return false;
  } else if (status == 'rejected' || status == 'accepted') {
    return false;
  } else {
    return true;
  }
}

class _TalkActionButtons extends StatelessWidget {
  const _TalkActionButtons({
    Key? key,
    required this.color,
    required this.iconData,
    this.onPressed,
  }) : super(key: key);

  final Color color;
  final IconData iconData;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: color,
        shape: const CircleBorder(),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }
}
