import 'package:flutter/material.dart';
import 'package:job_application/widgets/mainlayout.dart';

class MobileCombinedChatPage extends StatelessWidget {
  const MobileCombinedChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 4,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER (WhatsApp style)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Chats',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  buildIconButton(Icon(Icons.add_circle_outline), "New", () {}),
                ],
              ),

              const SizedBox(height: 10),

              /// SEARCH BAR
              TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),

              const SizedBox(height: 12),

              /// CHAT LIST (WhatsApp style)
              Expanded(
                child: ListView.separated(
                  itemCount: _demoChats.length,
                  separatorBuilder: (_, _) => Divider(
                    height: 0,
                    thickness: 0.8,
                    color: Colors.grey.shade300,
                  ),
                  itemBuilder: (context, i) {
                    final c = _demoChats[i];
                    return InkWell(
                      onTap: () {
                        // Navigate to chat screen
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.blue.shade100,
                              child: const Icon(
                                Icons.person,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 12),

                            /// NAME + MESSAGE PREVIEW
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    c.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    c.preview,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 8),

                            /// TIME + UNREAD BADGE
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  c.time,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                if (c.unread > 0)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "${c.unread}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// CHAT MODEL
class _Chat {
  final String title;
  final String preview;
  final String time;
  final int unread;
  const _Chat(this.title, this.preview, this.time, this.unread);
}

/// SAMPLE DATA
const _demoChats = <_Chat>[
  _Chat('John', 'Hey! Are you free now?', '10:02', 1),
  _Chat('Team Standup', 'We start in 2 mins', '09:35', 0),
  _Chat('Client', 'Approved latest design', 'Yesterday', 2),
  _Chat('Friends Group', 'Plan for tonight?', 'Yesterday', 3),
  _Chat('Design Lead', 'UI changes updated.', 'Mon', 0),
  _Chat('Backend', 'API deployed.', 'Sun', 0),
];

Widget buildIconButton(Icon icon, String title, VoidCallback onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        const SizedBox(height: 4), // small gap
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
