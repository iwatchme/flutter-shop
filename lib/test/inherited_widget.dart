import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item {
  String reference;

  Item(this.reference);
}

class _MyInherited extends InheritedWidget {
  _MyInherited({Key key, @required Widget child, @required this.data})
      : super(key: key, child: child);

  final _MyInheritatWidgetState data;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    print("updateShouldNotify");
    return true;
  }
}

class MyInheritatWidget extends StatefulWidget {
  MyInheritatWidget({Key key, this.child}) : super(key: key);

  Widget child;

  @override
  _MyInheritatWidgetState createState() => _MyInheritatWidgetState();

  static _MyInheritatWidgetState of(
      [BuildContext context, bool rebuild = true]) {
    return rebuild
        ? (context.inheritFromWidgetOfExactType(_MyInherited) as _MyInherited)
            .data
        : (context.ancestorWidgetOfExactType(_MyInherited) as _MyInherited);
  }
}

class _MyInheritatWidgetState extends State<MyInheritatWidget> {
  List<Item> _items = <Item>[];

  /// Getter (number of items)
  int get itemsCount => _items.length;

  /// Helper method to add an Item
  void addItem(String reference) {
    setState(() {
      _items.add(new Item(reference));
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Frank,_MyInheritatWidgetState build ");
    return _MyInherited(data: this, child: widget.child);
  }
}

class MyTree extends StatefulWidget {
  @override
  _MyTreeState createState() => new _MyTreeState();
}

class _MyTreeState extends State<MyTree> {
  @override
  Widget build(BuildContext context) {
    return MyInheritatWidget(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Title'),
        ),
        body: new Column(
          children: <Widget>[
            new WidgetA(),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Icon(Icons.shopping_cart),
                  new WidgetB(),
                  new WidgetC(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Frank WidgetA build");
    final _MyInheritatWidgetState state = MyInheritatWidget.of(context);
    return new Container(
      child: new RaisedButton(
        child: new Text('Add Item'),
        onPressed: () {
          state.addItem('new item');
        },
      ),
    );
  }
}

class WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Frank WidgetA build");
    final _MyInheritatWidgetState state = MyInheritatWidget.of(context);
    return new Text('${state.itemsCount}');
  }
}

class WidgetC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Text('I am Widget C');
  }
}

void main(List<String> args) {
  runApp(MaterialApp(
    home: MyTree(),
  ));
}
