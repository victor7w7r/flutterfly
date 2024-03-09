// ignore: one_member_abstracts
abstract class UseCase<Type, Params> {
  Future<Type> call({final Params params});
}
