import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flow_zero_waste/core/common/domain/response.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/logic_state.dart';
import 'package:flow_zero_waste/src/discover/domain/entities/shop.dart';
import 'package:flow_zero_waste/src/discover/domain/usecases/get_shops.dart';
import 'package:injectable/injectable.dart';

part 'shops_state.dart';

@injectable
class ShopsCubit extends Cubit<ShopsState> {
  ShopsCubit({
    required GetShops getShops,
  })  : _getShops = getShops,
        super(ShopsInitial());

  final GetShops _getShops;
  String _category = '';

  final List<Shop> _shops = [];

  Future<void> getShops(String languageCode) async {
    emit(ShopsLoading());
    _shops.clear();
    final result = await _getShops(
        GetShopsParams(languageCode: languageCode, latitude: 0, longitude: 0));
    result.fold(
      (failure) => emit(ShopsError(failure: failure)),
      _shops.addAll,
    );
    emit(ShopsIdle(shops: _shops));
  }

  void getShopsByCategory(String category) {
    emit(ShopsLoading());
    if (category == _category) {
      _category = '';
    } else {
      _category = category;
    }
    if (category.isEmpty) {
      emit(ShopsIdle(shops: _shops));
      return;
    }
    final sortedShops = List<Shop>.from(_shops);
    if (_category == 'Cheapest' || _category == 'Najtańsze') {
      sortedShops.sort((a, b) => b.name.compareTo(a.localization));
    } else if (_category == 'Accessible' || _category == 'Dostępne') {
      sortedShops.sort((a, b) => b.endDate.compareTo(a.endDate));
    } else if (_category == 'Popular' || _category == 'Popularne') {
      sortedShops.sort((a, b) => b.rating.compareTo(a.rating));
    }

    emit(ShopsIdle(shops: List.from(sortedShops)));
  }
}
