class APIPath {
  static String child(String uid, String childId) =>
      'users/$uid/child/$childId';

  static String children(String uid) => 'users/$uid/child/';

  static String notifications(String uid, String timestamp) =>
      'users/$uid/notifications/$timestamp';

  static String notificationsStream(String uid, String childId) =>
      'users/$uid/notifications/';

  static String mail() => 'mail/';
  static String deviceToken() => 'DeviceTokens/';
}
