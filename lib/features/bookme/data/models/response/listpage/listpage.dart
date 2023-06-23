class ListPage<T> {
  ListPage({
    required this.grandTotalCount,
    required this.itemList,
  });

  factory ListPage.empty() => ListPage<T>(
    grandTotalCount: 0,
    itemList: <T>[],
  );

  final int grandTotalCount;
  final List<T> itemList;



  bool isLastPage(int previouslyFetchedItemsCount) {
    if(itemList.isEmpty) {
      return true;
    }
    final int newItemsCount = itemList.length;
    final int totalFetchedItemsCount =
        previouslyFetchedItemsCount + newItemsCount;
    return totalFetchedItemsCount == grandTotalCount;
  }
}
