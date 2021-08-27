import 'package:floor/floor.dart';

abstract class BaseDao<T>{
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertItem(T item);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateItem(T item);

  @delete
  Future<int> deleteItem(T item);
}