import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/widgets/appbar_widget.dart';
import '../../../../../../../../core/widgets/empty_list.dart';
import '../../../../../../../../core/widgets/lottie_loader.dart';
import '../cubit/zikr_cubit.dart';
import 'zikry_item.dart';

class BodyAzkary extends StatefulWidget {
  const BodyAzkary({super.key});

  @override
  State<BodyAzkary> createState() => _BodyAzkaryState();
}

class _BodyAzkaryState extends State<BodyAzkary> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List zikrList = [];

  @override
  void initState() {
    super.initState();
    context.read<ZikrCubit>().loadZikr();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppbarWidget(title: "أذكارى"),
        Expanded(
          child: BlocConsumer<ZikrCubit, ZikrState>(
            listener: (context, state) {
              if (state is ZikrLoaded) {
                final newList = state.zikrList;

                setState(() {
                  if (newList.length > zikrList.length) {
                    final newItem = newList.first;
                    zikrList.insert(0, newItem);
                    _listKey.currentState?.insertItem(0);
                  } else if (newList.length < zikrList.length) {
                    zikrList = List.from(newList);
                  } else {
                    zikrList = List.from(newList);
                  }
                });
              }
            },
            builder: (context, state) {

              if (state is ZikrError) {
                return Center(child: Text(state.message));
              }

              if (state is ZikrLoaded) {
                final list = state.zikrList;
                if (list.isEmpty) return const EmptyList();

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final zikr = list[index];
                    return ZikryItem(
                      zikr: zikr,
                      onDeleted: () {
                        final key = zikr.key as int;
                        context.read<ZikrCubit>().deleteZikr(key);
                      },
                    );
                  },
                );
              }


              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
