import 'dart:ui';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearching;
  final String title;
  final TextEditingController searchController;
  final VoidCallback? onSearchTap;
  final VoidCallback? onCloseSearch;
  final ValueChanged<String>? onSearchTextChanged;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.isSearching,
    required this.searchController,
    this.onSearchTap,
    this.onCloseSearch,
    this.onSearchTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isSearching ? null : _buildLeadingUpgrade(context),
      leadingWidth: 100,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: isSearching
          ? ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: onSearchTextChanged,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      hintText: 'Search...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(title, style: const TextStyle(color: Colors.white)),
      actions: [
        if (isSearching)
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: onCloseSearch,
          )
        else
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: onSearchTap,
          ),
      ],
    );
  }

  Widget _buildLeadingUpgrade(BuildContext context) {
    return GestureDetector(
        onTap: () {

        },
        child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 2),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  color: Colors.white.withOpacity(0.2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.lock, color: Colors.white, size: 15),
                      SizedBox(width: 4),
                      Text(
                        "Upgrade",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
