window.onload = async () => {
  try {
    streamLogs();
  } catch (error) {
    console.error(error);
    location.reload();
  }
}


async function streamLogs() {
  const textarea = document.getElementById('logs');
  fetch('../supervisor/logs', {method: 'POST'})
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
                if (textarea.value == "") {
                  textarea.value = "Could not stream logs. If the starknet node runs on regular Docker and not balena, that is normal.\n If it runs on balena, please refresh or open a GH issue"
                }
                else {
                  window.alert("Starknet Node can't stream logs from the balena supervisor. Please refresh the dashboard. If the error persists, please open a GH issue");
                }
                return;
              }
              // Enqueue the next data chunk into our target stream
              textarea.value = String.fromCharCode.apply(null, value);
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
