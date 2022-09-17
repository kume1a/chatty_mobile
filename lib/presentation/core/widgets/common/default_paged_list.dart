import 'package:common_models/common_models.dart';
import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';

import '../indicators/no_internet_refresh_indicator.dart';
import '../indicators/unknown_error_refresh_indicator.dart';

class DefaultPagedList<T> extends StatelessWidget {
  const DefaultPagedList({
    super.key,
    required this.data,
    required this.itemBuilder,
    required this.onScrolledToEnd,
    required this.onRefreshPressed,
    ListBuilderConfig? config,
    required this.loadingItemBuilder,
    this.loadingItemsCount = 12,
    this.emptyListBuilder,
    this.loadingIndicatorBuilder,
    this.emptyListErrorBuilder,
    this.refreshIndicatorBuilder,
    this.idleBuilder,
  })  : isSliver = false,
        listBuilderConfig = config,
        sliverBuilderConfig = null;

  const DefaultPagedList.sliver({
    super.key,
    required this.data,
    required this.itemBuilder,
    required this.onScrolledToEnd,
    required this.onRefreshPressed,
    required this.loadingItemBuilder,
    SliverBuilderConfig? config,
    this.loadingItemsCount = 12,
    this.emptyListBuilder,
    this.loadingIndicatorBuilder,
    this.emptyListErrorBuilder,
    this.refreshIndicatorBuilder,
    this.idleBuilder,
  })  : isSliver = true,
        listBuilderConfig = null,
        sliverBuilderConfig = config;

  final bool isSliver;

  final DataState<FetchFailure, DataPage<T>> data;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final VoidCallback onScrolledToEnd;
  final VoidCallback onRefreshPressed;

  final ListBuilderConfig? listBuilderConfig;
  final SliverBuilderConfig? sliverBuilderConfig;

  final IndexedWidgetBuilder loadingItemBuilder;
  final int loadingItemsCount;

  final WidgetBuilder? emptyListBuilder;
  final WidgetBuilder? loadingIndicatorBuilder;
  final WidgetBuilder? emptyListErrorBuilder;
  final WidgetBuilder? refreshIndicatorBuilder;
  final WidgetBuilder? idleBuilder;

  @override
  Widget build(BuildContext context) {
    return data.when(
      success: (DataPage<T> data) {
        if (isSliver) {
          return PagedList<T>.sliver(
            data: data.items,
            totalCount: data.count,
            onScrolledToEnd: onScrolledToEnd,
            itemBuilder: itemBuilder,
            emptyListBuilder: emptyListBuilder,
            config: sliverBuilderConfig,
            loadingBuilder: loadingIndicatorBuilder,
          );
        }
        return PagedList<T>(
          data: data.items,
          totalCount: data.count,
          onScrolledToEnd: onScrolledToEnd,
          itemBuilder: itemBuilder,
          config: listBuilderConfig,
          emptyListBuilder: emptyListBuilder,
          loadingBuilder: loadingIndicatorBuilder,
        );
      },
      failure: (FetchFailure failure, DataPage<T>? data) {
        if (isSliver) {
          return RefreshableList<T>.sliver(
            data: data?.items,
            itemBuilder: itemBuilder,
            config: sliverBuilderConfig,
            emptyListErrorBuilder: emptyListErrorBuilder ??
                (_) => failure.maybeWhen(
                      network: () => NoInternetRefreshIndicator(
                        onRefreshPressed: onRefreshPressed,
                      ),
                      orElse: () => UnknownErrorRefreshIndicator(
                        onRefreshPressed: onRefreshPressed,
                      ),
                    ),
            onRefreshPressed: onRefreshPressed,
            refreshBuilder: refreshIndicatorBuilder,
          );
        }
        return RefreshableList<T>(
          data: data?.items,
          itemBuilder: itemBuilder,
          config: listBuilderConfig,
          emptyListErrorBuilder: emptyListErrorBuilder ??
              (_) => failure.maybeWhen(
                    network: () => NoInternetRefreshIndicator(
                      onRefreshPressed: onRefreshPressed,
                    ),
                    orElse: () => UnknownErrorRefreshIndicator(
                      onRefreshPressed: onRefreshPressed,
                    ),
                  ),
          onRefreshPressed: onRefreshPressed,
          refreshBuilder: refreshIndicatorBuilder,
        );
      },
      loading: () {
        if (isSliver) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext c, int i) {
                return Shimmer.fromDefaultColors(
                  child: loadingItemBuilder.call(c, i),
                );
              },
              childCount: loadingItemsCount,
            ),
          );
        }
        return Shimmer.fromDefaultColors(
          child: ListView.builder(
            itemBuilder: loadingItemBuilder,
            itemCount: loadingItemsCount,
          ),
        );
      },
      idle: () {
        if (idleBuilder != null) {
          final Widget idleWidget = idleBuilder!.call(context);
          if (isSliver) {
            return SliverToBoxAdapter(child: idleWidget);
          }
          return idleWidget;
        }

        if (isSliver) {
          return const SliverToBoxAdapter();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
