import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/product.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection des produits
  CollectionReference get _productsCollection => _db.collection('products');

  // Ajouter un produit
  Future<void> addProduct(Product product) async {
    try {
      await _productsCollection.doc(product.id).set(product.toMap());
    } catch (e) {
      print('Erreur lors de l\'ajout du produit: $e');
      throw e;
    }
  }

  // Récupérer tous les produits
  Stream<List<Product>> getProducts() {
    return _productsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Mettre à jour un produit
  Future<void> updateProduct(Product product) async {
    try {
      await _productsCollection.doc(product.id).update(product.toMap());
    } catch (e) {
      print('Erreur lors de la mise à jour du produit: $e');
      throw e;
    }
  }

  // Supprimer un produit
  Future<void> deleteProduct(String productId) async {
    try {
      await _productsCollection.doc(productId).delete();
    } catch (e) {
      print('Erreur lors de la suppression du produit: $e');
      throw e;
    }
  }
}
