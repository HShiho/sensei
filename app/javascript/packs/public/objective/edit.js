function formSwitch() {
  let btnHide = document.getElementById("hide");
  let objectivePost = document.getElementById("objective-post");

  if (btnHide.checked) {
  // 「いいえ」が選択されたら以下を実行
    objectivePost.style.display = "none";
  } else {
  // 「はい」が選択されたら以下を実行
    objectivePost.style.display = "";
  }
}