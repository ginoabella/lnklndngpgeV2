import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lnk_lndng_pge_v2/model/link_data.dart';
import 'package:provider/provider.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    Key key,
    @required this.document,
  }) : super(key: key);

  final LinkData document;

  @override
  Widget build(BuildContext context) {
    final _linksCollection = Provider.of<CollectionReference>(context);
    final _formKey = GlobalKey<FormState>();
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            TextEditingController _titleTextController = TextEditingController(
              text: document.title,
            );
            TextEditingController _urlTextController = TextEditingController(
              text: document.url,
            );
            return AlertDialog(
              title: Text('Edit ${document.title} button'),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty ? 'Please add in a title' : null;
                      },
                      controller: _titleTextController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Facebook',
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        return value.isEmpty ? 'Please add in a url' : null;
                      },
                      controller: _urlTextController,
                      decoration: InputDecoration(
                        labelText: 'Link',
                        hintText: 'facebook.com/my-user-name',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    final userUpdateForm =
                        (document.title != _titleTextController.text) ||
                            (document.url != _urlTextController.text);
                    if (_formKey.currentState.validate()) {
                      if (userUpdateForm) {
                        final newlinkData = LinkData(
                          title: _titleTextController.text,
                          url: _urlTextController.text,
                        );
                        _linksCollection.doc(document.id).update(
                              newlinkData.toMap(),
                            );
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Edit'),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
