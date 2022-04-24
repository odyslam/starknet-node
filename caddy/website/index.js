window.onload = async () => {
  const res = await fetch("deviceLogs.txt");
  let logs = await res.text();
  if (logs == "") {
  } else {
    const logsLoop = setInterval(loadLogs, 1000);
  };
}
async function loadLogs() {
  const res = await fetch("deviceLogs.txt");
  let logs = await res.text();
  const textarea = document.getElementById('logs');
  if (textarea != document.activeElement) {
    textarea.scrollTop = textarea.scrollHeight;
  }
  textarea.value = logs;

}
