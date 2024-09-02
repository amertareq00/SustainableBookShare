import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  final List<String> options;
  final String? selectedOption;
  final void Function(String?)? onChanged;
  final String? hintText;
  final Widget? prefixIcon;

  const CustomDropdownMenu({
    Key? key,
    required this.options,
    this.selectedOption,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      width: 320.0,
      height: 55.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0x00FFFEFE).withOpacity(0.9),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedOption,
        onChanged: onChanged,
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: TextStyle(
                color: Color(0x000000).withOpacity(0.9),
                fontSize: 18.0,
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0x000000).withOpacity(0.9),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.0,
          ),
        ),
        style: TextStyle(
          color: Color(0x000000).withOpacity(0.9),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        dropdownColor: Color(0x00FFFEFE).withOpacity(0.9),
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 30,
        isExpanded: true,
      ),
    );
  }
}

/* import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<String> options;
  final String? selectedOption;
  final void Function(String?)? onChanged;
  final String? hintText;
  final Widget? prefixIcon;
  final TextEditingController? controller; // Added controller parameter

  const CustomDropdownMenu({
    Key? key,
    required this.options,
    this.selectedOption,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
    this.controller, // Added controller parameter
  }) : super(key: key);

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.selectedOption);
  }

  @override
  void dispose() {
    // Dispose the controller only if it was created internally
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      width: 320.0,
      height: 55.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0x00FFFEFE).withOpacity(0.9),
      ),
      child: DropdownButtonFormField<String>(
        value: _controller.text.isNotEmpty ? _controller.text : null,
        onChanged: (String? newValue) {
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
          setState(() {
            _controller.text = newValue!;
          });
        },
        items: widget.options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: TextStyle(
                color: Color(0x000000).withOpacity(0.9),
                fontSize: 18.0,
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Color(0x000000).withOpacity(0.9),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
          prefixIcon: widget.prefixIcon,
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.0,
          ),
        ),
        style: TextStyle(
          color: Color(0x000000).withOpacity(0.9),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        dropdownColor: Color(0x00FFFEFE).withOpacity(0.9),
        //elevation: 10,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 30,
        isExpanded: true,
      ),
    );
  }
}
 */


/* import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  final List<String> options;
  final String? selectedOption;
  final void Function(String?)? onChanged;
  final String? hintText;
  final Widget? prefixIcon;
  final TextEditingController? controller;

  const CustomDropdownMenu({
    Key? key,
    required this.options,
    this.selectedOption,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? _selectedOption = selectedOption;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color(0x00FFFEFE).withOpacity(0.9),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedOption,
        onChanged: (String? newValue) {
          if (onChanged != null) {
            onChanged!(newValue);
          }
        },
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: TextStyle(
                color: Color(0x000000).withOpacity(0.9),
                fontSize: 18.0,
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0x000000).withOpacity(0.9),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.0,
          ),
        ),
        style: TextStyle(
          color: Color(0x000000).withOpacity(0.9),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        dropdownColor: Color(0x00FFFEFE).withOpacity(0.9),
        elevation: 1,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 30,
        isExpanded: true,
      ),
    );
  }
}
 */

/* import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<String> options;
  final String? selectedOption;
  final void Function(String?)? onChanged;
  final String? hintText;
  final Widget? prefixIcon;

  const CustomDropdownMenu({
    Key? key,
    required this.options,
    this.selectedOption,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
  }) : super(key: key);

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color(0x00FFFEFE).withOpacity(0.9),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedOption,
        onChanged: (String? newValue) {
          setState(() {
            _selectedOption = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
        items: widget.options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: TextStyle(
                color: Color(0x000000).withOpacity(0.9),
                fontSize: 18.0,
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Color(0x000000).withOpacity(0.9),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
          prefixIcon: widget.prefixIcon,
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.0,
          ),
        ),
        style: TextStyle(
          color: Color(0x000000).withOpacity(0.9),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        dropdownColor: Color(0x00FFFEFE).withOpacity(0.9),
        elevation: 1,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 30,
        isExpanded: true,
      ),
    );
  }
} */

/* import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<String> options;
  final String? selectedOption;
  final void Function(String?)? onChanged;
  final String? hintText;
  final Widget? prefixIcon;

  const CustomDropdownMenu({
    Key? key,
    required this.options,
    this.selectedOption,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
  }) : super(key: key);

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color(0x00FFFEFE).withOpacity(0.9),
      ),
      child: PopupMenuButton<String>(
        initialValue: _selectedOption,
        itemBuilder: (BuildContext context) {
          return widget.options.map((String option) {
            return PopupMenuItem<String>(
              value: option,
              child: Text(
                option,
                style: TextStyle(
                  color: Color(0x000000).withOpacity(0.9),
                  fontSize: 18.0,
                ),
              ),
            );
          }).toList();
        },
        onSelected: (String value) {
          setState(() {
            _selectedOption = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedOption ?? widget.hintText ?? 'Choose an option',
                style: TextStyle(
                  color: Color(0x000000).withOpacity(0.9),
                  fontSize: 18.0,
                ),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
 */

/* import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<String> options;
  final String? selectedOption;
  final void Function(String?)? onChanged;
  final String? hintText;
  final Widget? prefixIcon;

  const CustomDropdownMenu({
    Key? key,
    required this.options,
    this.selectedOption,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
  }) : super(key: key);

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color(0x00FFFEFE).withOpacity(0.9),
      ),
      child: PopupMenuButton<String>(
        initialValue: _selectedOption,
        offset: Offset(0, 100), // Adjust the offset to position the menu below
        itemBuilder: (BuildContext context) {
          return widget.options.map((String option) {
            return PopupMenuItem<String>(
              value: option,
              child: Container(
                // Wrap the child in a container to set width
                width: 300, // Set width to 300
                child: Text(
                  option,
                  style: TextStyle(
                    color: Color(0x000000).withOpacity(0.9),
                    fontSize: 18.0,
                  ),
                ),
              ),
            );
          }).toList();
        },
        onSelected: (String value) {
          setState(() {
            _selectedOption = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedOption ?? widget.hintText ?? 'Choose an option',
                style: TextStyle(
                  color: Color(0x000000).withOpacity(0.9),
                  fontSize: 18.0,
                ),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
 */