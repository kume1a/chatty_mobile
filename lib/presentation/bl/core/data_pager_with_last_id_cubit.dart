import 'package:collection/collection.dart';
import 'package:common_models/common_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

abstract class DataPagerWithLastIdCubit<F extends Object?, T extends Object?, ID extends Object?>
    extends Cubit<DataState<F, DataPage<T>>> {
  DataPagerWithLastIdCubit() : super(DataState<F, DataPage<T>>.idle());

  bool _fetching = false;

  @protected
  Future<Either<F, DataPage<T>>> provideDataPage(ID? lastId);

  ID resolveId(T t);

  @mustCallSuper
  Future<void> init([Object? args]) async {
    await fetchNextPage();
  }

  Future<void> onScrolledToEnd() async => fetchNextPage();

  Future<void> onRefreshPressed() async => fetchNextPage();

  Future<void> onRefresh() async {
    emit(DataState<F, DataPage<T>>.idle());

    return fetchNextPage();
  }

  @protected
  Future<void> fetchNextPage() async {
    if (_fetching) {
      return;
    }

    _fetching = true;

    if (state == DataState<F, DataPage<T>>.idle()) {
      emit(DataState<F, DataPage<T>>.loading());
    }

    final T? lastItem = state.get?.items.lastOrNull;
    final ID? id = lastItem != null ? resolveId(lastItem) : null;
    final Either<F, DataPage<T>> result = await provideDataPage(id);

    result.fold(
      (F l) => emit(DataState<F, DataPage<T>>.failure(l, state.get)),
      (DataPage<T> r) {
        if (state.hasData) {
          r.items.insertAll(0, state.getOrThrow.items);
        }

        emit(DataState<F, DataPage<T>>.success(r));
      },
    );

    _fetching = false;
  }
}
