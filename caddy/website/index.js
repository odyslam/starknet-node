window.onload = async () => {
  const res = await fetch("deviceLogs.txt");
  let logs = await res.text();
  if (logs == "") {
  } else {
    const logsLoop = setInterval(loadLogs, 1000);
  };
  NETDATA.options.current.stop_updates_when_focus_is_lost = false
}
async function loadLogs() {
  let myHeaders = new Headers();
  let creds = btoa("CADDY_USERNAME:CADDY_PASSWORD");
  myHeaders.append("Authorization", `basic ${creds}`);
  const res = await fetch("deviceLogs.txt", {method: 'GET', headers: myHeaders});
  let logs = await res.text();
  const textarea = document.getElementById('logs');
  if (textarea != document.activeElement) {
    textarea.scrollTop = textarea.scrollHeight;
  }
  textarea.value = logs;
}
