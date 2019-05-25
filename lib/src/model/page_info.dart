class FPageInfo {
  /// 是否下一页的数据
  final bool isNextPage;

  FPageInfo({bool isNextPage}) : this.isNextPage = isNextPage ?? false;
}

/// 分页数据
class FPageData<T> extends FPageInfo {
  final T data;

  FPageData({
    this.data,
    bool isNextPage,
  }) : super(isNextPage: isNextPage);
}

/// 分页列表数据
class FPageListData<T> extends FPageData<List<T>> {
  FPageListData({
    List<T> data,
    bool isNextPage,
  }) : super(
    data: data ?? [],
    isNextPage: isNextPage,
  );

  void fillList(List<T> list) {
    assert(list != null);

    if (!isNextPage) {
      list.clear();
    }

    list.addAll(data);
  }
}
