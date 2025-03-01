import 'package:flutter/material.dart';

class DraggableOptionCard extends StatelessWidget {
  const DraggableOptionCard({
    super.key,
    required this.optionTitle,
    required this.onOptionTriggered,
  });

  final String optionTitle;
  final Function onOptionTriggered;

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: optionTitle,
      onDragCompleted: () {
        onOptionTriggered();
      },
      feedback: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            optionTitle,
            style:
                const TextStyle(decoration: TextDecoration.none, fontSize: 16),
          ),
        ),
      ),
      childWhenDragging: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 10),
        constraints: const BoxConstraints(minHeight: 60),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              optionTitle,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.blueGrey.shade600),
            )),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.drag_handle,
              color: Theme.of(context).primaryColor,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
