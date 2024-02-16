document.addEventListener('DOMContentLoaded', function() {
  const newGenreBtn = document.getElementById('newGenreBtn');
  const existingGenreBtn = document.getElementById('existingGenreBtn');
  const newGenreInput = document.getElementById('newGenreInput');
  const existingGenreSelect = document.getElementById('existingGenreSelect');
  const form = document.getElementById('NewPostForm');
  const submitBtn = document.getElementById('submitBtn');

  // 新規ボタン
  newGenreBtn.addEventListener('click', function() {
    newGenreInput.style.display = 'block';
    existingGenreSelect.style.display = 'none';
  });

  // 既存ボタン
  existingGenreBtn.addEventListener('click', function() {
    newGenreInput.style.display = 'none';
    existingGenreSelect.style.display = 'block';
  });

  // フォーム内の全入力フィールドにinputイベントリスナーを追加
  const inputs = form.querySelectorAll('input, select, textarea');
  inputs.forEach(input => {
    input.addEventListener('input', function() {
      // 入力フィールドに何らかの変更があったときの処理
      // 例えば、フォームのバリデーション状態をチェックし、
      // ボタンのdisabled状態を更新するなど
      if (form.checkValidity()) {
        submitBtn.disabled = false; // フォームが有効ならボタンを有効化
      } else {
        submitBtn.disabled = true; // フォームが無効ならボタンを無効化
      }
    });
  });

  // フォーム送信時の処理
  form.addEventListener('submit', function(event) {
    const newGenreValue = newGenreInput.querySelector('input').value.trim();
    const existingGenreValue = existingGenreSelect.querySelector('select').value;

    if ((!newGenreValue && !existingGenreValue) || !form.checkValidity()) {
      event.preventDefault(); // フォームの送信を阻止
      alert('既存の魚を選択するか、新規の魚を入力してください');
      form.classList.add('was-validated');
    }
  });
});
