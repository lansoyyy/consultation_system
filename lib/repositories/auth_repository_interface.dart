abstract class AuthRepositoryInterface {
  userSignUp(
      String firstName,
      String middleName,
      String surName,
      String contactNumber,
      String email,
      String password,
      String uid,
      String course);

  Future<List<void>?> loginOfuser(String email, password);
}
