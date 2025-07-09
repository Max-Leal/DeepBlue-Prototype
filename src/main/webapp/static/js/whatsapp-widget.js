document.addEventListener('DOMContentLoaded', function () {
  const html = `
    <button id="openChatBtn" style="display:none;position:fixed;bottom:20px;right:20px;background:#25d366;border:none;border-radius:50%;width:60px;height:60px;color:white;cursor:pointer;box-shadow:0 4px 8px rgba(0,0,0,0.3);z-index:1000;opacity:1;transition:opacity 0.3s ease;display:flex;align-items:center;justify-content:center;">
      <img src="https://upload.wikimedia.org/wikipedia/commons/5/5e/WhatsApp_icon.png" alt="WhatsApp" style="width:32px; height:32px;">
    </button>
    <div id="whatsappChatPopup" style="display:flex;position:fixed;bottom:90px;right:20px;width:320px;height:400px;background:#ECE5DD;border-radius:12px;box-shadow:0 4px 12px rgba(0,0,0,0.2);font-family:Arial,sans-serif;flex-direction:column;overflow:hidden;z-index:1000;">
      <div style="background:#075E54;color:white;padding:12px;font-weight:bold;font-size:16px;display:flex;justify-content:space-between;align-items:center;">
        Atendimento WhatsApp
        <button id="closeChatBtn" style="background:transparent;border:none;color:white;font-size:20px;cursor:pointer;line-height:1;">×</button>
      </div>
      <div id="chatMessages" style="flex:1;padding:10px;display:flex;flex-direction:column;justify-content:flex-end;overflow-y:auto;">
        <div style="background:white;padding:8px 12px;border-radius:20px 20px 20px 0;margin-bottom:8px;max-width:80%;align-self:flex-start;font-size:14px;color:#222;">Olá! Como podemos ajudar você hoje?</div>
        <div style="background:white;padding:8px 12px;border-radius:20px 20px 20px 0;margin-bottom:8px;max-width:80%;align-self:flex-start;font-size:14px;color:#222;">Temos promoções exclusivas neste mês!</div>
        <div style="background:#DCF8C6;padding:8px 12px;border-radius:20px 20px 0 20px;max-width:80%;align-self:flex-end;font-size:14px;color:#222;">Quero saber mais!</div>
      </div>
      <div id="chatFooter" style="background:white;padding:10px;border-top:1px solid #ccc;display:flex;align-items:center;gap:8px;">
        <input type="text" id="messageInput" placeholder="Digite sua mensagem..." style="flex:1;padding:8px 12px;border-radius:20px;border:1px solid #ccc;font-size:14px;outline:none;" />
        <button id="sendBtn" style="background:#25d366;border:none;border-radius:50%;width:40px;height:40px;cursor:pointer;display:flex;justify-content:center;align-items:center;">
          <svg xmlns="http://www.w3.org/2000/svg" fill="white" viewBox="0 0 24 24" width="20px" height="20px">
            <path d="M2.01 21L23 12 2.01 3 2 10l15 2-15 2z"/>
          </svg>
        </button>
      </div>
    </div>
    <style>
      @keyframes blink {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.4; }
      }
    </style>
  `;

  document.body.insertAdjacentHTML("beforeend", html);

  const sendBtn = document.getElementById('sendBtn');
  const messageInput = document.getElementById('messageInput');
  const openBtn = document.getElementById('openChatBtn');
  const closeBtn = document.getElementById('closeChatBtn');
  const chatPopup = document.getElementById('whatsappChatPopup');
  const phone = "5547984656291"; // trocar para o seu número de WhatsApp

  sendBtn.addEventListener('click', () => {
    const msg = messageInput.value.trim();
    if (msg.length === 0) {
      alert("Por favor, digite uma mensagem.");
      return;
    }
    const url = `https://wa.me/${phone}?text=${encodeURIComponent(msg)}`;
    window.open(url, "_blank");
  });

  openBtn.addEventListener('click', () => {
    chatPopup.style.display = 'flex';
    openBtn.style.display = 'none';
  });

  closeBtn.addEventListener('click', () => {
    chatPopup.style.display = 'none';
    openBtn.style.display = 'block';
  });

  openBtn.style.display = 'none';
  chatPopup.style.display = 'flex';
});