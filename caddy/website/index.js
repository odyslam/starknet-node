let logsStreaming = false;
NETDATA.options.current.stop_updates_when_focus_is_lost = false;
window.onload = async () => {
  const textarea = document.getElementById('logs');
  try {
    streamLogs(textarea);
  } catch (error) {
    console.error(error);
    location.reload();
  }
  setInterval(checkLogStream, 1000 * 10, textarea);

}

function checkLogStream(textarea) {
  if (!logsStreaming || textarea.value == "") {
    streamLogs();
  }
}

async function streamLogs(textarea) {
  data = {"follow": true, "all": false, "format": "short"};
  fetch('../supervisor/logs', {
    method: 'POST', body: JSON.stringify(data),
    headers: {
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
      'Transfer-Encoding': 'chunked'

    }
  })
    // Retrieve its body as ReadableStream
    .then(response => {
      const reader = response.body.getReader();
      return new ReadableStream({
        start(controller) {
          return pump();
          function pump() {
            return reader.read().then(({done, value}) => {
              // When no more data needs to be consumed, close the stream
              if (done) {
                controller.close();
                logsStreaming = false;
                return;
              }
              // Enqueue the next data chunk into our target stream
              let line = String.fromCharCode.apply(null, value);
              // For some reason, the test is so slow, the function fails completely
              // if (!'/balenad|kernel|NetworkManager|avahi|systemd/'.test(line)) {
              //   textarea.value += line;
              // }
              textarea.value += line;
              logsStreaming = true;
              if (textarea != document.activeElement) {
                textarea.scrollTop = textarea.scrollHeight;
              }
              return pump();
            });
          }
        }
      })
    })
}
