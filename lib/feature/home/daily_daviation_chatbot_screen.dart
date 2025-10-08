import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widget/home/custom_app_bar.dart';

class DailyDaviationChatBot extends StatefulWidget {
  const DailyDaviationChatBot({super.key});

  @override
  State<DailyDaviationChatBot> createState() => _DailyDaviationChatBotState();
}

class _DailyDaviationChatBotState extends State<DailyDaviationChatBot> {
  final TextEditingController _controller = TextEditingController();
  final List<_Msg> _messages = [
    _Msg.time('10:15'),
    _Msg.bot(
      """Hello! I'd be happy to help with that. 😊
To get started, can you tell me what type of skin you have? You can choose from:
1. Oily
2. Dry
3. Combination
4. Sensitive
5. Normal""",
    ),
    _Msg.user('I think I have oily skin.'),
    _Msg.time('11:15'),
    _Msg.bot(
      "Got it! Oily skin means your skin tends to get shiny, especially in the T-zone (forehead, nose, chin). I can suggest a skincare routine to help manage that excess oil. Ready? 😉",
    ),
    _Msg.user("Yes, please! What should I start with?"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'Chatbot',
        onBack: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/home/daily.jpg',
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.4),
              colorBlendMode: BlendMode.srcOver,
            ),
          ),

          // Dim overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.25)),
          ),

          // Chat
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: kToolbarHeight + 8.h),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    itemCount: _messages.length,
                    itemBuilder: (_, i) {
                      final m = _messages[i];
                      if (m.type == _MsgType.time) {
                        return _TimeChip(text: m.text);
                      }
                      return Align(
                        alignment: m.type == _MsgType.user
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (m.type == _MsgType.bot) ...[
                                _BotAvatar(size: 22.w),
                                SizedBox(width: 6.w),
                              ],
                              _Bubble(
                                text: m.text,
                                isUser: m.type == _MsgType.user,
                              ),
                              if (m.type == _MsgType.user) SizedBox(width: 6.w),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Input bar (single pill with send icon inside)
                _InputBar(controller: _controller, onSend: _handleSend),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSend() {
    final txt = _controller.text.trim();
    if (txt.isEmpty) return;
    setState(() {
      _messages.add(_Msg.user(txt));
      _controller.clear();
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _messages.add(_Msg.bot('Thanks! I’ll tailor tips for: "$txt".'));
        });
      });
    });
  }
}

/// ====== Widgets ======

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  const _InputBar({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.w,left: 14.w,right: 14.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          height: 51.h,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.86),
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            cursorColor: Colors.black87,
            maxLines: 1,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: TextInputAction.send,
            onSubmitted: (_) => onSend(),
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              hintText: 'Aa',
              hintStyle: TextStyle(color: Colors.black38, fontSize: 14.sp),
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: BorderSide.none,
              ),
              suffixIconConstraints: BoxConstraints(minHeight: 40.h, minWidth: 40.w),
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: IconButton(
                  splashRadius: 20.r,
                  icon: Icon(Icons.send_rounded, size: 24.sp, color: Colors.black45),
                  onPressed: onSend,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final String text;
  final bool isUser;
  const _Bubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final bg = isUser ? const Color(0xFF3A3A3A) : null;
    final txtColor = isUser ? Colors.white : Colors.black87;

    return Container(
      constraints: BoxConstraints(maxWidth: 0.78.sw),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: bg,
        gradient: isUser
            ? null
            : LinearGradient(
          colors: [
            const Color(0xFFEDEFF2).withOpacity(0.92),
            const Color(0xFFD9DEE3).withOpacity(0.92),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.r),
          topRight: Radius.circular(14.r),
          bottomLeft: Radius.circular(isUser ? 14.r : 4.r),
          bottomRight: Radius.circular(isUser ? 4.r : 14.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, color: txtColor, height: 1.35),
      ),
    );
  }
}

class _TimeChip extends StatelessWidget {
  final String text;
  const _TimeChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(text, style: TextStyle(color: Colors.white70, fontSize: 11.sp)),
        ),
      ),
    );
  }
}

class _BotAvatar extends StatelessWidget {
  final double size;
  const _BotAvatar({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/home/bot.png'),
        ),
        border: Border.all(color: Colors.white, width: 1),
      ),
    );
  }
}

/// ====== Simple message model ======

enum _MsgType { bot, user, time }

class _Msg {
  final _MsgType type;
  final String text;
  _Msg._(this.type, this.text);
  factory _Msg.bot(String t) => _Msg._(_MsgType.bot, t);
  factory _Msg.user(String t) => _Msg._(_MsgType.user, t);
  factory _Msg.time(String t) => _Msg._(_MsgType.time, t);
}
