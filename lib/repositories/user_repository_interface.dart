abstract class UsertRepositoryInterface {
  Future addUser(
      String firstName,
      String middleName,
      String surName,
      String contactNumber,
      String uid,
      String email,
      String password,
      String course);
}
