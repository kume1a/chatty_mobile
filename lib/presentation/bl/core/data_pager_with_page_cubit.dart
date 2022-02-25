import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

abstract class DataPagerWithPageCubit<F extends Object?, T extends Object?>
    extends Cubit<DataState<F, DataPage<T>>> {
  DataPagerWithPageCubit() : super(DataState<F, DataPage<T>>.idle());

  int _page = 0;
  bool _fetching = false;

  @protected
  Future<Either<F, DataPage<T>>> provideDataPage(int page);

  @mustCallSuper
  Future<void> init([Object? args]) async {
    await _fetchNextPage();
  }

  Future<void> onScrolledToEnd() async => _fetchNextPage();

  Future<void> onRefreshPressed() async => _fetchNextPage();

  Future<void> onRefresh() async {
    emit(DataState<F, DataPage<T>>.idle());

    _page = 0;

    return _fetchNextPage();
  }

  Future<void> _fetchNextPage() async {
    if (_fetching) {
      return;
    }

    _fetching = true;

    if (state == DataState<F, DataPage<T>>.idle()) {
      emit(DataState<F, DataPage<T>>.loading());
    }

    final Either<F, DataPage<T>> result = await provideDataPage(_page);

    result.fold(
      (F l) => emit(DataState<F, DataPage<T>>.error(l, state.get)),
      (DataPage<T> r) {
        if (state.hasData) {
          r.items.insertAll(0, state.getOrThrow.items);
        }

        _page++;

        emit(DataState<F, DataPage<T>>.success(r));
      },
    );

    _fetching = false;
  }
}
