## NIHAOO


void main() {
  print("HEIII ANTEK ANTEK ASYNC");
  print("hello world");

  String? name = "john Doe";
  print(name);

  int jumlah = 10;
  print(jumlah);
  // nilai

  bool isLogin = true;
  print(isLogin);

  String? beliMinuman;

  beliMinuman = "esteh solo";

  beliMinuman = null;

  String minumanKu = beliMinuman ?? 'es jeruk bali';

  print(minumanKu);
  
  List<String> namaMotor = [
    "supra bapak",
    "beat mberrr",
    "cb celeng",
  ];
  
  print(namaMotor[0]);
  print(namaMotor[1]);
  print(namaMotor[2]);
  
  Set<String> namaMobil = {
    "biemdobel u",
    "supra stututu",
    "lamboghini",
  };
  
  namaMobil.add("MOBIL ESEMKA");
  namaMobil.add("MOBIL ESEMKA"); // saya bisa satu gabisa duplikat
  
  print(namaMobil);
  
  
  Map<String, dynamic> namaPresiden = {
    "nama": "soekarno",
    "jabatan": "presiden pertama",
    "hobi": "Mancing",
  };
  
  print(namaPresiden["nama"]);
  
}
