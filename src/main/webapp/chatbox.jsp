<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    /* Nút mở chat */
    .chat-btn {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 60px;
        height: 60px;
        background-color: #436e62;
        color: white;
        border-radius: 50%;
        text-align: center;
        line-height: 60px;
        font-size: 24px;
        cursor: pointer;
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        z-index: 9999;
        transition: transform 0.3s;
        margin-bottom: 50px;
    }
    .chat-btn:hover { transform: scale(1.1); }

    /* Khung chat */
    .chat-box {
        position: fixed;
        bottom: 90px;
        right: 20px;
        width: 350px;
        height: 450px;
        background: white;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        z-index: 9999;
        display: none; /* Mặc định ẩn */
        flex-direction: column;
        overflow: hidden;
        border: 1px solid #ddd;
        margin-bottom: 50px;
    }

    /* Header */
    .chat-header {
        background: #436e62;
        color: white;
        padding: 15px;
        font-weight: bold;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    /* Body (Chứa tin nhắn) */
    .chat-body {
        flex: 1;
        padding: 10px;
        overflow-y: auto;
        background: #f8f9fa;
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    /* Tin nhắn */
    .message {
        max-width: 80%;
        padding: 8px 12px;
        border-radius: 15px;
        font-size: 14px;
        line-height: 1.4;
    }
    .bot-message {
        background: #e9ecef;
        color: #333;
        align-self: flex-start;
        border-bottom-left-radius: 2px;
    }
    .user-message {
        background: #436e62;
        color: white;
        align-self: flex-end;
        border-bottom-right-radius: 2px;
    }

    /* Footer (Input) */
    .chat-footer {
        padding: 10px;
        border-top: 1px solid #ddd;
        display: flex;
        gap: 5px;
        background: white;
    }
    .chat-footer input {
        flex: 1;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 20px;
        outline: none;
    }
    .chat-footer button {
        background: #436e62;
        color: white;
        border: none;
        border-radius: 50%;
        width: 35px;
        height: 35px;
        cursor: pointer;
    }
    
    /* Loading animation */
    .typing { font-style: italic; font-size: 12px; color: #888; display: none;}
</style>

<div class="chat-btn" onclick="toggleChat()">
    <i class="bi bi-chat-dots-fill"></i>
</div>

<div class="chat-box" id="chatBox">
    <div class="chat-header">
        <span><i class="bi bi-robot"></i> Trợ lý ảo AI</span>
        <span onclick="toggleChat()" style="cursor: pointer;"><i class="bi bi-x-lg"></i></span>
    </div>
    
    <div class="chat-body" id="chatBody">
        <div class="message bot-message">
            Xin chào! Tôi có thể giúp gì cho bạn về đặt phòng hôm nay?
        </div>
    </div>
    <div class="typing ps-3 pb-2" id="typingIndicator">AI đang trả lời...</div>

    <div class="chat-footer">
        <input type="text" id="chatInput" placeholder="Nhập tin nhắn..." onkeypress="handleEnter(event)">
        <button onclick="sendMessage()"><i class="bi bi-send-fill"></i></button>
    </div>
</div>

<script>
    function toggleChat() {
        var box = document.getElementById("chatBox");
        if (box.style.display === "none" || box.style.display === "") {
            box.style.display = "flex";
        } else {
            box.style.display = "none";
        }
    }

    function handleEnter(e) {
        if (e.key === "Enter") sendMessage();
    }

    function sendMessage() {
        var input = document.getElementById("chatInput");
        var message = input.value.trim();
        if (message === "") return;

        // 1. Hiển thị tin nhắn người dùng
        appendMessage(message, "user-message");
        input.value = "";

        // 2. Hiển thị trạng thái đang nhập
        document.getElementById("typingIndicator").style.display = "block";
        scrollToBottom();

        // 3. Gửi AJAX đến Servlet
        fetch('<%= request.getContextPath() %>/api/chatbot', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
            },
            body: 'message=' + encodeURIComponent(message)
        })
        .then(response => response.text())
        .then(data => {
            // 4. Nhận phản hồi từ Gemini và hiển thị
            document.getElementById("typingIndicator").style.display = "none";
            // Xử lý text thô từ Gemini (loại bỏ quote nếu có)
            let cleanData = data.replace(/^"|"$/g, '').replace(/\\n/g, '<br>');
            appendMessage(cleanData, "bot-message");
        })
        .catch(error => {
            console.error('Error:', error);
            document.getElementById("typingIndicator").style.display = "none";
            appendMessage("Lỗi kết nối, vui lòng thử lại.", "bot-message");
        });
    }

    function appendMessage(text, className) {
        var chatBody = document.getElementById("chatBody");
        var div = document.createElement("div");
        div.className = "message " + className;
        div.innerHTML = text; // Dùng innerHTML để hỗ trợ thẻ <br>
        chatBody.appendChild(div);
        scrollToBottom();
    }

    function scrollToBottom() {
        var chatBody = document.getElementById("chatBody");
        chatBody.scrollTop = chatBody.scrollHeight;
    }
</script>