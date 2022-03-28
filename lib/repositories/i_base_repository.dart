abstract class IBaseRepository<TModel> {
  Future<List<TModel>> getAll();

  Future<String> add(TModel model);

  Future<TModel?> get(String id);
}
