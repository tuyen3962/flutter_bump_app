import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';

import 'sponsorship_tab_cubit.dart';
import 'sponsorship_tab_state.dart';

class SponsorshipTab extends StatefulWidget {
  const SponsorshipTab({super.key});

  @override
  State<SponsorshipTab> createState() => _SponsorshipTabState();
}

class _SponsorshipTabState extends BaseBlocViewState<SponsorshipTab,
    SponsorshipTabState, SponsorshipTabCubit> {
  @override
  Widget buildView(BuildContext context, SponsorshipTabCubit cubit) {
    return Container();
  }
}
