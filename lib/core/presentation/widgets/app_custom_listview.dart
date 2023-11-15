import 'package:flutter/material.dart';

import '../../errors/failure.dart';

class AppCustomListView<T> extends StatefulWidget {
  const AppCustomListView(
      {required this.items,
      this.failure,
      required this.onRefresh,
      required this.errorIndicatorBuilder,
      required this.itemBuilder,
      required this.emptyListIndicatorBuilder,
        this.optionalEmptyListChecker,
      super.key});

  final Failure? failure;
  final List<T> items;
  final VoidCallback onRefresh;
  final Widget errorIndicatorBuilder;
  final Widget emptyListIndicatorBuilder;
  final bool? optionalEmptyListChecker;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  _AppCustomListViewState<T> createState() => _AppCustomListViewState<T>();
}

class _AppCustomListViewState<T> extends State<AppCustomListView<T>> {
  @override
  Widget build(BuildContext context) {
    final String message = widget.failure?.message ?? '';
    final bool isEmpty = widget.optionalEmptyListChecker ?? false;
    return message.isNotEmpty
        ? widget.errorIndicatorBuilder
        : RefreshIndicator(
            onRefresh: () => Future<void>.sync(() {
               widget.onRefresh();
            }),
            notificationPredicate: (_) => true,
            child: widget.items.isEmpty || isEmpty
                ? ListView(
                    children: <Widget>[
                      widget.emptyListIndicatorBuilder,
                    ],
                  )
                : ListView.builder(
                    itemCount: widget.items.length,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    // shrinkWrap: true,
                    itemBuilder: widget.itemBuilder,
                  ),
          );
  }
}
