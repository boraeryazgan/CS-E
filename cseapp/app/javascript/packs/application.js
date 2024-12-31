// app/javascript/packs/application.js

function addFriend(userId) {
    let csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  
    fetch(`/users/${userId}/add_friend`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken,
      },
      body: JSON.stringify({ user_id: userId }) // Gönderilecek veri
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        alert('Arkadaş eklendi!');
      } else {
        alert('Bir hata oluştu.');
      }
    })
    .catch(error => {
      console.error('Hata:', error);
    });
  }