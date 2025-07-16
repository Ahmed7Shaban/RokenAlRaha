import 'package:flutter_bloc/flutter_bloc.dart';

import '../date/service_items_list.dart';
import 'service_card_state .dart';

class ServiceCardsCubit extends Cubit<ServiceCardsState> {
  ServiceCardsCubit() : super(ServiceCardsState(serviceItemsList));
}
