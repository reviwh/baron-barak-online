import 'package:flutter/material.dart';
import 'package:reservasi/main.dart';

class Barak {
  final idBarak, namaBarak, jumlahMeja, mejaTersedia;
  Barak({
    required this.idBarak,
    required this.namaBarak,
    required this.jumlahMeja,
    required this.mejaTersedia,
  });

  factory Barak.fromJson(Map<String, dynamic> json) {
    return Barak(
      idBarak: json['id_penjual'],
      jumlahMeja: json['jumlah_meja'],
      mejaTersedia: json['meja_tersedia'],
      namaBarak: json['nama'],
    );
  }
}

class Meja {
  final idMeja, idPenjual, status;
  Meja({
    required this.idMeja,
    required this.idPenjual,
    required this.status,
  });
  factory Meja.fromJson(Map<String, dynamic> json) {
    return Meja(
      idMeja: json['id_meja'],
      idPenjual: json['id_penjual'],
      status: json['status_meja'],
    );
  }
}

class Menu {
  final String idMenu;
  final String namaMenu;
  final String harga;
  final String penjual;
  final String image;
  final String idPenjual;
  final String qty;

  Menu({
    required this.idMenu,
    required this.namaMenu,
    required this.harga,
    required this.penjual,
    required this.image,
    required this.idPenjual,
    required this.qty,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      idMenu: json['id_menu'],
      namaMenu: json['nama_menu'],
      harga: MyApp.getIDR(int.parse(json['harga'])),
      penjual: json['nama'],
      image: json['menu_image'],
      idPenjual: json['id_penjual'],
      qty: json['qty'],
    );
  }
}

class User {
  String username;
  String kategori;

  User({
    required this.username,
    required this.kategori,
  });

  String getUsername() {
    return this.username;
  }

  String getKategori() {
    return this.kategori;
  }

  void setUsername(username) {
    this.username = username;
  }

  void setKategori(kategori) {
    this.kategori = kategori;
  }
}

class CartItem {
  final String idKeranjang;
  final String idMenu;
  final String namaMenu;
  final String qty;
  final String idPelanggan;
  final String idPenjual;
  final String harga;
  final String image;

  CartItem({
    required this.idKeranjang,
    required this.idMenu,
    required this.namaMenu,
    required this.qty,
    required this.idPelanggan,
    required this.idPenjual,
    required this.harga,
    required this.image,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      idKeranjang: json['id_keranjang'],
      idMenu: json['id_menu'],
      namaMenu: json['nama_menu'],
      qty: json['qty'],
      idPelanggan: json['id_pelanggan'],
      idPenjual: json['id_penjual'],
      harga: MyApp.getIDR(int.parse(json['harga'])),
      image: json['image'],
    );
  }
}

class Pelanggan {
  final String nama, jurusan, prodi, profileImage, telepon, email;
  Pelanggan({
    required this.nama,
    required this.jurusan,
    required this.prodi,
    required this.profileImage,
    required this.telepon,
    required this.email,
  });
}

class Penjual {
  final id, nama, pemilik, noTelp, alamat, rekBri, saldo;
  Penjual({
    required this.id,
    required this.nama,
    required this.pemilik,
    required this.noTelp,
    required this.alamat,
    required this.rekBri,
    required this.saldo,
  });
}

class Order {
  String total;
  String nama;
  String idMeja;
  String tanggal;
  List<Menu> menus;

  Order({
    required this.total,
    required this.nama,
    required this.idMeja,
    required this.tanggal,
    required this.menus,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    List<Menu> menus = [];
    for (int i = 0; i < json.length - 4; i++) {
      menus.add(Menu.fromJson(json[i.toString()]));
    }

    return Order(
      total: MyApp.getIDR(json['total']),
      nama: json['nama_pelanggan'],
      idMeja: json['id_meja'],
      tanggal: json['tanggal'],
      menus: menus,
    );
  }
}

class UnorderedTable {
  String id;
  UnorderedTable({required this.id});
  factory UnorderedTable.fromJson(Map<String, dynamic> json) {
    return UnorderedTable(
      id: json['id_meja'],
    );
  }
}
