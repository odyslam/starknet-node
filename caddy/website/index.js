window.onload = async () => {
  const res = await fetch("deviceLogs.txt");
  let logs = await res.text();
  if (logs == "") {
  } else {
    const logsLoop = setInterval(loadLogs, 3000);
  };
  NETDATA.options.current.stop_updates_when_focus_is_lost = false;
}
async function loadLogs() {
  const res = await fetch("../device/logs.txt", {method: 'GET'});
  let logs = await res.text();
  const textarea = document.getElementById('logs');
  if (textarea != document.activeElement) {
    textarea.scrollTop = textarea.scrollHeight;
  }
  textarea.value = logs;
}
