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
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppbarWidget(title: "أذكارى"),
        Expanded(
          child: BlocConsumer<ZikrCubit, ZikrState>(
            listener: (context, state) {
              if (state is ZikrLoaded) {
                zikrList = List.from(state.zikrList);
              }
            },
            builder: (context, state) {
              if (state is ZikrLoading) {
                return const LottieLoader();
              }

              if (state is ZikrError) {
                return Center(child: Text(state.message));
              }

              if (state is ZikrLoaded) {
                if (state.zikrList.isEmpty) {
                  return const EmptyList();
                }

                return AnimatedList(
                  key: _listKey,
                  padding: const EdgeInsets.all(16),
                  initialItemCount: zikrList.length,
                  itemBuilder: (context, index, animation) {
                    final zikr = zikrList[index];
                    return SizeTransition(
                      sizeFactor: animation,
                      child: ZikryItem(
                        zikr: zikr,
                        onDeleted: () {
                          final key = zikr.key as int;

                          // حذف فعلي من AnimatedList
                          _listKey.currentState?.removeItem(
                            index,
                                (context, animation) => SizeTransition(
                              sizeFactor: animation,
                              child: ZikryItem(zikr: zikr),
                            ),
                            duration: const Duration(milliseconds: 300),
                          );

                          // حذف من Cubit
                          context.read<ZikrCubit>().deleteZikr(key);
                        },
                      ),
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
