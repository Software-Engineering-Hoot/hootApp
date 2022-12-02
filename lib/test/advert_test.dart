import 'package:test/test.dart';

void main() {
  group('Favorilerim Test', () {
    List<String> favorites = [];
    test('Favorilere ekleme', () {
      //1 rakamını ekliyoruz
      var number = "1";
      favorites.add(number);
      //Listenin içerisinde eklediğimiz sayıyı kontrol ediyoruz
      //expect metodu ile beklediğimiz sonucu kontrol ediyoruz
      expect(favorites.contains(number), true);
    });

    test('Favorilerden çıkarma', () {
      //Önce 2'rakamını ekleyip sonra çıkarıyoruz
      var number = "2";
      favorites.add(number);
      expect(favorites.contains(number), true);
      favorites.remove(number);
      expect(favorites.contains(number), false);
    });
  });
}
