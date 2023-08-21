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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                tileColor: Colors.blueGrey,
                title: Text(
                  'Filter',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                trailing: _isExpanded
                    ? Icon(Icons.keyboard_arrow_up, color: Colors.white)
                    : Icon(Icons.keyboard_arrow_down, color: Colors.white),
              ),
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
            _buildTextField(
              labelText: 'Address',
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
            ),
            SizedBox(height: 16),
            _buildTextField(
              labelText: 'Date',
              onChanged: (value) {
                setState(() {
                  date = value;
                });
              },
            ),
            SizedBox(height: 16),
            _buildTextField(
              labelText: 'Type',
              onChanged: (value) {
                setState(() {
                  type = value;
                });
              },
            ),
            SizedBox(height: 16),
            _buildNumericTextField(
              labelText: 'Bedrooms',
              onChanged: (value) {
                setState(() {
                  bedrooms = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 16),
            _buildNumericTextField(
              labelText: 'Bathrooms',
              onChanged: (value) {
                setState(() {
                  bathrooms = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 16),
            _buildNumericTextField(
              labelText: 'Area',
              onChanged: (value) {
                setState(() {
                  area = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 16),
            _buildNumericTextField(
              labelText: 'Price',
              onChanged: (value) {
                setState(() {
                  price = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 32),
            Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
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
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        'Apply Filters',
        style: TextStyle(fontSize: 16),
      ),
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
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        'Clear Filters',
        style: TextStyle(fontSize: 16),
      ),
    ),
  ],
)

          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required void Function(String) onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildNumericTextField({
    required String labelText,
    required void Function(String) onChanged,
  }) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
