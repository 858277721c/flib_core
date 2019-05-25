class FCommonResult<S> {
  final bool success;
  final S successData;
  final dynamic failData;

  FCommonResult.success(this.successData)
      : this.success = true,
        this.failData = null;

  FCommonResult.fail(this.failData)
      : this.success = false,
        this.successData = null;
}
