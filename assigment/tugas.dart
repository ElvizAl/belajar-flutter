enum StatusAkun {

  active,

  blocked,

}



enum StatusTransaksi {

  berhasil,

  gagal,

}



class User {

  String nama;

  String pin;

  double saldo;

  double totalTransaksiHarian;

  int jumlahPinSalah;

  StatusAkun statusAkun;



  User({

    required this.nama,

    required this.pin,

    required this.saldo,

    this.totalTransaksiHarian = 0,

    this.jumlahPinSalah = 0,

    this.statusAkun = StatusAkun.active,

  });

}



class EWallet {

  static const double limitHarian = 2000000;

  static const int maxPinSalah = 3;




  bool cekStatusAkun(User user) {

    return user.statusAkun == StatusAkun.active;

  }



  bool validasiPin(User user, String inputPin) {

    if (inputPin == user.pin) {

      user.jumlahPinSalah = 0;

      return true;

    }



    tambahPercobaanPin(user);



    if (user.jumlahPinSalah >= maxPinSalah) {

      blokirAkun(user);

    }



    return false;

  }




  void tambahPercobaanPin(User user) {

    user.jumlahPinSalah++;

  }




  void blokirAkun(User user) {

    user.statusAkun = StatusAkun.blocked;

  }




  bool cekSaldo(User user, double nominal) {

    return user.saldo >= nominal;

  }



  

  bool cekLimitHarian(User user, double nominal) {

    return user.totalTransaksiHarian + nominal <= limitHarian;

  }




  void kurangiSaldo(User user, double nominal) {

    user.saldo -= nominal;

  }




  void updateTransaksiHarian(User user, double nominal) {

    user.totalTransaksiHarian += nominal;

  }




  StatusTransaksi prosesPembayaran(

    User user,

    double nominal,

    String inputPin,

  ) {

    print("\n=== PROSES PEMBAYARAN ===");



    // Validasi nominal

    if (nominal <= 0) {

      print("Nominal transaksi tidak valid.");

      return StatusTransaksi.gagal;

    }



    // BR-06

    if (!cekStatusAkun(user)) {

      print("Transaksi gagal.");

      print("Akun telah diblokir.");

      return StatusTransaksi.gagal;

    }



    // BR-03, BR-04, BR-05

    if (!validasiPin(user, inputPin)) {

      print("PIN salah.");



      if (user.statusAkun == StatusAkun.blocked) {

        print("PIN salah 3 kali.");

        print("Akun diblokir.");

      } else {

        int sisaPercobaan = maxPinSalah - user.jumlahPinSalah;

        print("Sisa percobaan PIN: $sisaPercobaan");

      }



      return StatusTransaksi.gagal;

    }




    if (!cekSaldo(user, nominal)) {

      print("Transaksi gagal.");

      print("Saldo tidak mencukupi.");

      return StatusTransaksi.gagal;

    }




    if (!cekLimitHarian(user, nominal)) {

      print("Transaksi gagal.");

      print("Limit transaksi harian Rp2.000.000 terlampaui.");

      return StatusTransaksi.gagal;

    }



    // BR-08

    kurangiSaldo(user, nominal);



    // BR-09

    updateTransaksiHarian(user, nominal);



    print("Transaksi berhasil.");

    print("Nominal: Rp${nominal.toStringAsFixed(0)}");

    print("Sisa saldo: Rp${user.saldo.toStringAsFixed(0)}");

    print(

      "Total transaksi hari ini: "

      "Rp${user.totalTransaksiHarian.toStringAsFixed(0)}",

    );



    return StatusTransaksi.berhasil;

  }



  void tampilkanDataUser(User user) {

    print("\n=== DATA E-WALLET ===");

    print("Nama                 : ${user.nama}");

    print("Saldo                : Rp${user.saldo.toStringAsFixed(0)}");

    print(

      "Transaksi hari ini   : "

      "Rp${user.totalTransaksiHarian.toStringAsFixed(0)}",

    );

    print("PIN salah            : ${user.jumlahPinSalah}");

    print("Status akun          : ${user.statusAkun.name}");

  }

}



void main() {



  User user = User(

    nama: "Olivia",

    pin: "123456",

    saldo: 3000000,

  );



  // Membuat E-Wallet

  EWallet eWallet = EWallet();



  eWallet.tampilkanDataUser(user);



  eWallet.prosesPembayaran(

    user,

    500000,

    "123456",

  );

  

  eWallet.prosesPembayaran(

    user,

    500000,

    "123456",

  );

  

  eWallet.tampilkanDataUser(user);

  

  //salah pin ya

  eWallet.prosesPembayaran(

    user,

    200000,

    "123436",

  );

  

  eWallet.prosesPembayaran(

    user,

    200000,

    "123856",

  );

  

  eWallet.prosesPembayaran(

    user,

    200000,

    "123856",

  );

 

  eWallet.tampilkanDataUser(user);



 





}