class FPageData<T> {
  final T data;

  /// 是否下一页的数据
  final bool isNextPage;

  FPageData({
    this.data,
    this.isNextPage = false,
  }) : assert(isNextPage != null);
}
