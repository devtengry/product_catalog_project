import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBar extends ConsumerStatefulWidget {
  const SearchBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBarrState();
}

class _SearchBarrState extends ConsumerState<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        prefixIcon: Icon(
          Icons.search,
        ),
        label: Text(
          'Search',
        ),
        suffixIcon: Icon(
          Icons.settings_input_composite_outlined,
        ),
      ),
    );
  }
}
