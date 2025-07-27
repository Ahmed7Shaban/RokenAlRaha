import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routes/routes.dart';
import 'cubit/asmaa_cubit.dart';
import 'service/asmaa_repository.dart';
import 'widget/asmaa_allah_body.dart';

class AsmaaAllahView extends StatelessWidget {
  const AsmaaAllahView({super.key});
  static const String routeName = Routes.AsmaaAllah;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  BlocProvider(
        create: (_) => AsmaaCubit(AsmaaRepository())..loadAsmaa(),
        child: const AsmaaAllahBody(),
      ),

    );
  }
}
