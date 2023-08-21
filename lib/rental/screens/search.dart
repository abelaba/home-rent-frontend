import 'package:flutter/material.dart';


class CollapsibleSearchFilter extends StatefulWidget {
  final void Function({
    String? address,
    String? date,
    String? type,
    int? bedrooms,
    int? bathrooms,
    int? area,
    int? price,
  }) onFilterApplied;

  CollapsibleSearchFilter({required this.onFilterApplied});

  @override
  _CollapsibleSearchFilterState createState() =>
      _CollapsibleSearchFilterState();
}

class _CollapsibleSearchFilterState extends State<CollapsibleSearchFilter> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Colors.blueGrey,
              title: Text('Filter', style: TextStyle(color: Colors.white,),),
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              trailing: _isExpanded
                  ? Icon(Icons.keyboard_arrow_up)
                  : Icon(Icons.keyboard_arrow_down),
            ),
            if (_isExpanded)
              SearchFilterWidget(
                onFilterApplied: widget.onFilterApplied,
              ),
          ],
        ),
      ),
    );
  }
}

class SearchFilterWidget extends StatefulWidget {
  final void Function({
    String? address,
    String? date,
    String? type,
    int? bedrooms,
    int? bathrooms,
    int? area,
    int? price,
  }) onFilterApplied;

  SearchFilterWidget({required this.onFilterApplied});

  @override
  _SearchFilterWidgetState createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  String? address;
  String? date;
  String? type;
  int? bedrooms;
  int? bathrooms;
  int? area;
  int? price;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(labelText: 'Date'),
              onChanged: (value) {
                setState(() {
                  date = value;
                });
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(labelText: 'Type'),
              onChanged: (value) {
                setState(() {
                  type = value;
                });
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(labelText: 'Bedrooms'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  bedrooms = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(labelText: 'Bathrooms'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  bathrooms = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(labelText: 'Area'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  area = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  price = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onFilterApplied(
                  address: address,
                  date: date,
                  type: type,
                  bedrooms: bedrooms,
                  bathrooms: bathrooms,
                  area: area,
                  price: price,
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text('Apply Filters'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onFilterApplied(
                  address: null,
                  date: null,
                  type: null,
                  bedrooms: null,
                  bathrooms: null,
                  area: null,
                  price: null,
                );
              },
              child: Text('Clear Filters'),
            ),
          ],
        ),
      ),
    );
  }
}