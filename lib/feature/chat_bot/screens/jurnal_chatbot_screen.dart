import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:skincare/feature/chat_bot/controller/chat_bot_controller.dart';
import 'package:skincare/feature/chat_bot/models/chat_history_model.dart';

import '../../../widget/home/custom_app_bar.dart';


class JurnalChatBot extends StatefulWidget {
  const JurnalChatBot({super.key});

  @override
  State<JurnalChatBot> createState() => _JurnalChatBotState();
}

class _JurnalChatBotState extends State<JurnalChatBot> {
  final TextEditingController _controller = TextEditingController();
  final ChatBotController chatBotController = Get.put(ChatBotController());
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    final type = Get.arguments ?? "skincare";
    chatBotController.botType.value = type;

    chatBotController.loadHistory();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }
  @override
  Widget build(BuildContext context) {

    // Get background image based on bot type
      String bgImage;
      switch (chatBotController.botType.value) {
        case "skincare":
          bgImage = 'assets/images/home/skincarechatbot.jpg';
          break;
        case "daily_devotion":
          bgImage = 'assets/images/home/daily.jpg';
          break;
        case "meal_plan":
          bgImage = 'assets/images/home/airecipe.jpg';
          break;
        case "journal":
          bgImage = 'assets/images/home/jurnal.jpg';
          break;
        default:
          bgImage = 'assets/images/home/jurnal.jpg';
      }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'Chatbot',
        onBack: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              bgImage,
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.5),
              colorBlendMode: BlendMode.srcOver,
            ),
          ),

          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.25)),
          ),

          SafeArea(
            child: Column(
              children: [
                /// CHAT LIST
                Expanded(
                  child: Obx(() {
                    final chats = chatBotController.chatHistory;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });

                    if (chatBotController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 12.h),
                      itemCount: chats.length,
                      itemBuilder: (_, i) {
                        final m = chats[i];

                        final isUser = m.role == "user";

                        return Align(
                          alignment: isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.h),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (!isUser) ...[
                                  _BotAvatar(size: 35.w),
                                  SizedBox(width: 6.w),
                                ],
                                _Bubble(
                                  text: m.message ?? "",
                                  isUser: isUser,
                                ),
                                if (isUser) SizedBox(width: 6.w),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),

                /// INPUT
                _InputBar(
                  controller: _controller,
                  onSend: _handleSend,
                  chatBotController: chatBotController,
                ),

                SizedBox(height: 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// SEND MESSAGE
  void _handleSend() {
    final txt = _controller.text.trim();
    if (txt.isEmpty) return;

    /// instantly UI te add
    chatBotController.chatHistory.add(
      ChatHistoryModel(
        role: "user",
        message: txt,
      ),
    );

    _controller.clear();
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);

    chatBotController.sendMassage(
      txt,
    ).then((botReply) {
      if (botReply != null) {
        chatBotController.chatHistory.add(
          ChatHistoryModel(
            role: "bot",
            message: botReply,
          ),
        );
      }
    }
    );
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }
}

/// ====== Widgets ======

class _InputBar extends StatelessWidget {
  final ChatBotController chatBotController;
  final TextEditingController controller;
  final VoidCallback onSend;
  const _InputBar({required this.controller, required this.onSend, required this.chatBotController});

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
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h,),
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
                child: Obx(() => IconButton(
                  splashRadius: 20.r,
                  icon: chatBotController.isGeneratingResponse.value
                      ? SizedBox(
                    width: 16.w,
                    height: 16.h,
                    child: CircularProgressIndicator(strokeWidth: 2.h),
                  )
                      : Icon(Icons.send_rounded, size: 24.sp, color: Colors.black45),
                  onPressed: chatBotController.isGeneratingResponse.value ? null : onSend,
                )
                )
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
        style: TextStyle(fontSize: 16.sp, color: txtColor, height: 1.5),
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
          image: AssetImage('assets/images/home/img_1.png'),
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
