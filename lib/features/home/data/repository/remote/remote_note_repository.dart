import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../note_repository.dart';
import '../../models/note_model.dart';

class RemoteNoteRepository implements NoteRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _userId = FirebaseAuth.instance.currentUser?.uid;
  String _basicCollectionName = AppConstants.privateNotesStorage;
  String _secondaryCollectionName = AppConstants.notesStorage;
  @override
  Future<void> addNote(NoteModel noteModel) async {
    try {
      await _firestore
          .collection(_basicCollectionName)
          .doc(_userId)
          .collection(_secondaryCollectionName)
          .doc(noteModel.id)
          .set(noteModel.toJson(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      debugPrint("FirebaseException on addNote from RemNoteRepo: ${e.code}");
      rethrow;
    } on Exception catch (e) {
      debugPrint("Exception on addNote from RemNoteRepo: $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteAllNotes() async {
    try {
      await _firestore
          .collection(_basicCollectionName)
          .doc(_userId)
          .collection(_secondaryCollectionName)
          .get()
          .then((snapshot) =>
              snapshot.docs.forEach((doc) => doc.reference.delete()));
    } on FirebaseException catch (e) {
      debugPrint(
          "FirebaseException on deleteAllNotes from RemNoteRepo: ${e.code}");
      rethrow;
    } on Exception catch (e) {
      debugPrint("Exception on deleteAllNotes from RemNoteRepo: $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    try {
      await _firestore
          .collection(_basicCollectionName)
          .doc(_userId)
          .collection(_secondaryCollectionName)
          .doc(id)
          .delete();
    } on FirebaseException catch (e) {
      debugPrint("FirebaseException on deleteNote from RemNoteRepo: ${e.code}");
      rethrow;
    } on Exception catch (e) {
      debugPrint("Exception on deleteNote from RemNoteRepo: $e");
      rethrow;
    }
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    try {
      var snapshot = await _firestore
          .collection(_basicCollectionName)
          .doc(_userId)
          .collection(_secondaryCollectionName)
          .orderBy("created_at", descending: true)
          .get();

      var notes =
          snapshot.docs.map((e) => NoteModel.fromJson(e.data())).toList();

      return notes;
    } on FirebaseException catch (e) {
      debugPrint("FirebaseException on getNotes from RemNoteRepo: ${e.code}");
      rethrow;
    } on Exception catch (e) {
      debugPrint("Exception on getNotes from RemNoteRepo: $e");
      rethrow;
    }
  }

  @override
  Future<void> updateNote(String id, NoteModel noteModel) async {
    try {
      await _firestore
          .collection(_basicCollectionName)
          .doc(_userId)
          .collection(_secondaryCollectionName)
          .doc(noteModel.id)
          .set(noteModel.toJson(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      debugPrint("FirebaseException on updateNote from RemNoteRepo: ${e.code}");
      rethrow;
    } on Exception catch (e) {
      debugPrint("Exception on updateNote from RemNoteRepo: $e");
      rethrow;
    }
  }
}
