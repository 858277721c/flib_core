class FPageInfo {
  /// 是否下一页的数据
  final bool isNextPage;

  FPageInfo({this.isNextPage = false}) : assert(isNextPage != null);
}

/// 分页数据
class FPageData<T> extends FPageInfo {
  final T data;

  FPageData({
    this.data,
    bool isNextPage = false,
  }) : super(isNextPage: isNextPage);
}

/// 分页列表数据
class FPageListData<T> extends FPageData<List<T>> {
  FPageListData({
    List<T> data,
    bool isNextPage = false,
  }) : super(
          data: data ?? [],
          isNextPage: isNextPage,
        );
}
