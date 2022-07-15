import 'package:common_widgets_flutter/common_widgets_flutter.dart';
import 'package:flutter/material.dart';

/// {@template expandable_search}
/// An expandable search that fills up the entire page with autocomplete
/// Eg. PlayStore search bar
/// {@endtemplate}
class ExpandableSearch extends StatefulWidget {
  /// {@macro expandable_search}
  const ExpandableSearch({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.searchItems = const <ExpandableSearchItem>[
      ExpandableSearchItem(title: 'This', value: 'this'),
      ExpandableSearchItem(title: 'is', value: 'is'),
      ExpandableSearchItem(title: 'a', value: 'a'),
      ExpandableSearchItem(title: 'test', value: 'test'),
      ExpandableSearchItem(title: 'result', value: 'result'),
    ],
  });

  /// Hint text in search field
  final String? hintText;

  /// Prefix Icon for the search field
  final Widget? prefixIcon;

  /// Suffix Icon for the search field
  final Widget? suffixIcon;

  /// List of results
  final List<ExpandableSearchItem> searchItems;

  @override
  State<ExpandableSearch> createState() => _ExpandableSearchState();
}

class _ExpandableSearchState extends State<ExpandableSearch> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showSearch<String?>(
          context: context,
          delegate: _SearchDelegate(data: widget.searchItems),
          query: textEditingController.text,
        ).then((value) {
          setState(() {
            textEditingController.text = value ?? '';
          });
        });
      },
      child: IgnorePointer(
        child: TextFormField(
          key: const Key('searchInput_textFormField'),
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Search',
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (String value) {},
          onChanged: (String value) {},
        ),
      ),
    );
  }
}

class _SearchDelegate extends SearchDelegate<String?> {
  _SearchDelegate({required this.data});

  final List<ExpandableSearchItem> _history = <ExpandableSearchItem>[
    const ExpandableSearchItem(title: 'This', value: 'this'),
    const ExpandableSearchItem(title: 'is', value: 'is'),
    const ExpandableSearchItem(title: 'a', value: 'a'),
    const ExpandableSearchItem(title: 'test', value: 'test'),
    const ExpandableSearchItem(title: 'result', value: 'result'),
  ];

  final List<ExpandableSearchItem> data;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty)
        const SizedBox.shrink()
      else
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = data.where(
      (ExpandableSearchItem value) => value.title.toLowerCase().startsWith(
            query.toLowerCase(),
          ),
    );
    if (suggestions.isEmpty) {
      return Center(
        child: Text(
          'Could not find "$query"\n.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return _SuggestionList(
      query: query,
      suggestions:
          suggestions.map((ExpandableSearchItem value) => value.title).toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        // showResults(context);
        close(context, query);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? _history
        : data.where(
            (ExpandableSearchItem value) =>
                value.title.toLowerCase().startsWith(
                      query.toLowerCase(),
                    ),
          );

    return _SuggestionList(
      query: query,
      suggestions:
          suggestions.map((ExpandableSearchItem value) => value.title).toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        // showResults(context);
        close(context, query);
      },
    );
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({
    required this.suggestions,
    required this.query,
    required this.onSelected,
  });

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        final suggestion = suggestions[index];
        return ListTile(
          leading: query.isEmpty
              ? const Icon(Icons.history)
              : const Icon(Icons.search_outlined),
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          trailing: query.isEmpty
              ? const Icon(null)
              : const Icon(Icons.north_west_outlined),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
